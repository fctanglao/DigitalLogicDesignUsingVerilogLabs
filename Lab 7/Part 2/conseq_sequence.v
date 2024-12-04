`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/18/2024 03:23:29 PM
// Design Name: 
// Module Name: conseq_sequence
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


module conseq_sequence(
    input clk, reset_n, x,
    output y,
    output reg [2:0] state_reg
    
    );
    
    reg [2:0] state_next;
    
    localparam s0 = 3'd0;
    localparam s1 = 3'd1;
    localparam s2 = 3'd2;
    localparam s3 = 3'd3;
    localparam s4 = 3'd4;
    localparam s5 = 3'd5;
    localparam s6 = 3'd6;
    
    always @(posedge clk, negedge reset_n)
    begin
        if(~reset_n)
            state_reg <= s0;
        else
            state_reg <= state_next;
    end
    
    always @(*)
    begin
        case(state_reg)
            s0: if(x)
                    state_next = s4;
                else
                    state_next = s1;
            s1: if(x)
                    state_next = s4;
                else
                    state_next = s2;
            s2: if(x)
                    state_next = s4;
                else
                    state_next = s3;
            s3: if(x)
                    state_next = s4;
                else
                    state_next = s3;
            s4: if(x)
                    state_next = s5;
                else
                    state_next = s1;
            s5: if(x)
                    state_next = s6;
                else
                    state_next = s1;
            s6: if(x)
                    state_next = s6;
                else
                    state_next = s1;
            
            default: state_next = state_reg;
        endcase           
    end
    
    assign y = ((state_reg == s3 & ~x) | (state_reg == s6 & x));
endmodule
