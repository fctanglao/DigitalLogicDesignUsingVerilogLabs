`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/06/2024 03:54:26 PM
// Design Name: 
// Module Name: sseg_driver
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


module sseg_driver(
    input clk,
    input reset_n,
    input [5:0] i0, i1, i2, i3, i4, i5, i6, i7,
    output [6:0] sseg,
    output [0:7] AN,
    output DP
    );
    
    wire enablecount;
    wire [2:0] count_out;
    wire [5:0] d_out;
    wire [7:0] CA;
    
    mux_8x1_6bit m0(
        .i0(i0),
        .i1(i1),
        .i2(i2),
        .i3(i3),
        .i4(i4),
        .i5(i5),
        .i6(i6),
        .i7(i7),
        .s(count_out),
        .d_out(d_out)
    );
    
    timer_parameter #(.FINAL_VALUE(41666)) t0(
        .clk(clk),
        .reset_n(reset_n),
        .enable(1'b1),
        .done(enablecount)
    );
    
    udl_counter #(.BITS(3)) u0(
        .clk(clk),
        .reset_n(reset_n),
        .enable(enablecount),
        .up(1'b1),
        .load(1'b0),
        .D(3'b000),
        .Q(count_out)
    );
    
    decoder_generic #(.N(3)) d0(
        .w(count_out),
        .en(d_out[5]),
        .y(CA)
    );
    
    assign AN = ~CA;
    
    hex2sseg h0(
        .hex(d_out[4:1]),
        .sseg(sseg)
    );
    
     assign DP = d_out[0];
endmodule
