`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/25/2024 04:11:16 PM
// Design Name: 
// Module Name: parking_lot_fsm
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


module parking_lot_fsm(
    input clk, reset_n,
    input a, b,
    output car_enter, car_exit
    );
    
    reg [3:0] enter_state_reg, enter_state_next;
    reg [3:0] exit_state_reg, exit_state_next;
    
    localparam s0 = 3'd0;
    localparam s1 = 3'd1;
    localparam s2 = 3'd2;
    localparam s3 = 3'd3;
    localparam s4 = 3'd4;
    localparam s5 = 3'd5;
    
    always @(posedge clk, negedge reset_n)
    begin
        if (~reset_n)
        begin
            enter_state_reg <= s0;
            exit_state_reg <= s0;
        end
        else
        begin
            enter_state_reg <= enter_state_next;
            exit_state_reg <= exit_state_next;
        end
    end
    
    always @(*)
    begin
        case(enter_state_reg)
            s0: if({a,b} == 2'b10)
                    enter_state_next = s1;
                else if({a,b} == 2'b00)
                    enter_state_next = s0;
                else
                    enter_state_next = s0;
            s1: if({a,b} == 2'b11)
                    enter_state_next = s2;
                else if({a,b} == 2'b10)
                    enter_state_next = s1;
                else
                    enter_state_next = s0;
            s2: if({a,b} == 2'b01)
                    enter_state_next = s3;
                else if({a,b} == 2'b11)
                    enter_state_next = s2;
                else
                    enter_state_next = s0;
            s3: if({a,b} == 2'b01)
                    enter_state_next = s3;
                else
                    enter_state_next = s4;
            default: enter_state_next = s0;
        endcase
    end
    
    assign car_enter = enter_state_reg == s4;
    
    always @(*)
    begin
        case(exit_state_reg)
            s0: if({a,b} == 2'b01)
                    exit_state_next = s3;
                else if({a,b} == 2'b00)
                    exit_state_next = s0;
                else
                    exit_state_next = s0;
            s3: if({a,b} == 2'b11)
                    exit_state_next = s2;
                else if({a,b} == 2'b01)
                    exit_state_next = s3;
                else
                    exit_state_next = s0;
            s2: if({a,b} == 2'b10)
                    exit_state_next = s1;
                else if({a,b} == 2'b11)
                    exit_state_next = s2;
                else
                    exit_state_next = s0;
            s1: if({a,b} == 2'b10)
                    exit_state_next = s1;
                else
                    exit_state_next = s5;
            default: exit_state_next = s0;
        endcase
    end
    
    assign car_exit = exit_state_reg == s5;
endmodule
