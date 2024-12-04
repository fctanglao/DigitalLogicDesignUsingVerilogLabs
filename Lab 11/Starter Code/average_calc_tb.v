`timescale 1ns / 1ps

module average_calc_tb(

    );
    
    reg clk, reset_n, we, calculate_average;
    reg [5:0] data_w;
    reg [1:0] address_w;
    wire [7:0] AN;
    wire [6:0] sseg;
    wire DP;
    
    average_calc uut(
        .clk(clk),
        .reset_n(reset_n),
        .we(we),
        .calculate_average(calculate_average),
        .data_w(data_w),
        .address_w(address_w),
        .AN(AN),
        .sseg(sseg),
        .DP(DP)
    );
    
    // timer
    initial
        #200 $stop;
    
    // Generate stimuli    
    
    // Generating a clk signal
    localparam T = 10;
    always
    begin
        clk = 1'b0;
        #(T / 2);
        clk = 1'b1;
        #(T / 2);
    end
    
    initial
    begin
        // issue a quick reset for 2 ns
        reset_n = 1'b0;
        calculate_average = 1'b0;
        
        @(negedge clk);
        reset_n = 1'b1;
        
        @(negedge clk);
        data_w = 6'd8;
        address_w = 2'b00;
        we = 1'b1;
        
        @(negedge clk)
        data_w = 6'd21;
        address_w = 2'b01;

        
        @(negedge clk)
        data_w = 6'd3;
        address_w = 2'b10;
        
        @(negedge clk)
        data_w = 6'd48;
        address_w = 2'b11;
        
        @(negedge clk)
        we = 1'b0;
        calculate_average = 1'b1;
        
        @(negedge clk)
        calculate_average = 1'b0;
        
    end
endmodule
