`timescale 1ns / 1ps

module N_bit_comparator #(parameter N = 32)
(
  input  logic [N-1:0] A,
  input  logic [N-1:0] B,
  input  logic en,
  
  // Unsigned comparison outputs
  output logic unsigned_A_equal_B,
  output logic unsigned_A_neq_B,
  output logic unsigned_A_less_B,
  output logic unsigned_A_lesseq_B,
  output logic unsigned_A_greater_B,
  output logic unsigned_A_greatereq_B,

  // Signed comparison outputs
  output logic signed_A_equal_B,
  output logic signed_A_neq_B,
  output logic signed_A_less_B,
  output logic signed_A_lesseq_B,
  output logic signed_A_greater_B,
  output logic signed_A_greatereq_B
);

  wire [N-1:0] XOR_A_B, NOT_A, NOT_B;
  wire [N-1:0] A_minus_B_unsigned;
  wire [N-1:0] A_minus_B_signed;
  wire carry_out_unsigned;
  wire subtract_cin = 1'b1;  // Carry-in for 2's complement subtraction

  // Instantiate N_bit_logical_operators for bitwise operations
  N_bit_logical_operators #(.N(N)) logical_ops (
    .A(A),
    .B(B),
    .en(en),
    .AND_A_B(),  
    .OR_A_B(),    
    .XOR_A_B(XOR_A_B),  // Needed for equality check
    .NOT_A(NOT_A),      // Needed for 2's complement (subtraction)
    .NOT_B(NOT_B)       // Needed for 2's complement (subtraction)
  );

  // Unsigned subtraction
  N_bit_Adder #(.N(N)) adder_unsigned (
    .A(A),
    .B(NOT_B),           
    .cin(subtract_cin),   
    .en(en),
    .cout(carry_out_unsigned),
    .Sum(A_minus_B_unsigned)
  );

  // Signed subtraction (same as unsigned subtraction in 2's complement)
  assign A_minus_B_signed = A_minus_B_unsigned;

  // Unsigned comparisons:
  assign unsigned_A_equal_B   = &(~XOR_A_B);            // Equality check using XOR
  assign unsigned_A_neq_B     = ~unsigned_A_equal_B;    // Not equal if not all bits are 0
  assign unsigned_A_less_B    = ~carry_out_unsigned;    // Less than if there's a borrow (carry-out is 0)
  assign unsigned_A_lesseq_B  = unsigned_A_less_B | unsigned_A_equal_B;
  assign unsigned_A_greater_B = ~unsigned_A_lesseq_B;
  assign unsigned_A_greatereq_B = ~unsigned_A_less_B;

  // Signed comparisons:
  logic A_sign, B_sign, MSB_A_minus_B_signed;
  assign A_sign = A[N-1];  // MSB as sign for signed numbers
  assign B_sign = B[N-1];
  assign MSB_A_minus_B_signed = A_minus_B_signed[N-1];  // MSB for signed result

  assign signed_A_equal_B   = unsigned_A_equal_B;  // Signed equality is the same as unsigned
  assign signed_A_neq_B     = unsigned_A_neq_B;

  // Implementing signed less than without using < operator
  assign signed_A_less_B = ( A_sign & ~B_sign ) |                              // A negative, B positive
                           (~(A_sign ^ B_sign) & MSB_A_minus_B_signed );       // A and B same sign, check MSB of A-B

  assign signed_A_lesseq_B  = signed_A_less_B | signed_A_equal_B;
  assign signed_A_greater_B = ~signed_A_lesseq_B;
  assign signed_A_greatereq_B = ~signed_A_less_B;

endmodule
