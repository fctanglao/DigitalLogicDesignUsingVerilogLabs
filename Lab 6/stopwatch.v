`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/11/2024 03:16:18 PM
// Design Name: 
// Module Name: stopwatch
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


module stopwatch(
    input clk, reset_n, stop,
    output [7:0] AN,
    output [6:0] sseg,
    output DP
    );
    
    
    wire bstop1;
    button bstop (
        .clk(clk),
        .in(stop),
        .out(bstop1)
    );
    
    reg startstop;
    
    always @(posedge clk)
    begin
    if (!reset_n)
        startstop <= 0;
    else
        if (bstop1)
            startstop <= ~startstop;
        else startstop <= startstop;
    end

    
    wire enablecount0, enablecount1, enablecount2;
    timer_parameter #(.FINAL_VALUE(1000000)) timer0 (
        .clk(clk),
        .reset_n(reset_n),
        .enable(startstop),
        .done(enablecount0)
    );
    
    wire [7:0] counter_out0;
    
    mod_counter_parameter #(.FINAL_VALUE(99)) ch0 (
        .clk(clk),
        .reset_n(reset_n),
        .enable(enablecount0 & startstop),
        .Q(counter_out0 [6:0]),
        .done(enablecount1)
        
    );
        
    

    
    wire [7:0] counter_out1;

    mod_counter_parameter #(.FINAL_VALUE(59)) ch1 (
        .clk(clk),
        .reset_n(reset_n),
        .enable(enablecount1 & enablecount0 & startstop),
        .Q(counter_out1 [5:0]),
        .done(enablecount2)
        
    );
    
    wire [7:0] counter_out2;
    mod_counter_parameter #(.FINAL_VALUE(59)) ch2 (
        .clk(clk),
        .reset_n(reset_n),
        .enable(enablecount1 & enablecount2 & enablecount0 & startstop),
        .Q(counter_out2 [5:0]),
        .done()
        
    );
    
    wire [11:0] bcd0;
    
    
    bin2bcd bcdconv0 (
        .bin(counter_out0),
        .bcd(bcd0)
    );
    
    
    
    wire [11:0] bcd1;
    
    
    bin2bcd bcdconv1 (
        .bin(counter_out1),
        .bcd(bcd1)
    );
    
    wire [11:0] bcd2;
    
    
    bin2bcd bcdconv2 (
        .bin(counter_out2),
        .bcd(bcd2)
    );
    
    
    sseg_driver (
        .clk(clk),
        .reset_n(reset_n),
        .i0({1'b1, bcd0 [3:0], 1'b1}), .i1({1'b1, bcd0 [7:4], 1'b1}), .i2({1'b1, bcd1 [3:0], 1'b0}), .i3({1'b1, bcd1 [7:4], 1'b1}), .i4({1'b1, bcd2 [3:0], 1'b0}), .i5({1'b1, bcd2 [7:4], 1'b1}), .i6(), .i7(),
        .DP(DP),
        .sseg(sseg),
        .AN(AN)
    );
    
endmodule
