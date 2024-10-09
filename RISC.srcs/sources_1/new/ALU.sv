`timescale 1ns / 1ps



module ALU(
	   input wire signed [31:0]  A,B, // made it signed for sra to work
	   input wire  [4:0]   ALUControl,
	   output wire 	      Zero,
	   output wire Lt, 
	   output wire Lte, 
	   output wire  Overflow,
	   output wire Underflow,

	   output wire signed [31:0] Result );

   reg [31:0]		      ResultReg;
   wire [31:0]		      Add_or_Sub,Sum, cin_or_nocin, AUIPC, mul, mulh;
   reg [63:0]             Product; 
   wire			       slt, sltu; 
   reg Overflow, Underflow; 
   wire [31:0] And_A_B, Or_A_B, Xor_A_B, Not_A, Not_B;
   wire A_Equal_B, A_Nequal_B, A_Less_B, A_LessEq_B, A_Greater_B, A_GreaterEq_B; 
  wire unsigned_A_equal_B; 
wire unsigned_A_neq_B;                           
wire unsigned_A_less_B;                          
wire unsigned_A_lesseq_B;                        
wire unsigned_A_greater_B;                       
wire unsigned_A_greatereq_B;                     
wire signed_A_equal_B;                           
wire signed_A_neq_B;                             
wire signed_A_less_B;                            
wire signed_A_lesseq_B;                          
wire signed_A_greater_B;                         
wire signed_A_greatereq_B;


   //~B if ALUControl[0] is set 1 for subtraction (R Type]
   assign Add_or_Sub = ALUControl[0] ? ~B:B;
   assign cin_or_nocin = ALUControl[0] ? 1'b1 : 1'b0; 

   
    N_bit_Adder #(
    .N(32)
) ALU_inst(
    .A(A),
    .B(Add_or_Sub),
    // if you aren't using cin make sure to set it to zero. 
    .cin(cin_or_nocin),
    .en(1'b1),
    .cout(),
    .Sum(Sum)
);





N_bit_logical_operators #(.N(32)) ALU_LOGICIAL_INS(
    .A(A),
    .B(B),
    .en(1'b1), 
    .AND_A_B(And_A_B),  
    .OR_A_B(Or_A_B),   
    .XOR_A_B(Xor_A_B),  
    .NOT_A(Not_A),    
    .NOT_B(Not_B)     
);

N_bit_comparator #(.N(32)) ALU_COMPARE_INST
(
  .A(A),
  .B(B),
  .en(1'b1),
  
    // Unsigned comparison outputs
    .unsigned_A_equal_B    (unsigned_A_equal_B),  
    .unsigned_A_neq_B      (unsigned_A_neq_B),    
    .unsigned_A_less_B     (unsigned_A_less_B),   
    .unsigned_A_lesseq_B   (unsigned_A_lesseq_B), 
    .unsigned_A_greater_B  (unsigned_A_greater_B),
    .unsigned_A_greatereq_B(unsigned_A_greatereq_B),
    
    // Signed comparison outputs
    .signed_A_equal_B      (signed_A_equal_B),    
    .signed_A_neq_B        (signed_A_neq_B),      
    .signed_A_less_B       (signed_A_less_B),     
    .signed_A_lesseq_B     (signed_A_lesseq_B),   
    .signed_A_greater_B    (signed_A_greater_B),  
    .signed_A_greatereq_B  (signed_A_greatereq_B)

);

   assign Overflow = (ALUControl[0]) ?
                  // Addition Overflow Condition
                  ((~(A[31] ^ B[31])) & (A[31] ^ Sum[31])) :
                  // Subtraction Overflow Condition
                  ((A[31] ^ B[31]) & (A[31] ^ Sum[31]));

   assign Underflow = (~ALUControl[0]) & (signed_A_less_B);
               
   assign slt = signed_A_less_B; 
   
   assign sltu = unsigned_A_less_B; 
   
   assign Product = A * B; 
   
   assign mul = Product[31:0]; 
   assign mulh = Product[63:32]; 
   

 always @(*) begin
    Overflow = 0; 
    Underflow = 0; 
    case(ALUControl)
        5'b00000: // Addition case
        begin
            ResultReg = Sum; 
            // Addition Overflow: Occurs if A and B have the same sign but Sum has a different sign
            Overflow = (~(A[31] ^ B[31])) & (A[31] ^ Sum[31]);
            // Underflow is not meaningful in signed/unsigned addition, set to 0
            Underflow = 0;
        end
        
        5'b00001: // Subtraction case
        begin
            ResultReg = Sum; // Result of subtraction (A - B)
            // Subtraction Overflow: A and B have different signs, and A and Sum have different signs
            Overflow = (A[31] ^ B[31]) & (A[31] ^ Sum[31]);
            // For signed comparison, underflow occurs if A is less than B
            Underflow = signed_A_less_B;  // Ensure signed_A_less_B is computed properly
        end

        5'b00010: ResultReg = And_A_B;      // AND operation
        5'b00011: ResultReg = Or_A_B;       // OR operation
        5'b00100: ResultReg = Xor_A_B;      // XOR operation
        5'b00101: ResultReg = {31'b0, slt}; // SLT (Set on Less Than)
        5'b00110: ResultReg = {31'b0, sltu}; // SLTU (Set on Less Than Unsigned)
        
       

        
        // Multiply Operations
        5'b10000: ResultReg =  mul; //MUL lower result of mulitplication
        5'b10001: ResultReg =  mulh; //MULH upper result of mulitplication

        default: ResultReg = 'bx; // Undefined case: Result is 'X'
    endcase
end


   assign Zero = ~(|ResultReg);
   assign Result = ResultReg;
   assign Lt = signed_A_less_B;
   assign Lte = signed_A_lesseq_B; 
   
   

endmodule
