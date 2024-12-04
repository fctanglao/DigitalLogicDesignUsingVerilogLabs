`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/14/2024 02:43:19 PM
// Design Name: 
// Module Name: bcd_calc
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


module bcd_calc_signed(
    input [3:0] x, y,
    input [1:0] op_sel,
    output  [11:0] bcd,
    output reg negative1, 
    output carry_out, overflow
    );
    
    wire [7:0] result;
    reg [7:0] result_2scomp;
   
    
    simple_calc calc_1(
        .x(x),
        .y(y),
        .op_sel(op_sel),
        .carry_out(carry_out),
        .overflow(overflow),
        .result(result)
    );
    
    
    always@(x, y, op_sel)
    
    
    begin
    if (op_sel[1] == 1'b0)
    begin
        if (result[3] == 1'b1)
        begin
            
            result_2scomp = ({4'b0, (~result[3:0] + 1'b1)});
            negative1 = 1'b1;
        end
        else
        begin
            result_2scomp = result;
            negative1 = 1'b0;
        end          
    end
    else
    begin
        result_2scomp = result;
        negative1 = 1'b0;
    end   
    end
    
    
    bin2bcd bcdconverter0(
        .bin(result_2scomp),
        .bcd(bcd)
    );

    
endmodule
