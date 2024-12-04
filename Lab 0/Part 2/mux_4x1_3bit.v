`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/29/2024 03:59:10 PM
// Design Name: 
// Module Name: mux_4x1_3bit
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


module mux_4x1_3bit(
    input [2:0] x, [2:0] y, [2:0] z, [2:0] w,
    input s0, s1,
    output [2:0] m,
    output s0LED, s1LED
    );
    
    assign s0 = s0LED;
    assign s1 = s1LED;
    
    wire [2:0] f, g;
    
    mux_2x1_3bit M0(x, y, s0, f);
    mux_2x1_3bit M1(z, w, s0, g);
    mux_2x1_3bit M2(f, g, s1, m);
    
endmodule
