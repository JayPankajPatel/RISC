`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/23/2024 05:24:15 PM
// Design Name: 
// Module Name: N_bit_AND
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module N_bit_AND #(parameter N = 32)(
    input logic [N-1:0] A, 
    input logic [N-1:0] B, 
    input logic en, 
    output logic [N-1:0] Y
    );
    
    wire temp_from_first_itr;
    reg [N-1:0] temp_Y; 
    
    genvar i ; 
    
    generate
    
        for( i = 0; i < N; i = i + 1) begin
        
            one_bit_AND(
                .a(A[i]),
                .b(B[i]),
                .y(temp_Y[i])
            );
        end
    endgenerate
    
    always_comb begin 
        if(en) begin 
            Y = temp_Y; 
        end
        
        else begin
            Y = 0;
        end
    
    end
    
   
    
endmodule

module one_bit_AND (

    input logic a,
    input logic b,
    output logic y

);

assign y =  a & b; 

endmodule 
