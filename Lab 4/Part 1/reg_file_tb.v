`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/03/2024 04:33:36 PM
// Design Name: 
// Module Name: reg_file_tb
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


    module reg_file_tb(

    );
    
    reg_file #(.N(7), .BITS(4)) uut(
        .clk(clk),
        .we(we),
        .address_w(address_w),
        .address_r(address_r),
        .data_w(data_w),
        .data_r(data_r)

    );
    
    reg clk, we;
    reg [127:0] address_w, address_r;
    reg [3:0] data_w;
    wire [3:0] data_r;

    
    localparam T = 10;
    always
    begin
        clk = 1'b0;
        #(T / 2);
        clk = 1'b1;
        #(T / 2);
    end
    initial
    begin
        
        
        address_w = 127'b10;
        address_r = 127'b10;
        data_w = 4'b0001;
        
        repeat(3) @(negedge clk);
        we = 1'b1;
        repeat(5) @(negedge clk);
        
        #10
        
        address_w = 127'b11;
        address_r = 127'b11;
        data_w = 4'b1001;
        
        #20 $stop; 
       
    end
    
    
    
endmodule
