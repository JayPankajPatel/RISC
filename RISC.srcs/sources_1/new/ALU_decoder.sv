`timescale 1ns / 1ps


 module ALU_Decoder(
		   input wire	    opb5, //bit 5 of the opcode
		   input wire [2:0] funct3, // instr[14:12]
		   input wire	    funct7b5, // bit 30 of instruction
		   input wire [6:0] funct7, 
		   input wire [1:0] ALUOp,
		   output reg [4:0] ALUControl
		   );

   wire				    RtypeSub;
   assign RtypeSub = funct7b5 & opb5; //TRUE for R-type substract

   always@(*)
     begin
	case(ALUOp)
          2'b00:  ALUControl = 5'b0000; //addition
          2'b01:  ALUControl = 5'b0001; //subtraction or auipc
          2'b10: //ALUOp = 2'b10 and beyond
            case(funct3)//R-type or I-type ALU
              3'b000:    
                if (RtypeSub) ALUControl = 5'b00001; //sub
                else if (funct7 == 7'b0000001)
                    ALUControl = 5'b10000; // mul 
                else ALUControl = 5'b00000; //add,addi
                3'b001: 
                if (funct7 == 7'b0000001)
                    ALUControl = 5'b10001; // mulh 
                else
                    ALUControl = 5'b01010; // sll, slli;
              3'b010: ALUControl = 5'b00101; //slt,slti
              3'b011: ALUControl = 5'b00110; //sltu, sltui
              3'b100: ALUControl = 5'b00100; //xor
              3'b101: 
                if (funct7b5) ALUControl = 5'b01011; //sra
                else ALUControl = 5'b01100; // srl
               
              3'b110: ALUControl = 5'b00011; //or,ori
              3'b111: ALUControl = 5'b00010; //and,andi
              default: ALUControl = 5'bxxxxx; 
            endcase
          2'b11: //ALUOp = 2'b11 and beyond
            case(funct3)
              3'b000: ALUControl = 5'b001000; // AUIPC
              3'b001: ALUControl = 5'b001001; // LUI
              default: ALUControl = 5'bxxxxx;
            endcase
          default: ALUControl = 5'bxxxxx;
          //ALU Control
          //3'b000 = addition (add, addi)
          //3'b001 = subtraction (sub)
          //3'b010 = and (and, andi)
          //3'b011 = or (or, ori)
          //3'b100 = xor (xor, xori)
          //3'b101 = set less than (slt, slti)
          //3'b110 = set less than unsigned (sltu, sltui)
	endcase
     end

endmodule

