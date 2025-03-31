`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/06/2024 04:44:46 PM
// Design Name: 
// Module Name: mux_8x1_nbit
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


module mux_8x1_nbit #(parameter N = 3) (
    input [N-1:0] w0, w1, w2, w3, w4, w5, w6, w7,
    input [2:0] s,
    output [N-1:0] f
    );
    
    wire [N-1:0] f1, f0;
    mux_4x1_nbit #(.N(N)) m0 (
        .w0(w7),
        .w1(w6),
        .w2(w5),
        .w3(w4),
        .s(s [1:0]),
        .f(f1)
    );
    
    mux_4x1_nbit #(.N(N)) m1 (
        .w0(w3),
        .w1(w2),
        .w2(w1),
        .w3(w0),
        .s(s[1:0]),
        .f(f0)
    );
    
    mux_2x1_nbit #(.N(N)) m3 (
        .w0(f0),
        .w1(f1),
        .s(s[2]),
        .f(f)
    );
endmodule
