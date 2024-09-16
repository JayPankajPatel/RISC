`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/13/2024 05:08:06 PM
// Design Name: 
// Module Name: flopr
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


module flopr #(parameter N = 8)(
    input logic clk, 
    input logic rst,
    input logic [N-1:0] d,
    output logic [N-1:0] q
    );
    
    always_ff@(posedge clk or posedge rst) begin 
        if(rst) begin
            q <= 0;  
        end
        else begin 
            q <= d; 
        end
    end
endmodule
