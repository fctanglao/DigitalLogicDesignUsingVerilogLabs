`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/19/2024 02:36:12 PM
// Design Name: 
// Module Name: first_sseg_driver
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


module first_sseg_driver(
    input [2:0] active_digit,
    input [3:0] num,
    input DP_control,
    output [6:0] sseg,
    output [7:0] an,
    output DP
    );
    
    wire [7:0] cath;
    assign DP = DP_control;
    
    decoder_generic #(.N(3)) decoder1(
        .w(active_digit),
        .en(1'b1),
        .y(cath)
    );
    
    assign an = ~cath;
    
    hex2sseg sseg1(
        .hex(num),
        .sseg(sseg)
    );
    
    
endmodule
