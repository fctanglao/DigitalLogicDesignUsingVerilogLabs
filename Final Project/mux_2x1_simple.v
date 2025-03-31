`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/05/2024 03:31:06 PM
// Design Name: 
// Module Name: mux_2x1_simple
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

module mux_2x1_simple(
    input x, y, s,
    output reg f
    );
    
    always @(x, y, s)
    
    begin 
        if (s)
        begin
            f=y;
        end
        else
        begin
            f=x;
        end
    
    end


endmodule
