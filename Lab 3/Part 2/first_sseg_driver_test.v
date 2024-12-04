`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/19/2024 03:32:15 PM
// Design Name: 
// Module Name: first_sseg_driver_test
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


module first_sseg_driver_test(
    input [2:0] SW,
    input DP_control,
    output DP,
    output [6:0] sseg,
    output [0:7] an
    );
    
    wire [3:0] num;
    assign num = ({1'b0, SW[2:0]});
    
    first_sseg_driver driver1(
        .active_digit(SW),
        .num(num),
        .DP_control(DP_control),
        .sseg(sseg),
        .an(an),
        .DP(DP)
    );
    
endmodule
