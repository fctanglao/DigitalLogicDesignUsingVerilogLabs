`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/28/2024 03:18:28 PM
// Design Name: 
// Module Name: reg_file
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


module reg_file
    #(parameter N = 3,
    parameter BITS = 4)(
    input clk, we,
    input [N-1:0] address_w, address_r,
    input [BITS-1:0] data_w,
    output [BITS-1:0] data_r

    );
    
    wire [2 ** N:0] decoder_w;
    
    decoder_generic #(.N(N)) write_decoder(
        .w(address_w),
        .en(we),
        .y(decoder_w)
    );
    

    
    wire [2 ** N - 1:0] address_out;
    
    decoder_generic #(.N(N)) read_decoder(
        .w(address_r),
        .en(1'b1),
        .y(address_out)
    );
    
    
    genvar k;
    generate
        for (k = 0; k < 2 ** N; k = k + 1)
    begin
        wire [BITS-1:0] Q_out;
        simple_register_load #(.N(BITS)) registers(
            .clk(clk),
            .load(decoder_w[k]),
            .I(data_w),
            .Q(Q_out)
        );
        
        assign data_r = (address_out[k]) ? Q_out : 4'bz;
        
    end
    endgenerate
    

    
endmodule
