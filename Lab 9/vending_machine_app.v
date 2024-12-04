`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/08/2024 03:56:14 PM
// Design Name: 
// Module Name: vending_machine_app
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


module vending_machine_app(
    input c5, c10, c25, clk, reset_n, item_taken,
    output r5, r10, r20,
    output DP, red_LED, blue_LED, green_LED,
    output [6:0] sseg,
    output [7:0] AN
    );
    wire dispense;
    
    button b5 (
        .clk(clk),
        .reset_n(reset_n),
        .noisy(c5),
        .debounced(),
        .p_edge(),
        .n_edge(c5b),
        ._edge()
        
    );
    
    button b10 (
         .clk(clk),
        .reset_n(reset_n),
        .noisy(c10),
        .debounced(),
        .p_edge(),
        .n_edge(c10b),
        ._edge()
    );
    
    button b25 (
        .clk(clk),
        .reset_n(reset_n),
        .noisy(c25),
        .debounced(),
        .p_edge(),
        .n_edge(c25b),
        ._edge()
    );
    
    button itemtaken0 (
        .clk(clk),
        .reset_n(reset_n),
        .noisy(item_taken),
        .debounced(item_takenb),
        .p_edge(),
        .n_edge(),
        ._edge()
    );
    
    wire c5b, c10b, c25b, item_takenb;
    
    wire [5:0] bin6b, bout6b;
    
    vending_machine0 fsm0 (
        .c5(c5b),
        .c10(c10b),
        .c25(c25b),
        .clk(clk),
        .reset_n(reset_n),
        .item_taken(item_takenb),
        .r5(r5),
        .r10(r10),
        .r20(r20),
        .dispense(dispense),
        .state_reg(bin6b),
        .bout(bout6b)
        
    );
    
    wire [11:0] bcd0, bcd1;
    
    bin2bcd bcdconv0 (
        .bin({2'd0,bin6b}),
        .bcd(bcd0)
    );
    
    bin2bcd bcdconv1 (
        .bin({2'd0,bout6b}),
        .bcd(bcd1)
    );
    
    
    
    sseg_driver sseg0 (
        .clk(clk),
        .reset_n(reset_n),
        .i0({1'b1, bcd0 [3:0], 1'b1}), .i1({1'b1, bcd0 [7:4], 1'b1}), .i2({1'b1, bcd0 [11:8], 1'b0}), .i3(), .i4({1'b1, bcd1 [3:0], 1'b1}), .i5({1'b1, bcd1 [7:4], 1'b1}), .i6({1'b1, bcd1 [11:8], 1'b0}), .i7(),
        .DP(DP),
        .sseg(sseg),
        .AN(AN)
    );
    
    reg [8:0] red_duty, green_duty;
    
    always@(*)
    begin
        if(dispense)
        begin
            green_duty = 9'd255;
            red_duty = 9'd0;
        end
        else
        begin
            green_duty = 9'd0;
            red_duty= 9'd255;
        end
            
    end
    
    rgb_driver #(.R(8)) LED16 (
        .clk(clk),
        .reset_n(reset_n),
        .red_duty(red_duty),
        .green_duty(green_duty),
        .blue_duty(),
        .red_LED(red_LED),
        .green_LED(green_LED),
        .blue_LED(blue_LED)   
    );
endmodule
