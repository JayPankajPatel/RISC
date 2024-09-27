`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/23/2024 10:52:47 PM
// Design Name: 
// Module Name: N_bit_compare
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

module N_bit_comparator #(parameter N = 32)
(
  input  logic [N-1:0] A,
  input  logic [N-1:0] B,
  
  input logic en,
  
  output logic A_equal_B,
  output logic A_neq_B,
  output logic A_less_B,
  output logic A_lesseq_B,
  output logic A_greater_B,
  output logic A_greatereq_B
);

  logic [N-1:0] xnor_result;
  logic [N-1:0] less_than_bits;
  logic [N:0] carry;

  always_comb begin
        if(en) begin 
        // Equality check using XNOR
        xnor_result = ~(A ^ B);
        A_equal_B = &xnor_result;
        A_neq_B = ~A_equal_B;
    
        // Less than comparison
        carry[0] = 1'b0;
        for (int i = 0; i < N; i++) begin
          carry[i+1] = (B[i] & ~A[i]) | ((B[i] ^ ~A[i]) & carry[i]);
        end
        
        A_less_B = carry[N];
        A_lesseq_B = A_less_B | A_equal_B;
    
        // Greater than comparison
        A_greater_B = ~(A_equal_B | A_less_B);
        A_greatereq_B = A_greater_B | A_equal_B;
        end
        
      else begin
        A_equal_B   = {N{1'bz}}; 
        A_neq_B   = {N{1'bz}};
        A_less_B  = {N{1'bz}};
        A_lesseq_B = {N{1'bz}};
        A_greater_B = {N{1'bz}};
        A_greatereq_B = {N{1'bz}};
      end
  end

endmodule
