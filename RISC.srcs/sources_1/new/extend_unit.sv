`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/26/2024 10:03:59 PM
// Design Name: 
// Module Name: extend_unit
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


module extend_unit(
    input logic [31:7] instruction,
    input logic [1:0] immediate_src,
    output logic [31:0] immediate_next
);

    always_comb begin
        case(immediate_src)
            // I-type
            2'b00: immediate_next = {{20{instruction[31]}}, instruction[31:20]};
            // S-type (stores)
            2'b01: immediate_next = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};
            // B-type (branches)
            2'b10: immediate_next = {{20{instruction[31]}}, instruction[7], instruction[30:25], instruction[11:8], 1'b0};
            // J-type (jal)
            2'b11: immediate_next = {{12{instruction[31]}}, instruction[19:12], instruction[20], instruction[30:21], 1'b0};
            default: immediate_next = 32'bx; // undefined
        endcase
    end 

endmodule
