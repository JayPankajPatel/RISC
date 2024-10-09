`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/30/2024 09:03:43 PM
// Design Name: 
// Module Name: One_Bit_Adder
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


module One_Bit_Adder (
    input a,
    input b,
    input en,
    input cin,
    output reg sum,
    output reg cout
);

  always @(*) begin
    if (en) begin
      sum  = a ^ b ^ cin;
      cout = (a & b) | (b & cin) | (a & cin);
    end else begin
      sum  = 0;
      cout = 0;
    end
  end

endmodule

