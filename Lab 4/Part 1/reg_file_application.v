`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/28/2024 04:35:36 PM
// Design Name: 
// Module Name: reg_file_application
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


module reg_file_application(
    input [7:0] address_rw,
    input WE, clk,
    input [3:0] data_w,
    output [6:0] data_r,
    output [8:0] AN
    );
    
    assign AN = 9'b111111110;
    
    reg [6:0] demux_w, demux_r;
    
    always @(address_rw)
    begin
        if (address_rw[7] == 1'b1)
            demux_r = address_rw[6:0];
        else
            demux_w = address_rw[6:0];
    end
    
    wire enable_w;
    button b1(
        .clk(clk),
        .in(WE),
        .out(enable_w)
    );
    
    wire [3:0] hex;
    
    reg_file #(.N(7), .BITS(4)) reg_4bit_128(
        .clk(clk),
        .we(enable_w),
        .address_w(demux_w),
        .address_r(demux_r),
        .data_w(data_w),
        .data_r(hex)
    );
    
    hex2sseg sseg1(
        .hex(hex),
        .sseg(data_r)
    );
endmodule
