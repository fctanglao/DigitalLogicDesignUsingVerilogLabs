`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/12/2024 04:36:11 PM
// Design Name: 
// Module Name: bin2bcd
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


module bin2bcd(
    input [7:0] bin,
    output [11:0] bcd
    );
    
    wire [3:0] s0, s1, s2, s3;
    wire [2:0] s5;
    
    assign bcd[0] = bin[0];
    assign bcd[10] = 1'b0;
    assign bcd[11] = 1'b0;
    
    add_3 a0 (
    .a({1'b0, bin[7:5]}),
    .s(s0)
    );
    
    add_3 a1 (
    .a({s0[2:0], bin[4]}),
    .s(s1)
    );
    
    add_3 a2 (
    .a({s1[2:0], bin[3]}),
    .s(s2)
    );
    
    add_3 a3 (
    .a({s2[2:0], bin[2]}),
    .s(s3)
    );
    
    add_3 a4 (
    .a({s3[2:0], bin[1]}),
    .s(bcd[4:1])
    );
    
    add_3 a5 (
    .a({1'b0, s0[3], s1[3], s2[3]}),
    .s({bcd[9], s5})
    );
    
    add_3 a6 (
    .a({s5, s3[3]}),
    .s(bcd[8:5])
    );
    
    
    
    
    
    
    
    
endmodule
