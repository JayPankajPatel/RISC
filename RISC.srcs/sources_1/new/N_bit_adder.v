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
    input [N-1:0] A,
    input [N-1:0] B,
    input cin,
    output cout,
    output [N-1:0] Sum
);

  wire [N:0] carry_out;  // 33 bits
  
  assign carry_out[0] = cin;
 

  one_bit_adder first_adder (
      .a(A[0]),
      .b(B[0]),
      .cin(cin),
      .sum(Sum[0]),
      .cout(carry_out[0])
  );


  generate
    genvar i;

    for (i = 1; i < N - 1; i = i + 1) begin
      one_bit_adder cascade (
          .a(A[i]),
          .b(B[i]),
          .cin(carry_out[N-1]),
          .sum(Sum[i]),
          .cout(carry_out[N])
      );

    end


    assign cout = carry_out[N];
  endgenerate


endmodule



