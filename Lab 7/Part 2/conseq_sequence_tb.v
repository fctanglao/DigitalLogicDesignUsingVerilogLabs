`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/18/2024 03:37:28 PM
// Design Name: 
// Module Name: conseq_sequence_tb
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


module conseq_sequence_tb(

    );
    
    conseq_sequence uut (
        .clk(clk),
        .reset_n(reset_n),
        .x(x),
        .y(y),
        .state_reg(state_reg)
    );
    
    reg clk, reset_n, x;
    wire y;
    wire [2:0] state_reg;
    
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
    reset_n=1'b0;
    x=1'b0;
    @(negedge clk);
    reset_n = 1'b1;
    
    #10
    
    for(integer k = 0; k<5; k=k+1)
    begin
        x=1'b1;
        #10;
    end
    x=1'b0;

    #10
    
    reset_n=1'b0;
    x=1'b0;
    #20
    @(negedge clk);
    reset_n = 1'b1;
    #10
    #10 x=1'b1;
    #10 x=1'b0;
    #10 x=1'b1;
    #10 x=1'b1;
    #10 x=1'b0;
    #10 x=1'b1;
    #10 x=1'b1;
    #10 x=1'b0;

    #150 $stop;
    
    end 
endmodule
