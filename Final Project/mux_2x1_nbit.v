`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/06/2024 04:37:29 PM
// Design Name: 
// Module Name: mux_2x1_nbit
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


module mux_2x1_nbit #(parameter N = 3)(
    input [N - 1: 0] w0, w1,
    input s,
    output reg [N - 1: 0] f
    );
    
    always @(w0, w1, s)
    begin
        case(s)
            1'b0: f = w0;
            1'b1: f = w1;
            default: f = 'bx;
        endcase
    end
    
endmodule

