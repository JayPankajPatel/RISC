`timescale 1ns / 1ps

module Control_Unit (
    input wire [6:0] op,
    input wire [2:0] funct3,
    input wire [6:0] funct7,
    input wire       funct7b5,
    Zero,  // function 7 is the 5th bit
    input wire       Lt,
    Lte,

    output wire [1:0] ResultSrc,
    output wire       MemWrite,
    PCSrc,
    ALUSrc,
    RegWrite,
    Jump,
    output wire [1:0] ImmSrc,
    output wire [4:0] ALUControl
);

  wire [1:0] ALUop;
  wire       Branch;

  Main_Decoder Main_Decoder (
      .op(op),
      .ResultSrc(ResultSrc),
      .MemWrite(MemWrite),
      .Branch(Branch),
      .ALUSrc(ALUSrc),
      .RegWrite(RegWrite),
      .Jump(Jump),
      .ImmSrc(ImmSrc),
      .ALUop(ALUop)
  );

  ALU_Decoder ALU_Decoder (
      .opb5(op[5]),
      .funct3(funct3),
      .funct7(funct7),
      .funct7b5(funct7b5),
      .ALUOp(ALUop),
      .ALUControl(ALUControl)
  );

  


  //assign PCSrc = Branch & Zero | Jump;
  assign PCSrc = (Branch & ((funct3 == 3'b000) & Zero) |  // BEQ: Branch if equal (Zero)
      ((funct3 == 3'b001) & ~Zero) |  // BNE: Branch if not equal
      ((funct3 == 3'b100) & Lt) |  // BLT: Branch if less than
      ((funct3 == 3'b101) & ~Lt)) |  // BGE: Branch if greater than or equal 
      Jump;  // Jump always branche



endmodule

