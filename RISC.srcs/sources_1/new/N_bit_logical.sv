module N_bit_logical_operators #(parameter N = 8)(
    input  logic [N-1:0] A,
    input  logic [N-1:0] B,
    input logic en, 
    output logic [N-1:0] AND_A_B,  // Logical AND output
    output logic [N-1:0] OR_A_B,   // Logical OR output
    output logic [N-1:0] XOR_A_B,  // Logical XOR output
    output logic [N-1:0] NOT_A,    // Logical NOT A output
    output logic [N-1:0] NOT_B    // Logical NOT B output
);

    // Internal signals for operations
    logic [N-1:0] and_result;
    logic [N-1:0] or_result;
    logic [N-1:0] xor_result;

    always_comb begin
        if(en) begin
            // Perform bitwise operations
            and_result = A & B;
            or_result = A | B;
            xor_result = A ^ B;
    
            // Assign outputs
            
            for(int i = 0; i < N; i++) begin
                NOT_A[i] = ~A[i];
                NOT_B[i] = ~B[i];
                AND_A_B = A[i] & B[i]; 
                OR_A_B = A[i] | B[i];
                XOR_A_B = A[i] ^ B[i]; 
            end
        
        end
        
        else begin 
            NOT_A = {N{1'bz}};
            NOT_B = {N{1'bz}};
            AND_A_B = {N{1'bz}}; 
            OR_A_B = {N{1'bz}};
            XOR_A_B = {N{1'bz}}; 
        end
        
       end
        
         
        
endmodule
