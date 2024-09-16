`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/13/2024 05:31:50 PM
// Design Name: 
// Module Name: shift_add_mult
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


module shift_add_mult #(parameter N = 32)(
    
    input logic clk, 
    input logic rst,
    input logic en,
    input logic signed [N-1:0] A, // Multiplicand
    input logic signed [N-1:0] B, // Multiplier
    output logic signed [2*N-1:0] Product, 
    output logic done
    );
    // flip flop to save all the signs
    logic [2:0] signs;
    logic [N-1:0] multiplicand;
    logic [N-1:0] multiplier;
    logic load; 
    logic shift_right;
    logic [N-1:0] shift_reg_q; 
    logic shift_reg_sout; 

    
    always_ff@(posedge clk or posedge rst) begin 
      if(rst) begin 
        en <= 0;
        A <= 0;
        B <= 0;
        Product <= 0;
        done <= 0;
      end 
        
       
    end
     
     
endmodule
