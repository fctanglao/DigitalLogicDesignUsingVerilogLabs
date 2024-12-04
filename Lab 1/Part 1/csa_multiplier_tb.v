`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/05/2024 02:36:58 PM
// Design Name: 
// Module Name: csa_multiplier_tb
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


module csa_multiplier_tb( 
    );
    
    reg [3:0] m, q;
    
    wire [7:0] p;
    
    csa_multiplier uut(
        .m(m),
        .q(q),
        .p(p)
    );
    
    initial
    begin
        #60 $finish;
    end
    
    initial
    begin
        m = 4'd0;
        q = 4'd10;
        
        #10
        m = 4'd5;
        q = 4'd5;
        
        #10
        m = 4'd9;
        q = 4'd5;
        
        #10
        m = 4'd12;
        q = 4'd13;
        
        #10
        m = 4'd15;
        q = 4'd10;
    end
    
endmodule
