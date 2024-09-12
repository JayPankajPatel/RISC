`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/11/2024 02:42:16 AM
// Design Name: 
// Module Name: N_bit_subtract
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


module N_bit_subtract #(
    parameter N = 32
) (
    input logic signed [N-1:0] A,
    input logic signed [N-1:0] B,
    input logic cin,
    output logic cout,
    output logic signed [N-1:0] Sum
);
  logic signed [N-1:0] negative_B;
  N_bit_adder #(.N(N)) SUB (

     .A(),
     .B(),
     .cin(),
     .cout(),
     .Sum()

    );

endmodule
