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
    input clk, reset_n,
    output DP,
    output [6:0] sseg,
    output [0:7] AN

    );
    

    
    wire [2:0] counter_out;
    wire enablecount;
    
    timer_parameter #(.FINAL_VALUE(41666)) timer0 (
        .clk(clk),
        .reset_n(reset_n),
        .enable(1'b1),
        .done(enablecount)
    );
    
    udl_counter #(.BITS(3)) counter0 (
        .clk(clk),
        .reset_n(reset_n),
        .enable(enablecount),
        .up(1'b1),
        .load(1'b0),
        .D(3'b0),
        .Q(counter_out)
    );
    
    wire [3:0] num;
    assign num = ({1'b0, counter_out});
    
    first_sseg_driver driver1 (
        .active_digit(counter_out),
        .num(num),
        .DP_control(1'b1),
        .sseg(sseg),
        .an(AN),
        .DP(DP)
    );
    
endmodule
