`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/08/2024 02:16:21 AM
// Design Name: 
// Module Name: rgbtictactoe
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


module rgbtictactoe(
    input clk, reset_n,
    input [3:0] win_state, tie_state,
    input [1:0] player_sel,
    output red_LED, blue_LED, green_LED
    );
    reg [8:0] red_duty, green_duty, blue_duty;
    reg [8:0] red_duty, green_duty, blue_duty;

    always @(*)
    begin
        if(win_state)
        begin
            red_duty = 9'd0;
            green_duty = 9'd255;
            blue_duty = 9'd0;
        end
        else if(tie_state)
        begin
            red_duty = 9'd255;
            green_duty = 9'd255;
            blue_duty = 9'd0;
        end
        else if(~win_state && ~tie_state && player_sel == 2'd1)
        begin
            red_duty = 9'd0;
            green_duty = 9'd0;
            blue_duty = 9'd255;
        end
        else if(~win_state && ~tie_state && player_sel == 2'd2)
        begin
            red_duty = 9'd255;
            green_duty = 9'd0;
            blue_duty = 9'd0;
        end
    end
    
    rgb_driver #(.R(8)) LED16(
        .clk(clk),
        .reset_n(reset_n),
        .red_duty(red_duty),
        .green_duty(green_duty),
        .blue_duty(blue_duty),
        .red_LED(red_LED),
        .green_LED(green_LED),
        .blue_LED(blue_LED)
    );
endmodule
