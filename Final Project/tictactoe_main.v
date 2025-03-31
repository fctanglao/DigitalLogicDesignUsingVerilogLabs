`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/06/2024 12:56:06 AM
// Design Name: 
// Module Name: tictactoe_main
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


module tictactoe_main(
    input up, down, left, right, select, reset_n, clk,rx,
    output DP, tx, red_LED, blue_LED, green_LED,
    output [6:0] sseg,
    output [7:0] AN
    );
    reg [1:0] player_sel;
    reg [1:0] box0, box1, box2, box3, box4, box5, box6, box7, box8;
    reg [3:0] state_reg, state_next;
    wire win_statep1, win_statep2, tie_state;
    reg [1:0] winner;
    
    localparam s0 = 4'd0;
    localparam s1 = 4'd1;
    localparam s2 = 4'd2;
    localparam s3 = 4'd3;
    localparam s4 = 4'd4;
    localparam s5 = 4'd5;
    localparam s6 = 4'd6;
    localparam s7 = 4'd7;
    localparam s8 = 4'd8;
    localparam win = 4'd9;
    localparam tie = 4'd10;
    
    
    always @(posedge clk, negedge reset_n)
    begin
        if(~reset_n)
        begin
            state_reg <= s4;
            box0 <= 2'b0;
            box1 <= 2'b0;
            box2 <= 2'b0;
            box3 <= 2'b0;
            box4 <= 2'b0;
            box5 <= 2'b0;
            box6 <= 2'b0;
            box7 <= 2'b0;
            box8 <= 2'b0;
        end
        else
        begin
            state_reg <= state_next;
            if (state_reg == s4) begin
            if (select_pos & (turns_counted % 2 == 0)) begin
                box4 <= 2'b01;
            end else if (select_pos & (turns_counted % 2 == 1)) begin
                box4 <= 2'b10;
            end
        end
        
            if (state_reg == s5) begin
            if (select_pos & (turns_counted % 2 == 0)) begin
                box5 <= 2'b01;
            end else if (select_pos & (turns_counted % 2 == 1)) begin
                box5 <= 2'b10;
            end
        end
            if (state_reg == s6) begin
            if (select_pos & (turns_counted % 2 == 0)) begin
                box6 <= 2'b01;
            end else if (select_pos & (turns_counted % 2 == 1)) begin
                box6 <= 2'b10;
            end
        end   
            if (state_reg == s7) begin
            if (select_pos & (turns_counted % 2 == 0)) begin
                box7 <= 2'b01;
            end else if (select_pos & (turns_counted % 2 == 1)) begin
                box7 <= 2'b10;
            end
        end
            if (state_reg == s8) begin
            if (select_pos & (turns_counted % 2 == 0)) begin
                box8 <= 2'b01;
            end else if (select_pos & (turns_counted % 2 == 1)) begin
                box8 <= 2'b10;
            end
        end
            if (state_reg == s0) begin
            if (select_pos & (turns_counted % 2 == 0)) begin
                box0 <= 2'b01;
            end else if (select_pos & (turns_counted % 2 == 1)) begin
                box0 <= 2'b10;
            end
        end
            if (state_reg == s1) begin
            if (select_pos & (turns_counted % 2 == 0)) begin
                box1 <= 2'b01;
            end else if (select_pos & (turns_counted % 2 == 1)) begin
                box1 <= 2'b10;
            end
        end
            if (state_reg == s2) begin
            if (select_pos & (turns_counted % 2 == 0)) begin
                box2 <= 2'b01;
            end else if (select_pos & (turns_counted % 2 == 1)) begin
                box2 <= 2'b10;
            end
        end
             if (state_reg == s3) begin
            if (select_pos & (turns_counted % 2 == 0)) begin
                box3 <= 2'b01;
            end else if (select_pos & (turns_counted % 2 == 1)) begin
                box3 <= 2'b10;
            end
        end
        end
    end
    
    
    wire up_pos, down_pos, left_pos, right_pos;
    button bup (
        .clk(clk),
        .reset_n(reset_n),
        .noisy(up),
        .debounced(),
        .p_edge(up_pos),
        .n_edge(),
        ._edge()
        
    );
    button bdown (
        .clk(clk),
        .reset_n(reset_n),
        .noisy(down),
        .debounced(),
        .p_edge(down_pos),
        .n_edge(),
        ._edge()
        
    );
    button bleft (
        .clk(clk),
        .reset_n(reset_n),
        .noisy(left),
        .debounced(),
        .p_edge(left_pos),
        .n_edge(),
        ._edge()
        
    );
    button bright (
        .clk(clk),
        .reset_n(reset_n),
        .noisy(right),
        .debounced(),
        .p_edge(right_pos),
        .n_edge(),
        ._edge()
        
    );
    wire select_neg;
    button bselect (
        .clk(clk),
        .reset_n(reset_n),
        .noisy(select),
        .debounced(),
        .p_edge(select_pos),
        .n_edge(select_neg),
        ._edge()
        
    );
    
    

    
    wire toggleTurn;
    T_FF toggle_playerTurn(
        .clk(clk),
        .T(select_pos),
        .reset_n(reset_n),
        .Q(toggleTurn)
    );
    wire [1:0] player_seltff;
    mux_2x1_nbit #(.N(2)) sel_Xor0(
        .w0(2'd1),
        .w1(2'd2),
        .s(toggleTurn),
        .f(player_seltff)
    );
    wire [3:0] turns_counted;
    udl_counter #(.BITS(4)) turncounter0 (
        .clk(clk),
        .reset_n(reset_n),
        .enable(select_pos),
        .up(1'b1),
        .load(),
        .D(),
        .Q(turns_counted)
    );
    
    wire win_state;
    
    assign win_statep1 = ((box0==2'd1 & box1==2'd1 & box2==2'd1) | 
    (box3==2'd1 & box4==2'd1 & box5==2'd1) |
    (box6==2'd1 & box7==2'd1 & box8==2'd1) |
    (box0==2'd1 & box3==2'd1 & box6==2'd1) |
    (box1==2'd1 & box4==2'd1 & box7==2'd1) |
    (box2==2'd1 & box5==2'd1 & box8==2'd1) |
    (box0==2'd1 & box4==2'd1 & box8==2'd1) |
    (box2==2'd1 & box4==2'd1 & box6==2'd1));
    
    assign win_statep2 = ((box0==2'd2 & box1==2'd2 & box2==2'd2) | 
    (box3==2'd2 & box4==2'd2 & box5==2'd2) |
    (box6==2'd2 & box7==2'd2 & box8==2'd2) |
    (box0==2'd2 & box3==2'd2 & box6==2'd2) |
    (box1==2'd2 & box4==2'd2 & box7==2'd2) |
    (box2==2'd2 & box5==2'd2 & box8==2'd2) |
    (box0==2'd2 & box4==2'd2 & box8==2'd2) |
    (box2==2'd2 & box4==2'd2 & box6==2'd2));
    
    assign win_state = (win_statep1 | win_statep2);
    assign tie_state = (turns_counted >=9);
    
    always @(*)
    begin
        case(state_reg)
            s4: begin
                player_sel = player_seltff;
                if(win_state)
                    state_next = win;
                else if (tie_state)
                    state_next = tie;
                else if(box4 > 2'd0)
                    state_next = s0;
                else
                    begin
                        if (up_pos)
                            state_next = s1;
                        else if (down_pos)
                            state_next = s7;
                        else if (left_pos)
                            state_next = s3;
                        else if (right_pos)
                            state_next = s5;
                        else if (select_pos)
                            begin
                                state_next = s0;
                            end
                        else state_next = s4;
                    end
                end
            s5: begin
                player_sel = player_seltff;
                if(win_state)
                    state_next = win;
                else if (tie_state)
                    state_next = tie;
                else if(box5 > 2'd0)
                    state_next = s8;
                else
                    begin
                        if (up_pos)
                            state_next = s2;
                        else if (down_pos)
                            state_next = s8;
                        else if (left_pos)
                            state_next = s4;
                        else if (right_pos)
                            state_next = s3;
                        else if (select_pos)
                            begin
                            state_next = s8;
                            end
                        else state_next = s5;
                    end
                end
            s3: begin
                player_sel = player_seltff;
                if(win_state)
                    state_next = win;
                else if (tie_state)
                    state_next = tie;
                else if(box3 > 2'd0)
                    state_next = s4;
                else
                    begin
                        if (up_pos)
                            state_next = s0;
                        else if (down_pos)
                            state_next = s6;
                        else if (left_pos)
                            state_next = s5;
                        else if (right_pos)
                            state_next = s4;
                        else if (select_pos)
                            begin
                            state_next = s4;
                            end
                        else state_next = s3;
                    end
                end
            s1: begin
                player_sel = player_seltff;
                if(win_state)
                    state_next = win;
                else if (tie_state)
                    state_next = tie;
                else if(box1 > 2'd0)
                    state_next = s2;
                else
                    begin
                        if (up_pos)
                            state_next = s7;
                        else if (down_pos)
                            state_next = s4;
                        else if (left_pos)
                            state_next = s0;
                        else if (right_pos)
                            state_next = s2;
                        else if (select_pos)
                            begin
                            state_next = s2;
                            end
                        else state_next = s1;
                    end
                end
            s2: begin
                player_sel = player_seltff;
                if(win_state)
                    state_next = win;
                else if (tie_state)
                    state_next = tie;
                else if(box2 > 2'd0)
                    state_next = s5;
                else
                    begin
                        if (up_pos)
                            state_next = s8;
                        else if (down_pos)
                            state_next = s5;
                        else if (left_pos)
                            state_next = s1;
                        else if (right_pos)
                            state_next = s0;
                        else if (select_pos)
                            begin
                            state_next = s5;
                            end
                        else state_next = s2;
                    end
                end
            s0: begin
                player_sel = player_seltff;
                if(win_state)
                    state_next = win;
                else if (tie_state)
                    state_next = tie;
                else if(box0 > 2'd0)
                    state_next = s1;
                else
                    begin
                        if (up_pos)
                            state_next = s6;
                        else if (down_pos)
                            state_next = s3;
                        else if (left_pos)
                            state_next = s2;
                        else if (right_pos)
                            state_next = s1;
                        else if (select_pos)
                            begin
                            state_next = s1;
                            end
                        else state_next = s0;
                    end
                end
            s7: begin
                player_sel = player_seltff;
                if(win_state)
                    state_next = win;
                else if (tie_state)
                    state_next = tie;
                else if(box7 > 2'd0)
                    state_next = s6;
                else
                    begin
                        if (up_pos)
                            state_next = s4;
                        else if (down_pos)
                            state_next = s1;
                        else if (left_pos)
                            state_next = s6;
                        else if (right_pos)
                            state_next = s8;
                        else if (select_pos)
                            begin
                            state_next = s6;
                            end
                        else state_next = s7;
                    end
                end
            s8: begin
                player_sel = player_seltff;
                if(win_state)
                    state_next = win;
                else if (tie_state)
                    state_next = tie;
                else if(box8 > 2'd0)
                    state_next = s7;
                else
                    begin
                        if (up_pos)
                            state_next = s5;
                        else if (down_pos)
                            state_next = s2;
                        else if (left_pos)
                            state_next = s7;
                        else if (right_pos)
                            state_next = s6;
                        else if (select_pos)
                            begin
                            state_next = s7;
                            end
                        else state_next = s8;
                    end
                end
            s6: begin
                player_sel = player_seltff;
                if(win_state)
                    state_next = win;
                else if (tie_state)
                    state_next = tie;
                else if(box6 > 2'd0)
                    state_next = s3;
                else
                    begin
                        if (up_pos)
                            state_next = s3;
                        else if (down_pos)
                            state_next = s0;
                        else if (left_pos)
                            state_next = s8;
                        else if (right_pos)
                            state_next = s7;
                        else if (select_pos)
                            begin
                            state_next = s3;
                            end
                        else state_next = s6;
                    end
                end
                
            win: begin
                if(win_statep1 == 2'd1)
                    player_sel=2'd1;
                else
                    player_sel =2'd2;
                    
                state_next = win;
                
            end
            tie: begin
                    state_next = tie;
            end

            default: state_next = s4;
        endcase
        end
    wire timerdone;
    timer_parameter #(.FINAL_VALUE(50000000)) flashertimer (
        .clk(clk),
        .reset_n(reset_n),
        .enable(1'b1),
        .done(timerdone)
    );

    wire [8:0] ssegflash;
    wire demuxin;
    T_FF flasher0 (
        .clk(clk),
        .T(timerdone),
        .reset_n(reset_n),
        .Q(demuxin)
    );
    
    wire [3:0] demux;
    assign demux = state_reg;
    demux1_to_8 (
        .data_in(demuxin),
        .select(demux),
        .data_out(ssegflash)
    );
    
    
    
    wire [6:0] player_id;
    hex2sseg playernumberid (
        .hex({2'b00,player_sel}),
        .sseg(player_id)
    );
    wire [6:0] stateregdisplay;
    hex2sseg statedisplay (
        .hex(state_reg),
        .sseg(stateregdisplay)
    );
    wire [6:0] tickbox4; //testing box value 
    hex2sseg statedisplay0 (
        .hex({2'b0,box4}),
        .sseg(tickbox4)
    );
    
    sseg_driver ssegdriver0 (
        .clk(clk),
        .reset_n(reset_n),
        .i0({1'b1,player_id,1'b1}),
        .i1({1'b1,7'b0001100,1'b1}),
        .i2({1'b0,tickbox4,1'b1}),
        .i3(),
        .i4({1'b1,stateregdisplay, 1'b1}),
        .i5({1'b1,{ssegflash[5],1'b1,1'b1,ssegflash[8],1'b1,1'b1,ssegflash[2]},1'b1}),
        .i6({1'b1,{ssegflash[4],1'b1,1'b1,ssegflash[7],1'b1,1'b1,ssegflash[1]},1'b1}),
        .i7({1'b1,{ssegflash[3],1'b1,1'b1,ssegflash[6],1'b1,1'b1,ssegflash[0]},1'b1}),
        .DP(DP),
        .sseg(sseg),
        .AN(AN)
    );
    
    wire [7:0] transmituart;
    wire wr_uart;
    tictactoe_uart foruart(
        .clk(clk),
        .reset_n(reset_n),
        .button_neg(select_neg),
        .box0(box0),
        .box1(box1),
        .box2(box2),
        .box3(box3),
        .box4(box4),
        .box5(box5),
        .box6(box6),
        .box7(box7),
        .box8(box8),
        .player_sel(player_sel),
        .game_state(state_reg),
        .fifoenable(wr_uart),
        .dout(transmituart)
        
    );
    
    uart #(.DBIT(8), .SB_TICK(16)) uarttictactoe (
        .clk(clk),
        .reset_n(reset_n),
        //reciever port
        .r_data(),
        .rd_uart('b0),
        .rx_empty(),
        .rx(rx),
        //transmitter port
        .w_data(transmituart),
        .wr_uart(wr_uart),
        .tx_full(),
        .tx(tx),
        
        .TIMER_FINAL_VALUE(11'd650)
        
    );
    
    rgbtictactoe rbgplayer (
        .clk(clk),
        .reset_n(reset_n),
        .win_state(win_state),
        .tie_state(tie_state),
        .player_sel(player_sel),
        .red_LED(red_LED),
        .blue_LED(blue_LED),
        .green_LED(green_LED)
    );
    

    
endmodule
