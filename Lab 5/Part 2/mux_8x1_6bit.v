`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/06/2024 05:18:39 PM
// Design Name: 
// Module Name: mux_8x1_6bit
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


module mux_8x1_6bit(
    input [5:0] i0, i1, i2, i3, i4, i5, i6, i7,
    input [2:0] s,
    output reg [5:0] d_out
    );
    
    always @(*)
    begin
        case(s)
        3'b000: d_out = i0;
        3'b001: d_out = i1;
        3'b010: d_out = i2;
        3'b011: d_out = i3;
        3'b100: d_out = i4;
        3'b101: d_out = i5;
        3'b110: d_out = i6;
        3'b111: d_out = i7;
        default: d_out = 1'b0;
        endcase
    end
endmodule
