`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/06/2024 04:06:46 AM
// Design Name: 
// Module Name: demux1_to_8
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


module demux1_to_8(
    input wire data_in,       
    input wire [3:0] select,  
    output reg [8:0] data_out 
);


always @(*) begin
    case (select)
        4'd0: data_out[0] = data_in; 
        4'd1: data_out[1] = data_in; 
        4'd2: data_out[2] = data_in; 
        4'd3: data_out[3] = data_in; 
        4'd4: data_out[4] = data_in; 
        4'd5: data_out[5] = data_in; 
        4'd6: data_out[6] = data_in; 
        4'd7: data_out[7] = data_in;
        4'd8: data_out[8] = data_in;  
        default: data_out = 9'd15; 
    endcase
end

endmodule

