`timescale 1ns / 1ps

module Instruction_Memory (
    input  [31:0] A,
    output [31:0] RD
);

  reg [31:0] I_MEM_BLOCK[63:0];

  initial begin
    $readmemh(
        "/home/jay/SJSU_EE_Masters/Classes/EE-275-Advanced-Computer-Arch/RISC/Test_Programs/machine_code/test_program.txt",
        I_MEM_BLOCK);



  end

  assign RD = I_MEM_BLOCK[A[31:2]];  // word aligned

endmodule
