// Module Name: N_bit_adder_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Testbench for N-bit Adder
// 
// Dependencies: N_bit_adder module
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module N_bit_adder_tb ();
  parameter N = 32;
  parameter NUM_TESTS = 1000;

  reg signed [N-1:0] tb_A, tb_B;
  reg tb_cin;
  reg en; 
  wire tb_cout;
  wire signed [N-1:0] tb_Sum;
  wire tb_overflow; 

  reg signed [N-1:0] expected_Sum;
  reg expected_cout;

  N_bit_Adder #(
      .N(N)
  ) MUT (
      .A(tb_A),
      .B(tb_B),
      .en(en), 
      .cin(tb_cin),
      .cout(tb_cout),
      .Sum(tb_Sum)
  );


  // Stimulus block
  initial begin
     en = 1;
    // Generate test cases
    for (int i = 0; i < NUM_TESTS; i++) begin
      // Assign random values to inputs
      tb_A   = $urandom % {32{1'b1}}; //Random value from 0 to 2^32 -1;
      tb_B   = $urandom % {32{1'b1}}; //Random value from 0 to 2^32 -1;
      tb_cin = $urandom % 2;  // Random value 0 or 1
      
      // Perform the addition
      {expected_cout, expected_Sum} = tb_A + tb_B + tb_cin;

      // Delay to allow DUT to compute
      #10;

      // Display results
      $display(
          "Test %0d: A = %0d, B = %0d, cin = %0d, Sum = %0d, cout = %0d, Expected_Sum = %0d, Expected_cout = %0d",
          i,
          tb_A,
          tb_B,
          tb_cin,
          tb_Sum,
          tb_cout,
          expected_Sum,
          expected_cout
      );

      // Assertions to verify correctness of outputs
      assert (tb_Sum == expected_Sum)
      else $fatal(
          "Assertion Failed at Test %0d: A = %0d, B = %0d, cin = %0d, Sum = %0d, cout = %0d, Expected_Sum = %0d, Expected_cout = %0d",
          i, tb_A, tb_B, tb_cin, tb_Sum, tb_cout, expected_Sum, expected_cout
      );

      assert (tb_cout == expected_cout)
      else $fatal(
          "Assertion Failed at Test %0d: A = %0d, B = %0d, cin = %0d, Sum = %0d, cout = %0d, Expected_Sum = %0d, Expected_cout = %0d",
          i, tb_A, tb_B, tb_cin, tb_Sum, tb_cout, expected_Sum, expected_cout
      );
    end
    // Maximum value edge case
    tb_A = {32{1'b1}};
    tb_B = {32{1'b1}};
    tb_cin = 1;
     {expected_cout, expected_Sum} = tb_A + tb_B + tb_cin;

     #10
      // Assertions to verify correctness of outputs
      assert (tb_Sum == expected_Sum)
      else $fatal(
          "Assertion Failed at Test %0d: A = %0d, B = %0d, cin = %0d, Sum = %0d, cout = %0d, Expected_Sum = %0d, Expected_cout = %0d",
          NUM_TESTS+1, tb_A, tb_B, tb_cin, tb_Sum, tb_cout, expected_Sum, expected_cout
      );

      assert (tb_cout == expected_cout)
      else $fatal(
          "Assertion Failed at Test %0d: A = %0d, B = %0d, cin = %0d, Sum = %0d, cout = %0d, Expected_Sum = %0d, Expected_cout = %0d",
          NUM_TESTS+1, tb_A, tb_B, tb_cin, tb_Sum, tb_cout, expected_Sum, expected_cout
      );
      
      assert(tb_overflow == 1) else $fatal("overflow happened but was not detected"); 

    // Minimum value edge case
    tb_A = {32{1'b0}};
    tb_B = {32{1'b0}};
    tb_cin = 0;

     {expected_cout, expected_Sum} = tb_A + tb_B + tb_cin;

     #10
      // Assertions to verify correctness of outputs
      assert (tb_Sum == expected_Sum)
      else $fatal(
          "Assertion Failed at Test %0d: A = %0d, B = %0d, cin = %0d, Sum = %0d, cout = %0d, Expected_Sum = %0d, Expected_cout = %0d",
          NUM_TESTS+2, tb_A, tb_B, tb_cin, tb_Sum, tb_cout, expected_Sum, expected_cout
      );

      assert (tb_cout == expected_cout)
      else $fatal(
          "Assertion Failed at Test %0d: A = %0d, B = %0d, cin = %0d, Sum = %0d, cout = %0d, Expected_Sum = %0d, Expected_cout = %0d",
          NUM_TESTS+2, tb_A, tb_B, tb_cin, tb_Sum, tb_cout, expected_Sum, expected_cout
      );
    // End simulation
    $finish;
  end
endmodule
