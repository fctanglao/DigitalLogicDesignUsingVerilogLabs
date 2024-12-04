`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/05/2024 04:17:40 PM
// Design Name: 
// Module Name: mux_2x1_8bit
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


module mux_2x1_8bit(
    input s, 
    input [7:0] x, y,
    output [7:0] m
    );
    
    
    
    generate
        genvar k;
        
        for (k = 0; k < 8; k = k + 1)
        begin: stage
            
            mux_2x1_simple(
            .x(x[k]),
            .y(y[k]),
            .s(s),
            .f(m[k])
            );
            
        end
    endgenerate
    
endmodule
