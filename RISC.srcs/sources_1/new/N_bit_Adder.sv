module N_bit_Adder #(
    parameter N = 32
) (
    input [N-1:0] A,
    input [N-1:0] B,
    // if you aren't using cin make sure to set it to zero. 
    input cin,
    input en,
    output cout,
    output [N-1:0] Sum
);

  wire [N:0] carry_out;  // N+1 bits to hold the carry

  assign carry_out[0] = cin;  // Initialize carry-in

  // First adder (bit 0)
  One_Bit_Adder first_adder (
      .a(A[0]),
      .b(B[0]),
      .cin(carry_out[0]),  // Carry-in for bit 0 is the input cin
      .en(en),
      .sum(Sum[0]),
      .cout(carry_out[1])  // Carry-out for bit 0
  );

  // Generate loop for the remaining bits (1 to N-1)
  generate
    genvar i;
    for (i = 1; i < N; i = i + 1) begin
      One_Bit_Adder cascade (
          .a(A[i]),
          .b(B[i]),
          .cin(carry_out[i]),  // Carry-in from the previous bit
          .en(en),
          .sum(Sum[i]),
          .cout(carry_out[i+1])  // Carry-out to the next bit
      );
    end
  endgenerate

  // Final carry-out
  assign cout = carry_out[N];

endmodule
