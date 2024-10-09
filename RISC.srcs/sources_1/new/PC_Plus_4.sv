`timescale 1ns / 1ps

module PC_Plus_4 (
    input  wire [31:0] PC,
    output wire [31:0] PCPlus4
);

  N_bit_Adder #(
      .N(32)
  ) PC_Plus_4_A_Adder (
      .A(PC),
      .B(32'd4),
      .en(1'b1),
      .cin(0),
      .cout(),
      .Sum(PCPlus4)
  );


endmodule
