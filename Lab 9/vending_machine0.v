`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/27/2024 04:13:38 PM
// Design Name: 
// Module Name: vending_machine0
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


module vending_machine0(
    input c5, c10, c25, clk, reset_n, item_taken,
    output reg r5, r10, r20, dispense,
    output reg [5:0] state_reg, bout
    );
    
    reg [5:0] state_next;

    localparam s0 = 6'd0;
    localparam s5 = 6'd5;
    localparam s10 = 6'd10;
    localparam s15 = 6'd15;
    localparam s20 = 6'd20;
    localparam s25 = 6'd25;
    localparam s30 = 6'd30;
    localparam s35 = 6'd35;
    localparam s40 = 6'd40;
    localparam s45 = 6'd45;
    

    
    always @(posedge clk, negedge reset_n)
    begin
        if(~reset_n)
        begin
            state_reg <= s0;
        end
        else
        begin
            if (state_reg >= 25)
            begin
                bout = (state_reg - 25);
                dispense = 1'b1;
            end
            else
            begin
                bout = 0;
                dispense = 1'b0;
            end
            state_reg <= state_next;
        end
    end

    
    always @(*)
    begin
        case(state_reg)
            s0: begin
                r5=1'b0;
                r10=1'b0;
                r20=1'b0;
                if (c5)
                    state_next = s5;
                else if (c10)
                    state_next = s10;
                else if (c25)
                    state_next = s25;
                else
                    state_next = s0;
                end
            s5: begin
                if(c5)
                    state_next = s10;
                else if (c10)
                    state_next = s15;
                else if (c25)
                    state_next = s30;
                else
                    state_next = s5;
                end
            s10: begin
                if(c5)
                    state_next = s15;
                else if (c10)
                    state_next = s20;
                else if (c25)
                    state_next = s35;
                else
                    state_next = s10;
                end
            s15: begin
                if(c5)
                    state_next = s20;
                else if (c10)
                    state_next = s25;
                else if (c25)
                    state_next = s40;
                else
                    state_next = s15;
                end
            s20: begin
                if(c5)
                    state_next = s25;
                else if (c10)
                    state_next = s30;
                else if (c25)
                    state_next = s45;
                else    
                    state_next = s20;
                end
            s25: begin
                if (item_taken)
                    state_next = s0;
                else    
                    state_next = s25;
                end
            s30: begin
                r5=1'b1;
                if (item_taken)
                    state_next = s0;
                else
                    state_next = s30;
                end              
            s35: begin
                r10 = 1'b1;
                if (item_taken)
                    state_next = s0;
                else
                    state_next = s35;
                end            
            s40: begin
                r10 = 1'b1;
                r5 = 1'b1;
                if (item_taken)
                    state_next = s0;
                else
                    state_next = s40;
                end  
            s45: begin
                r20 = 1'b1;
                if (item_taken)
                    state_next = s0;
                else
                    state_next = s45;
                end                              
                      
            default: state_next = s0;
            
        endcase
    end
    
    
    
endmodule
