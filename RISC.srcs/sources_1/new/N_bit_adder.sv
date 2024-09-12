`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 09/08/2024 05:55:08 PM
// Design Name:
// Module Name: N_bit_adder
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

module N_bit_adder #(
    parameter N = 32
) (
    input logic signed [N-1:0] A,
    input logic signed [N-1:0] B,
    input logic  cin,
    output logic cout,
    output logic signed [N-1:0] Sum
);

  reg carry_out_temp[N-1:0];

  one_bit_adder FA1 (
    .a(A[0]),
    .b(B[0]),
    .cin(cin),
    .cout(carry_out_temp[0]),
    .sum(Sum[0])
    );

    genvar i; 
    
    generate
      for(i = 1; i <= N-1; i = i + 1) begin: gen_full_adder
        one_bit_adder FAx (
          .a(A[i]),
          .b(B[i]),
          .cin(carry_out_temp[i-1]),
          .cout(carry_out_temp[i]),
          .sum(Sum[i])
          );
      end
    endgenerate

    assign cout = carry_out_temp[N-1];



endmodule



