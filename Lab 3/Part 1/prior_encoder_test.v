`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/19/2024 02:28:24 AM
// Design Name: 
// Module Name: prior_encoder_test
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


module prior_encoder_test(
    input [15:0] SW,
    output [6:0] sseg,
    output [7:0] an
    );
    
    
    
    wire [3:0] y;
    wire z;
    
    priority_encoder_generic #(.N(16)) encoder1(
    .w(SW),
    .z(z),
    .y(y)
    );
    
    assign an = {7'b1111111, ~z};
    
    hex2sseg sseg_1(
    .hex(y),
    .sseg(sseg)
    );
    
endmodule
