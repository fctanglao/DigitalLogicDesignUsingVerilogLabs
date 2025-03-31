`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/06/2024 04:52:38 PM
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
    input clk, reset_n,
    input [8:0] i0, i1, i2, i3, i4, i5, i6, i7,
    output DP,
    output [6:0] sseg,
    output [0:7] AN
    );
    
    wire [9:0] D_out;
    wire [2:0] counter_out;
    wire enablecount;
    
    timer_parameter #(.FINAL_VALUE(41666)) timer0 (
        .clk(clk),
        .reset_n(reset_n),
        .enable(1'b1),
        .done(enablecount)
    );
    
    udl_counter #(.BITS(3)) counter0 (
        .clk(clk),
        .reset_n(reset_n),
        .enable(enablecount),
        .up(1'b1),
        .load(1'b0),
        .D(3'b0),
        .Q(counter_out)
    );
    
    mux_8x1_nbit #(.N(9)) m0 (
        .w0(i4),
        .w1(i5),
        .w2(i6),
        .w3(i7),
        .w4(i0),
        .w5(i1),
        .w6(i2),
        .w7(i3),
        .s(counter_out),
        .f(D_out)
    );
   
    wire [7:0] CATH;
    
    decoder_generic #(.N(3)) d0 (
        .w(counter_out),
        .en(D_out[8]),
        .y(CATH)
    );
    
    assign AN = ~CATH;
    
    assign sseg = D_out[7:1];
    
    assign DP = D_out[0];
    
endmodule
