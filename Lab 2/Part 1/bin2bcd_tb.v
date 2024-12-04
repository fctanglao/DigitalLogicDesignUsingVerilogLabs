`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/14/2024 12:55:52 AM
// Design Name: 
// Module Name: bin2bcd_tb
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


module bin2bcd_tb(
    );
    reg [7:0] bin;
    
    wire [11:0] bcd;
    
    bin2bcd uut(
    .bin(bin),
    .bcd(bcd)
    );
    
        initial
    begin
        #60 $finish;
    end
    
    initial
    begin
    
        bin = 8'd255;
        
        #10
        
        bin=8'd196;
        
        #10
        
        bin=8'd67;

    end
    
endmodule
