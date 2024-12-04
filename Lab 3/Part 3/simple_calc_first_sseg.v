`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/21/2024 03:19:39 AM
// Design Name: 
// Module Name: simple_calc_first_sseg
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


module simple_calc_first_sseg(
    input [3:0] x, y,
    input [1:0] digi_sel, op_sel,
    input DP_control,
    output [6:0] sseg,
    output [7:0] AN,
    output carry_out, overflow, DP, negative1
    );
    
    wire [11:0] bcd;
    
    
    
    bcd_calc_signed calc_to_sseg(
        .x(x),
        .y(y),
        .op_sel(op_sel),
        .bcd(bcd),
        .negative1(negative1),
        .carry_out(carry_out),
        .overflow(overflow)
    );
    
    wire [3:0] display_bcd;
    
    wire [1:0] anode_sel;
    assign anode_sel = ~digi_sel;
    
    mux_4x1_nbit #(.N(4)) bcd_mux(
        .w0(1'b0000),
        .w1(bcd [11:8]),
        .w2(bcd [7:4]),
        .w3(bcd [3:0]),
        .s(anode_sel),
        .f(display_bcd)
        
    );
    
    wire [2:0] active_digit;
    assign active_digit = ({1'b0, anode_sel});
    
    first_sseg_driver sseg_driver1(
        .active_digit(active_digit),
        .num(display_bcd),
        .DP_control(DP_control),
        .sseg(sseg),
        .an(AN),
        .DP(DP)
    );
    

    
endmodule
