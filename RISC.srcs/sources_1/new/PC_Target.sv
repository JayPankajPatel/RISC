`timescale 1ns / 1ps

module PC_Target (
    input  wire [31:0] PC,
    ImmExt,
    output wire [31:0] PCTarget
);

  N_bit_Adder #(
      .N(32)
  ) PC_TARGET_ADDER (
      .A(PC),
      .B(ImmExt),
      .cin(1'b0),
      .en(1'b1),
      .cout(),
      .Sum(PCTarget)
  );


endmodule
