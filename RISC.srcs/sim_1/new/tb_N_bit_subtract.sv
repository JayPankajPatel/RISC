`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/12/2024 12:00:23 AM
// Design Name: 
// Module Name: tb_N_bit_subtract
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


module tb_N_bit_subtract ();
  parameter N = 32;
  parameter NUM_TESTS = 1000;

  reg signed [N-1:0] tb_A, tb_B;
  wire signed [N-1:0] tb_Sum;

  reg signed  [N-1:0] expected_Sum;

  N_bit_subtract #(
      .N(N)
  ) MUT (
      .A  (tb_A),
      .B  (tb_B),
      .en (1),
      .Sum(tb_Sum)
  );

  // Stimulus block
  initial begin

    // Generate test cases
    for (int i = 0; i < NUM_TESTS; i++) begin
      // Assign random values to inputs
      tb_A = $urandom % {32{1'b1}};  //Random value from 0 to 2^32 -1;
      tb_B = $urandom % {32{1'b1}};  //Random value from 0 to 2^32 -1;


      // Perform the addition
      expected_Sum = tb_A - tb_B;


      // Delay to allow DUT to compute
      #10;

      // Display results
      $display("Test %0d: A = %0d, B = %0d, Sum = %0d, Expected_Sum = %0d", i, tb_A, tb_B, tb_Sum,
               expected_Sum,);

      // Assertions to verify correctness of outputs
      assert (tb_Sum == expected_Sum)
      else
        $fatal(
            "Assertion Failed at Test %0d: A = %0d, B = %0d, Sum = %0d, Expected_Sum = %0d",
            i,
            tb_A,
            tb_B,
            tb_Sum,
            expected_Sum
        );
    end
    tb_A = {32{1'b0}};
    tb_B = {32{1'b1}};

    expected_Sum = tb_A - tb_B;

    #10
    // Assertions to verify correctness of outputs
    assert (tb_Sum == expected_Sum)
    else
      $fatal(
          "Assertion Failed at Test %0d: A = %0d, B = %0d, Sum = %0d, Expected_Sum = %0d",
          1001,
          tb_A,
          tb_B,
          tb_Sum,
          expected_Sum
      );

    tb_A = {32{1'b0}};
    tb_B = {32{1'b0}};

    expected_Sum = tb_A - tb_B;

    #10
    assert (tb_Sum == expected_Sum)
    else
      $fatal(
          "Assertion Failed at Test %0d: A = %0d, B = %0d, Sum = %0d, Expected_Sum = %0d",
          1002,
          tb_A,
          tb_B,
          tb_Sum,
          expected_Sum
      );



    // End simulation
    $finish;
  end
endmodule
