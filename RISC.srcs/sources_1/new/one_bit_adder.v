`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/08/2024 05:35:43 PM
// Design Name: 
// Module Name: one_bit_adder
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


module one_bit_adder(
    input a,
    input b,
    input en,
    input cin,
    output reg sum,
    output reg cout
    );
    
    always@(*) begin
        if (en) begin 
            sum = a ^ b ^ cin; 
            cout = (a & b) | (b & cin) | (a & cin); 
        end
        else begin 
            sum = 0;
            cout = 0; 
        end
    end
    
    
    
endmodule
