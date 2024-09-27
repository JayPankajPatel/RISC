`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/27/2024 12:01:08 AM
// Design Name: 
// Module Name: two_to_1_mux
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


module two_to_1_mux #(parameter N = 32)(
    input logic [N-1:0] A, 
    input logic [N-1:0] B,
    input logic select,
    output logic [N-1:0] Y
    );
    
    assign Y = select ? B : A; 
endmodule
