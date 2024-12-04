`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/31/2024 05:12:17 PM
// Design Name: 
// Module Name: csa_multiplier
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


module csa_multiplier(
    input [3:0] m, q,
    output [7:0] p
    );
    
    wire [3:0] mq0, mq1, mq2, mq3;
    
    mq_4bit M0(
    .m(m),
    .q(q[0]),
    .mq(mq0)
    );
    
    mq_4bit M1(
    .m(m),
    .q(q[1]),
    .mq(mq1)
    );

    mq_4bit M2(
    .m(m),
    .q(q[2]),
    .mq(mq2)
    );
    
    mq_4bit M3(
    .m(m),
    .q(q[3]),
    .mq(mq3)
    );

    wire [3:0] cr0, cr1;
    wire [2:0] sr0, sr1, cr2;
    
    
    assign p[0] = mq0[0];
    
    
    full_adder r0_0 (
        .x(mq1[0]),
        .y(mq0[1]),
        .c_in(1'b0),
        .s(p[1]),
        .c_out(cr0[0])
    );
    
    full_adder r0_1 (
        .x(mq1[1]),
        .y(mq0[2]),
        .c_in(mq2[0]),
        .s(sr0[0]),
        .c_out(cr0[1])
    );
    
    full_adder r0_2 (
        .x(mq1[2]),
        .y(mq0[3]),
        .c_in(mq2[1]),
        .s(sr0[1]),
        .c_out(cr0[2])
    );
    
    full_adder r0_3 (
        .x(mq1[3]),
        .y(1'b0),
        .c_in(mq2[2]),
        .s(sr0[2]),
        .c_out(cr0[3])
    );
    
    full_adder r1_0 (
        .x(1'b0),
        .y(sr0[0]),
        .c_in(cr0[0]),
        .s(p[2]),
        .c_out(cr1[0])
    );
    
    full_adder r1_1 (
        .x(mq3[0]),
        .y(sr0[1]),
        .c_in(cr0[1]),
        .s(sr1[0]),
        .c_out(cr1[1])
    );
    
    full_adder r1_2 (
        .x(mq3[1]),
        .y(sr0[2]),
        .c_in(cr0[2]),
        .s(sr1[1]),
        .c_out(cr1[2])
    );
    
    full_adder r1_3 (
        .x(mq3[2]),
        .y(mq2[3]),
        .c_in(cr0[3]),
        .s(sr1[2]),
        .c_out(cr1[3])
    );    

    full_adder r2_0 (
        .x(cr1[0]),
        .y(sr1[0]),
        .c_in(1'b0),
        .s(p[3]),
        .c_out(cr2[0])
    );
    
    full_adder r2_1 (
        .x(cr1[1]),
        .y(sr1[1]),
        .c_in(cr2[0]),
        .s(p[4]),
        .c_out(cr2[1])
    );
    
    full_adder r2_2 (
        .x(cr1[2]),
        .y(sr1[2]),
        .c_in(cr2[1]),
        .s(p[5]),
        .c_out(cr2[2])
    );
    
    full_adder r2_3 (
        .x(cr1[3]),
        .y(mq3[3]),
        .c_in(cr2[2]),
        .s(p[6]),
        .c_out(p[7])
    ); 
    
endmodule
