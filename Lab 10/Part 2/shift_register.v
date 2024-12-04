`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2024 02:40:46 PM
// Design Name: 
// Module Name: shift_register
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


module shift_register #(parameter N=4)
    (
        input clk,
        input reset_n,
        input SI,
        input shift,
        output SO,
        output reg [N-1:0] Q_reg
    );
    
    reg [N-1:0] Q_next;
    always @(posedge clk, negedge reset_n)
    begin
        if (!reset_n)
            Q_reg <= 'b0;
        else
            Q_reg <= Q_next;
    end
    
    always @(shift, SI, Q_reg)
    begin
        if(shift)
            Q_next <= {Q_reg[N-2:0], SI};
        else
            Q_next <= Q_reg;
    end
    
    assign SO = Q_reg[N-1];
    
endmodule
