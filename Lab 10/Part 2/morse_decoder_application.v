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
    input b, clk, reset_n,
    output DP,
    output [6:0] sseg,
    output [7:0] AN
    );
    
    wire dot, dash;
    morse_decoder(
        .b(b),
        .clk(clk),
        .reset_n(reset_n),
        .dot(dot),
        .dash(dash),
        .lg(),
        .wg()
    );
    
    wire [4:0] shift_reg;
    wire enshift;
    assign enshift = (dot ^ dash);
    shift_register #(.N(5)) (
        .clk(clk),
        .reset_n(reset_n),
        .SI(dash),
        .shift(enshift),
        .SO(),
        .Q_reg(shift_reg)
    );
    
    wire [2:0] counter_out;
    udl_counter #(.BITS(3)) (
        .clk(clk),
        .reset_n(reset_n),
        .enable(enshift),
        .up(1'b1),
        .load(counter_out==3'd5),
        .D(3'b0),
        .Q(counter_out)
        
    );
    
    
    
    sseg_driver(
        .clk(clk),
        .reset_n(reset_n),
        .i0({counter_out >= 1,{3'd0, shift_reg[0]},1'b1}),
        .i1({counter_out >= 2,{3'd0, shift_reg[1]},1'b1}),
        .i2({counter_out >= 3,{3'd0, shift_reg[2]},1'b1}),
        .i3({counter_out >= 4,{3'd0, shift_reg[3]},1'b1}),
        .i4({counter_out >= 5,{3'd0, shift_reg[4]},1'b1}),
        .i5(),
        .i6(),
        .i7({1'b1,{1'b0, counter_out},1'b1}),
        .DP(DP),
        .sseg(sseg),
        .AN(AN)
    );
    
endmodule
