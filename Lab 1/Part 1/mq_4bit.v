`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/31/2024 05:00:54 PM
// Design Name: 
// Module Name: mq_4bit
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


module mq_4bit(
    input [3:0] m,
    input q,
    output [3:0] mq
    );
    generate
        genvar k;
        
        for (k = 0; k < 4; k = k + 1)
        begin: multiplybits
            
            assign mq[k] = m[k] & q;
            
        end
    endgenerate
endmodule
