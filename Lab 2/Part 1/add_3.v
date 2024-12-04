`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/12/2024 04:03:45 PM
// Design Name: 
// Module Name: add_3
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


module add_3(
    input [3:0] a,
    output reg [3:0] s
    );
    always @(a)
    begin
    if (a > 4'b0100)
    begin
        s = a + 4'b0011;
    end
    else
    begin
        s = a;
    end
    end
    
    
    
endmodule
