`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/06/2024 05:58:43 PM
// Design Name: 
// Module Name: counter_application
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


module counter_application(
    input clk,
    input reset_n,
    input load,
    input up,
    input down,
    input [7:0] SW,
    output [6:0] sseg,
    output [0:7] AN,
    output DP
    );
    
    reg updown;
    
    wire [7:0] count_out;
    wire [11:0] bcd;
    wire up_out;
    wire down_out;
    
    button b_up(
        .clk(clk),
        .in(up),
        .out(up_out)
    );
    
    button b_down(
        .clk(clk),
        .in(down),
        .out(down_out)
    );
    
    always@(*)
    begin
        updown = 1'b0;
        if (up_out == 1'b1)
        begin
            updown = 1'b1;
        end
        if (down_out == 1'b1)
        begin
            updown = 1'b0;
        end
    end
    
    udl_counter #(.BITS(8)) u0(
        .clk(clk),
        .reset_n(reset_n),
        .enable(up_out | down_out | load),
        .up(updown),
        .load(load),
        .D(SW),
        .Q(count_out)
    );
    
    bin2bcd b0(
        .bin(count_out),
        .bcd(bcd)
    );
    
    sseg_driver s0(
        .clk(clk),
        .reset_n(reset_n),
        .i0({1'b1, bcd[3:0], 1'b1}),
        .i1({1'b1, bcd[7:4], 1'b1}),
        .i2({1'b1, bcd[11:8], 1'b1}),
        .i3(),
        .i4(),
        .i5(),
        .i6(),
        .i7(),
        .sseg(sseg),
        .AN(AN),
        .DP(DP)
    );
endmodule
