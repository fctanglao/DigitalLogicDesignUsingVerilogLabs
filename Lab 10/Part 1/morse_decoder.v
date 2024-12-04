`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/17/2024 03:16:37 PM
// Design Name: 
// Module Name: morse_decoder
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


module morse_decoder(
    input b, clk, reset_n,
    output reg dot, dash, lg, wg
    );
    
    wire p_edge, n_edge;
    reg startstop;
    wire enablecount0, enablecount1, enablecount2, enablecount3;
    reg [3:0] state_reg, state_next;
    
    localparam s0= 3'd0;
    localparam s1= 3'd1;
    localparam s2= 3'd2;
    localparam s3= 3'd3;
    localparam s4= 3'd4;
    localparam s5= 3'd5;
    localparam s6= 3'd6;
    localparam s7= 3'd7;
    
    
    
    always @(posedge clk, negedge reset_n)
    begin
        if(~reset_n)
        begin
            state_reg <= s0;
        end
        else
        begin
            state_reg <= state_next;
        end
    end

    reg rst_timer0, rst_timer1;
    

    button buttonedge (
        .clk(clk),
        .reset_n(reset_n),
        .noisy(b),
        .debounced(),
        .p_edge(p_edge),
        .n_edge(n_edge),
        ._edge()
    );
    
    timer_parameter #(.FINAL_VALUE(1)) timer0 (
        .clk(clk),
        .reset_n(reset_n & rst_timer0),
        .enable(startstop),
        .done(enablecount0)
    );
    
    
    mod_counter_parameter #(.FINAL_VALUE(130)) ch0 (
        .clk(clk),
        .reset_n(reset_n & rst_timer0),
        .enable(enablecount0 & startstop),
        .Q(),
        .done(enablecount1)
        
    );
    
    mod_counter_parameter #(.FINAL_VALUE(170)) ch2 (
        .clk(clk),
        .reset_n(reset_n & rst_timer0),
        .enable(enablecount0 & startstop),
        .Q(),
        .done(enablecount2)
        
    );
    mod_counter_parameter #(.FINAL_VALUE(310)) ch1 (
        .clk(clk),
        .reset_n(reset_n & rst_timer1),
        .enable(enablecount0 & startstop),
        .Q(),
        .done(enablecount3)
        
    );
    
    
    always @(*)
    begin
    case(state_reg)
        s0: begin
            wg=1'b0;
            lg=1'b0;
            dot=1'b0;
            dash=1'b0;
            rst_timer0=1'b0;
            rst_timer1=1'b0;
            startstop=1'b0;
            if(p_edge)
                state_next = s1;
            else
                state_next = s0;
            end
        s1: begin
            lg=1'b0;
            rst_timer0 = 1'b1;
            startstop= 1'b1;
            if(n_edge)
                state_next = s2;
            else if (enablecount1)
                state_next = s3;
            else
                state_next = s1;
            end
        s2: begin
            startstop= 1'b0; 
            rst_timer0 = 1'b0;
            dot = 1'b1;
            state_next = s4;
            end
        s3: begin
            startstop= 1'b0;
            rst_timer0 = 1'b0;
            dash = 1'b1;
            state_next = s4;
            end
        s4: begin
            dash = 1'b0;
            dot=1'b0;
            rst_timer0 = 1'b1;
            rst_timer1=1'b1;
            startstop= 1'b1; 
            if(p_edge)
                state_next = s1;
            else if (enablecount2)
                state_next = s5;
            else
                state_next = s4;
            end
        s5: begin
            rst_timer0 = 1'b1;
            rst_timer1=1'b1;
            startstop=1'b1;
            if(p_edge)
                state_next = s6;
            else if (enablecount3)
                state_next = s7;
            else
                state_next = s5;
            end
        s6: begin
            rst_timer0 = 1'b0;
            rst_timer1 = 1'b0;
            startstop= 1'b1;
            lg = 1'b1;
            state_next = s1;
            end
        s7: begin
            wg = 1'b1;
            rst_timer0 = 1'b0;
            rst_timer1 = 1'b0;
            startstop= 1'b0;
            state_next = s0;
            end
        default: state_next = s0;
        
    endcase
    end
    
    
endmodule
