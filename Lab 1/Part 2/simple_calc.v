`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/05/2024 03:50:04 PM
// Design Name: 
// Module Name: simple_calc
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


module simple_calc(
    input [3:0] x, y,
    input [1:0] op_sel,
    output carry_out, overflow,
    output [7:0] result
    );
    
    wire [3:0] add_result4bit;
    wire [7:0] mult_result8bit, add_result8bit;
    
    
    adder_subtractor Add_0(
        .x(x),
        .y(y),
        .add_n(op_sel[0]),
        .s(add_result4bit),
        .c_out(carry_out),
        .overflow(overflow)
        
    );
    
    assign add_result8bit = {4'b0, add_result4bit};
    
    csa_multiplier Mult_0(
        .m(x),
        .q(y),
        .p(mult_result8bit)
    );
    
    mux_2x1_8bit Mux_0(
        .s(op_sel[1]),
        .x(add_result8bit),
        .y(mult_result8bit),
        .m(result)
    );
    
    
    
endmodule
