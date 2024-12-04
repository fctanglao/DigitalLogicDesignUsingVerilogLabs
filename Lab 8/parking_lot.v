`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/25/2024 03:13:14 PM
// Design Name: 
// Module Name: parking_lot
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


module parking_lot(
    input clk, reset_n, 
    input a, b,
    output [6:0] sseg,
    output [0:7] AN,
    output DP
    );
    
    wire [7:0] count_out;
    wire [11:0] bcd;
    wire dba, dbb;
    wire car_enter, car_exit;
    
    debouncer_delayed da(
    .clk(clk),
    .reset_n(reset_n),
    .noisy(a),
    .debounced(dba)
    );
    
    debouncer_delayed db(
    .clk(clk),
    .reset_n(reset_n),
    .noisy(b),
    .debounced(dbb)
    );
    
    parking_lot_fsm p0(
    .clk(clk),
    .reset_n(reset_n),
    .a(dba),
    .b(dbb),
    .car_enter(car_enter),
    .car_exit(car_exit)
    );
    
    udl_counter #(.BITS(8)) u0(
    .clk(clk),
    .reset_n(reset_n),
    .enable(car_enter | car_exit),
    .up(car_enter),
    .load(1'b0),
    .D(8'b0),
    .Q(count_out)
    );
    
    bin2bcd b0(
        .bin(count_out),
        .bcd(bcd)
    );
    
    sseg_driver s0(
        .clk(clk),
        .reset_n(reset_n),
        .i0({1'b1, bcd[3:0], 1'b1}),
        .i1({1'b1, bcd[7:4], 1'b1}),
        .i2({1'b1, bcd[11:8], 1'b1}),
        .i3(),
        .i4(),
        .i5(),
        .i6(),
        .i7(),
        .sseg(sseg),
        .AN(AN),
        .DP(DP)
    );
endmodule
