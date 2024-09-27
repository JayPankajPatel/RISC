`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/27/2024 12:03:59 AM
// Design Name: 
// Module Name: three_to_1_mux
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


module three_to_1_mux #(parameter N = 32)(
    input logic [N-1:0] A, 
    input logic [N-1:0] B,
    input logic [N-1:0] C,
    input logic [1:0] select,
    output logic [N-1:0] Y
    );
    
    assign Y = select[1] ? C : (select[0] ? B : A); 
endmodule
