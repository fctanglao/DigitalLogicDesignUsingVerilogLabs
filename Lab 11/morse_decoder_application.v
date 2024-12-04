`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2024 02:50:23 PM
// Design Name: 
// Module Name: morse_decoder_application
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module morse_decoder_application(
    input b, clk, reset_n, buttonfifo,
    output DP, empty,
    output [6:0] sseg,
    output [7:0] AN
    );
    
    
    wire dot, dash, lg, wg;
    
    morse_decoder_2 fsm_morse(
        .b(b),
        .clk(clk),
        .reset_n(reset_n),
        .dot(dot),
        .dash(dash),
        .lg(lg),
        .wg(wg)
    );
    
    wire resetgap, resetgapnot;
    assign resetgap = (lg | wg);
    assign resetgapnot = ~resetgap;
    
    wire [4:0] symbol;
    wire enshift;
    assign enshift = (dot ^ dash);
    shift_register #(.N(5)) shiftreg0(
        .clk(clk),
        .reset_n(reset_n & resetgapnot),
        .SI(dash),
        .shift(enshift),
        .SO(),
        .Q_reg(symbol)
    );
    
    wire [2:0] symbol_count;
    udl_counter #(.BITS(3)) countmorse(
        .clk(clk),
        .reset_n(reset_n & resetgapnot),
        .enable(enshift),
        .up(1'b1),
        .load(symbol_count==3'd5),
        .D(3'b0),
        .Q(symbol_count)
        
    );
    
    wire wg_delayed;
    
    D_FF delaywg(
        .clk(clk),
        .D(wg),
        .reset_n(reset_n),
        .Q(wg_delayed)
    );
    
    wire [7:0] romaddr;
    
    mux_2x1_nbit #(.N(8)) mux0(
        .s(wg),
        .w0({symbol_count, symbol}),
        .w1(8'b11100000),
        .f(romaddr)
    );
    
    wire [7:0] dinfifo;
    synch_rom ascii(
        .clk(clk),
        .addr(romaddr),
        .data(dinfifo)
    
    );
    
    wire full;
    wire [7:0] dout;
    
    button bf (
        .clk(clk),
        .reset_n(reset_n),
        .noisy(buttonfifo),
        .debounced(),
        .p_edge(buttonfifo_db),
        .n_edge(),
        ._edge()
    );
    wire srst;
    assign srst = ~reset_n;
    fifo_generator_0 fifo0 (
        .clk(clk),      // input wire clk
        .srst(srst),    // input wire srst
        .din(dinfifo),      // input wire [7 : 0] din
        .wr_en(~full & (lg | wg | wg_delayed)),  // input wire wr_en
        .rd_en(buttonfifo_db),  // input wire rd_en
        .dout(dout),    // output wire [7 : 0] dout
        .full(full),    // output wire full
        .empty(empty)  // output wire empty
    );
    
    sseg_driver sseg0(
        .clk(clk),
        .reset_n(reset_n),
        .i0({1'b1,dout[3:0],1'b1}),
        .i1({1'b1,dout[7:4],1'b1}),
        .i2({1'b0,{3'd0, dout[2]},1'b1}),
        .i3({1'b0,{3'd0, dout[3]},1'b1}),
        .i4({1'b0,{3'd0, dout[4]},1'b1}),
        .i5({1'b0,{3'd0, dout[5]},1'b1}),
        .i6({1'b0,{3'd0, dout[6]},1'b1}),
        .i7({1'b0,{3'd0, dout[7]},1'b1}),
        .DP(DP),
        .sseg(sseg),
        .AN(AN)
    );
    
endmodule
