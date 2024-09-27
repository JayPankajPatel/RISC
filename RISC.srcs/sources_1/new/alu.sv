`timescale 1ns/1ps

module alu #(parameter N = 32) (
    input logic signed [N-1:0] A,
    input logic signed [N-1:0] B,
    input logic [3:0] FN, 
    output logic signed [N-1:0] Y,
    output logic overflow,
    output logic underflow, 
    output logic zero
);

    // Internal signals for operations
    logic signed [N-1:0] add_result;
    logic signed [N-1:0] sub_result;
    logic signed [N-1:0] AND_A_B;
    logic signed [N-1:0] OR_A_B;
    logic signed [N-1:0] XOR_A_B;
    logic signed [N-1:0] NOT_A;
    logic signed [N-1:0] NOT_B;

    logic A_equal_B;
    logic A_neq_B;
    logic A_less_B;
    logic A_lesseq_B;
    logic A_greater_B;
    logic A_greatereq_B;
    
    logic signed [N-1:0] temp_for_adder;
    
    // Instantiate the N-bit adder for addition and subtraction
    N_bit_adder #(
        .N(N)
    ) ADDER_or_SUBTRACT (
        .A(A),
        .B(FN == 4'b0000 ? B : ~B),   // Add (0000) or Subtract (0001)
        .en(FN == 4'b0000 || FN == 4'b0001), // Enable for both addition and subtraction
        .cin(FN == 4'b0000 ? 1'b0 : 1'b1),   // No carry-in for addition, 1 for subtraction (two's complement)
        .cout(),           // Ignore cout for now
        .Sum(temp_for_adder) 
    );
    assign add_result = (FN == 4'b0000) ? temp_for_adder : 0; 
    assign sub_result = (FN == 4'b0001) ? temp_for_adder : 0;
    
    // Instantiate logical operators module
    N_bit_logical_operators #(
        .N(N)
    ) LOGICAL_OPS (
        .A(A),
        .B(B),
        .en(1'b1), 
        .AND_A_B(AND_A_B),  // Logical AND output
        .OR_A_B(OR_A_B),    // Logical OR output
        .XOR_A_B(XOR_A_B),  // Logical XOR output
        .NOT_A(NOT_A),      // Logical NOT A output
        .NOT_B(NOT_B)       // Logical NOT B output
    );
    
    logic signed [N-1:0] temp_for_zero; 
    
     N_bit_adder #(
        .N(N)
    ) ZERO (
        .A(A),
        .B(~B),   // Add (0000) or Subtract (0001)
        .en(1'b1), // Enable for both addition and subtraction
        .cin(1'b1),   // No carry-in for addition, 1 for subtraction (two's complement)
        .cout(),           // Ignore cout for now
        .Sum(temp_for_zero) 
    );
    // Zero flag assignment
    assign zero = temp_for_zero == 0 ? 1 : 0; 

    // Instantiate comparator module
    N_bit_comparator #(
        .N(N)
    ) COMPARE (
        .A(A),
        .B(B),
        .en(1'b1),
        .A_equal_B(A_equal_B),
        .A_neq_B(A_neq_B),
        .A_less_B(A_less_B),
        .A_lesseq_B(A_lesseq_B),
        .A_greater_B(A_greater_B),
        .A_greatereq_B(A_greatereq_B)
    );

    // Overflow detection for addition and subtraction
    assign overflow = ((FN == 4'd0) && ((A[N-1] == B[N-1]) && (Y[N-1] != A[N-1]))) ||  // Overflow in addition
                      ((FN == 4'd1) && ((A[N-1] != B[N-1]) && (Y[N-1] != A[N-1])));  // Overflow in subtraction

    // Underflow detection for subtraction
    assign underflow = (FN == 4'd1) && ((A[N-1] != B[N-1]) && (Y[N-1] == B[N-1]));

    // ALU operation selection
    always_comb begin
        case (FN)
            4'd0: Y = add_result;            // Addition
            4'd1: Y = sub_result;            // Subtraction
            4'd2: Y = A * B;                 // TODO: Multiplication (to be implemented)
            4'd3: Y = AND_A_B;               // AND
            4'd4: Y = OR_A_B;                // OR
            4'd5: Y = XOR_A_B;               // XOR
            4'd6: Y = NOT_A;                 // NOT A
            4'd7: Y = NOT_B;                 // NOT B
            4'd8: Y = {{(N-1){1'b0}}, A_equal_B};  // Equality
            4'd9: Y = {{(N-1){1'b0}}, A_neq_B};    // Not equal
            4'd10: Y = {{(N-1){1'b0}}, A_less_B};  // Less than
            4'd11: Y = {{(N-1){1'b0}}, A_lesseq_B}; // Less than or equal
            4'd12: Y = {{(N-1){1'b0}}, A_greater_B}; // Greater than
            4'd13: Y = {{(N-1){1'b0}}, A_greatereq_B}; // Greater than or equal
            default: Y = {N{1'b0}};           // Invalid operation, output zero
        endcase
    end

endmodule
