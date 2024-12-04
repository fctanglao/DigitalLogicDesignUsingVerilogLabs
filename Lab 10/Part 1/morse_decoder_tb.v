`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/22/2024 02:36:08 PM
// Design Name: 
// Module Name: morse_decoder_tb
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


module morse_decoder_tb(

    );
    reg clk, reset_n, b;
    wire dot, dash, lg, wg;
    
    morse_decoder uut (
        .b(b),
        .clk(clk),
        .reset_n(reset_n),
        .dot(dot),
        .dash(dash),
        .lg(lg),
        .wg(wg)
    );
    
    localparam T = 2;
    always
    begin
        clk = 1'b0;
        #(T / 2);
        clk = 1'b1;
        #(T / 2);
    end
    
    initial
    begin
        b=1'b0;
        reset_n=1'b0;
        #50 reset_n=1'b1;
        #30 b = 1'b1;
        #300
        b=1'b1;
        #50
        b=1'b1;
        #100
        b=1'b1;
        #100 b=1'b0;
        #200
        b=1'b1;
        #200
        b=1'b0;
        #800
        b=1'b1;
        #50
        b=1'b0;
       
    end
    
    
endmodule
