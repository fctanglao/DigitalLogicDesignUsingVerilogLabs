`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/06/2024 10:16:17 AM
// Design Name: 
// Module Name: tictactoe_uart
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


module tictactoe_uart(
    input clk, reset_n, button_neg,
    input [1:0] box0, box1, box2, box3, box4, box5, box6, box7, box8, player_sel,
    input [3:0] game_state,
    output reg fifoenable,
    output [7:0] dout
    );
    
    reg [7:0] state_reg, state_next, feedfifo;
    localparam space = 8'd32;
    localparam zero = 8'd48;
    localparam capital_X = 8'd88;
    localparam capital_O= 8'd79;
    localparam vertical = 8'd124;
    localparam backslash = 8'd10;
    localparam NULL = 8'd0;
    localparam htab =8'd9;
    localparam dash =8'd45;
    localparam n = 8'd13;
    localparam P = 8'd80;
    localparam num1 = 8'd49;
    localparam num2 = 8'd50;
    localparam W = 8'd87;
    localparam I = 8'd73;
    localparam N = 8'd78;
    localparam S = 8'd83;
    localparam T = 8'd84;
    localparam E = 8'd69;
    localparam exclamation = 8'd33;
    localparam s0 = 8'd0;
    localparam s1= 8'd1;
    localparam s2 = 8'd2;
    localparam s3 = 8'd3;
    localparam s4 = 8'd4;
    localparam s5 = 8'd5; 
    localparam s6 = 8'd6;   
    localparam s7 = 8'd7;
    localparam s8 = 8'd8;
    localparam s9 = 8'd9;
    localparam s10 = 8'd10;
    localparam s11 = 8'd11;
    localparam s12 = 8'd12;
    localparam s13 = 8'd13;
    localparam s14 = 8'd14;
    localparam s15 = 8'd15;
    localparam s16 = 8'd16;
    localparam s17 = 8'd17;
    localparam s18 = 8'd18;
    localparam s19 = 8'd19;
    localparam s20= 8'd20;
    localparam s21= 8'd21;
    localparam s22= 8'd22;
    localparam s23= 8'd23;
    localparam s24= 8'd24;
    localparam s25= 8'd25;
    localparam s26= 8'd26;
    localparam s27= 8'd27;
    localparam s28= 8'd28;
    localparam s29= 8'd29;
    localparam s30= 8'd30;
    localparam s31= 8'd31;
    localparam s32= 8'd32;
    localparam s33= 8'd33;
    localparam s34= 8'd34;
    localparam s35 = 8'd35;
    localparam s36 = 8'd36;
    localparam s37 = 8'd37;
    localparam gamestatus = 8'd38;
    localparam win = 8'd39;
    localparam tie = 8'd40;
    localparam s41 = 8'd41;
    localparam s42 = 8'd42;
    localparam s43 = 8'd43;
    localparam s44 = 8'd44;
    localparam s45 = 8'd45;
    localparam s46 = 8'd46;
    localparam s47 = 8'd47;
    localparam s48 = 8'd48;
    localparam s49 = 8'd49;
    localparam s50 = 8'd50;
    localparam s51 = 8'd51;
    localparam s52 = 8'd52;
    localparam s53 = 8'd53;
    localparam s54 = 8'd54;
    
    
    
    

    always @(posedge clk, negedge reset_n)
    begin
        if(~reset_n)
        begin
            state_reg<=s0;
        end
        else
        begin
            state_reg<=state_next;
        end
    end
    
    always @(*)
    begin
        case(state_reg)
        s0: begin
            fifoenable=1'b0;
            if (button_neg)
            begin
                fifoenable = 1'b1;
                feedfifo = space;
                state_next = s1;
            end
            else
                state_next = s0;
        end
        
        s1: begin
            if (box0 == 2'd1)
            begin
                feedfifo = capital_X;
                state_next = s2;
            end
            else if(box0 == 2'd2)
            begin
                feedfifo = capital_O;
                state_next = s2;
            end
            else
            begin
                feedfifo = zero;
                state_next = s2;
            end
        end
        
        s2: begin
                feedfifo = space;
                state_next = s3;

        end
        
        s3: begin
                feedfifo = vertical;
                state_next = s4;

        end
        
        s4: begin
                feedfifo = space;
                state_next = s5;

        end
        
        s5: begin
            if (box1 == 2'd1)
            begin
                feedfifo = capital_X;
                state_next = s6;
            end
            else if(box1 == 2'd2)
            begin
                feedfifo = capital_O;
                state_next = s6;
            end
            else
            begin
                feedfifo = (zero+1);
                state_next = s6;
            end
        end
        
        s6: begin
                feedfifo = space;
                state_next = s7;

        end
       
        s7: begin
                feedfifo = vertical;
                state_next = s8;

        end
        
        s8: begin
                feedfifo = space;
                state_next = s9;

        end
        
        s9: begin
            if (box2 == 2'd1)
            begin
                feedfifo = capital_X;
                state_next = s10;
            end
            else if(box2 == 2'd2)
            begin
                feedfifo = capital_O;
                state_next = s10;
            end
            else
            begin
                feedfifo = (zero+2);
                state_next = s10;
            end
        end
        s10: begin
                feedfifo = backslash;
                state_next = s11;

        end
        s11: begin
                feedfifo = n;
                state_next = s12;
                end
                    

        
        s12: begin 
                feedfifo = space;
                state_next = s13;

        end        
        
        s13: begin
            if (box3 == 2'd1)
            begin
                feedfifo = capital_X;
                state_next = s14;
            end
            else if(box3 == 2'd2)
            begin
                feedfifo = capital_O;
                state_next = s14;
            end
            else
            begin
                feedfifo = (zero+3);
                state_next = s14;
            end
        end
        
        s14: begin
                feedfifo = space;
                state_next = s15;

        end 
        
        s15: begin
                feedfifo = vertical;
                state_next = s16;

        end
        
        s16: begin
                feedfifo = space;
                state_next = s17;

        end
        
        s17: begin
            if (box4 == 2'd1)
            begin
                feedfifo = capital_X;
                state_next = s18;
            end
            else if(box4 == 2'd2)
            begin
                feedfifo = capital_O;
                state_next = s18;
            end
            else
            begin
                feedfifo = (zero+4);
                state_next = s18;
            end
        end
        
        s18: begin
                feedfifo = space;
                state_next = s19;

        end
        s19: begin
                feedfifo = vertical;
                state_next = s20;

        end
        s20: begin
                feedfifo = space;
                state_next = s21;

        end
        s21: begin
            if (box5 == 2'd1)
            begin
                feedfifo = capital_X;
                state_next = s22;
            end
            else if(box5 == 2'd2)
            begin
                feedfifo = capital_O;
                state_next = s22;
            end
            else
            begin
                feedfifo = (zero+5);
                state_next = s22;
            end
        end
        s22: begin
                feedfifo = backslash;
                state_next = s23;

        end
        s23: begin
                feedfifo = n;
                state_next = s24;

        end
        s24: begin
                feedfifo = space;
                state_next = s25;

        end        
        
        s25: begin
            if (box6 == 2'd1)
            begin
                feedfifo = capital_X;
                state_next = s26;
            end
            else if(box6 == 2'd2)
            begin
                feedfifo = capital_O;
                state_next = s26;
            end
            else
            begin
                feedfifo = (zero+6);
                state_next = s26;
            end
        end
        
        s26: begin
                feedfifo = space;
                state_next = s27;

        end 
        
        s27: begin
                feedfifo = vertical;
                state_next = s28;

        end
        
        s28: begin
                feedfifo = space;
                state_next = s29;

        end
        
        s29: begin
            if (box7 == 2'd1)
            begin
                feedfifo = capital_X;
                state_next = s30;
            end
            else if(box7 == 2'd2)
            begin
                feedfifo = capital_O;
                state_next = s30;
            end
            else
            begin
                feedfifo = (zero+7);
                state_next = s30;
            end
        end
        
        s30: begin
                feedfifo = space;
                state_next = s31;

        end
        s31: begin
                feedfifo = vertical;
                state_next = s32;

        end
        s32: begin
                feedfifo = space;
                state_next = s33;

        end
        s33: begin
            if (box8 == 2'd1)
            begin
                feedfifo = capital_X;
                state_next = s34;
            end
            else if(box8 == 2'd2)
            begin
                feedfifo = capital_O;
                state_next = s34;
            end
            else
            begin
                feedfifo = (zero+8);
                state_next = s34;
            end
        end
        s34: begin
                feedfifo = backslash;
                state_next = s35;

        end
        s35: begin
                feedfifo = n;
                state_next = s36;

        end
        s36: begin
            feedfifo=backslash;
            state_next = s37;
        end
        s37: begin
            feedfifo=n;
            state_next = gamestatus;
        end  
        gamestatus: begin
            if(game_state == 4'd9) begin
                feedfifo=backslash;
                state_next = win;
                end
             else if(game_state == 4'd10) begin
                feedfifo=backslash;
                state_next=tie;
             end
             else
                state_next=s0;
        end
        win:begin
            feedfifo=n;
            state_next = s41;
        end
        s41: begin
            feedfifo = P;
            state_next = s42;
        end
        s42: begin
            if(player_sel == 2'd1)
                feedfifo = num1;
            else
                feedfifo = num2;
            state_next = s43;
        end
        s43: begin
            feedfifo = space;
            state_next = s44;
        end
        s44: begin
            feedfifo = W;
            state_next = s45;
        end
        s45: begin
            feedfifo = I;
            state_next = s46;
        end
        s46: begin
            feedfifo = N;
            state_next = s47;
        end
        s47: begin
            feedfifo = S;
            state_next = s48;
        end
        s48: begin
            feedfifo = backslash;
            state_next = s49;
        end
        s49: begin
            feedfifo = n;
            state_next = s52;
        end
        tie: begin
            feedfifo = T;
            state_next = s50;
        end
        s50: begin
            feedfifo = I;
            state_next = s51;
        end
        s51: begin
            feedfifo = E;
            state_next = s48;
        end
        s52: begin
            feedfifo = backslash;
            state_next = s53;
        end
        s53: begin
            feedfifo = n;
            state_next = s0;
        end
        default: state_next = s0;
        endcase
    end
   
   assign dout = feedfifo;
   
   
endmodule
