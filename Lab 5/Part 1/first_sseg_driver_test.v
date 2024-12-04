`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/21/2024 02:44:49 PM
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
    input clk,
    input reset_n,
    output [6:0] sseg,
    output [0:7] AN,
    output DP 
    );
    
    wire enablecount;
    // 3 bit bc udl counts from 0 (0000) - 7 (0111)
    wire [2:0] count_out;
    wire [3:0] num;
    // concatenante a 0 to make it 4 bits
    // concatenate 1'b0 to MSB because it maxes it to 0111 which is 0 to 7
    assign num = ({1'b0, count_out});
    
    first_sseg_driver f0(
        .active_digit(count_out),
        .num(num),
        .dp_ctrl(1'b0),
        .sseg(sseg),
        .an(AN),
        .dp(DP)
    );
    
    timer_parameter #(.FINAL_VALUE(41666)) t0(
        .clk(clk),
        .reset_n(reset_n),
        .enable(1'b1),
        .done(enablecount)
    );
    
    udl_counter #(.BITS(3)) u0(
        .clk(clk),
        .reset_n(reset_n),
        .enable(enablecount),
        .up(1'b1),
        .load(1'b0),
        .D(3'b000),
        .Q(count_out)
    );
endmodule
