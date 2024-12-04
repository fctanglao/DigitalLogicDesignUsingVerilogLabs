`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/04/2024 12:21:13 AM
// Design Name: 
// Module Name: accumulator_4bit
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


module accumulator_4bit(
    input [3:0] x,
    input add_sub, load, reset_n, clk,
    output [6:0] sseg,
    output [8:0] AN
    
    );
    
    assign AN = 9'b111111110;
    
    wire load_reg;
    button b0 (
        .clk(clk),
        .in(load),
        .out(load_reg)
    );
    

    
    wire [3:0] acc_0;
    
    wire [3:0] sum;
    
    
    
    adder_subtractor #(.n(4)) adder1(
        .x(acc_0),
        .y(x),
        .add_n(add_sub),
        .s(sum),
        .c_out(),
        .overflow()
    );
    
    

    
    
    
    simple_register_load #(.N(4)) reg_4bit(
        .clk(clk),
        .load(load_reg),
        .reset_n(reset_n),
        .I(sum),
        .Q(acc_0)
    );
    


    
    
    hex2sseg sseg0(
        .hex(acc_0),
        .sseg(sseg)
    ); 
    
endmodule
