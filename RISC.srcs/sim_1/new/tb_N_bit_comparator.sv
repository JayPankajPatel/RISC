`timescale 1ns / 1ps

module tb_N_bit_comparator;

  localparam N = 32;

  logic signed [N-1:0] tb_A;
  logic signed [N-1:0] tb_B;
  logic tb_en;

  // Unsigned comparison results
  logic
      unsigned_A_equal_B,
      unsigned_A_neq_B,
      unsigned_A_less_B,
      unsigned_A_lesseq_B,
      unsigned_A_greater_B,
      unsigned_A_greatereq_B;

  // Signed comparison results
  logic
      signed_A_equal_B,
      signed_A_neq_B,
      signed_A_less_B,
      signed_A_lesseq_B,
      signed_A_greater_B,
      signed_A_greatereq_B;

  // Instantiate the N_bit_comparator
  N_bit_comparator #(
      .N(N)
  ) MUT (
      .A (tb_A),
      .B (tb_B),
      .en(tb_en),

      // Unsigned outputs
      .unsigned_A_equal_B(unsigned_A_equal_B),
      .unsigned_A_neq_B(unsigned_A_neq_B),
      .unsigned_A_less_B(unsigned_A_less_B),
      .unsigned_A_lesseq_B(unsigned_A_lesseq_B),
      .unsigned_A_greater_B(unsigned_A_greater_B),
      .unsigned_A_greatereq_B(unsigned_A_greatereq_B),

      // Signed outputs
      .signed_A_equal_B(signed_A_equal_B),
      .signed_A_neq_B(signed_A_neq_B),
      .signed_A_less_B(signed_A_less_B),
      .signed_A_lesseq_B(signed_A_lesseq_B),
      .signed_A_greater_B(signed_A_greater_B),
      .signed_A_greatereq_B(signed_A_greatereq_B)
  );

  initial begin
    tb_en = 1;

    // Test 1: A = 50, B = 50
    tb_A  = $signed(32'sd50);
    tb_B  = $signed(32'sd50);
    #100;  // Delay to allow signals to propagate and stabilize
    $display("Test 1: A = %0d, B = %0d", tb_A, tb_B);
    assert (unsigned_A_equal_B && signed_A_equal_B)
    else $fatal("Test 1 Failed: A != B for both unsigned and signed");
    assert(unsigned_A_lesseq_B && signed_A_lesseq_B && unsigned_A_greatereq_B && signed_A_greatereq_B)
    else $fatal("Test 1 Failed: A <= B and A >= B should be true when A == B");

    // Test 2: A = 10, B = 20
    tb_A = $signed(32'sd10);
    tb_B = $signed(32'sd20);
    #100;
    $display("Test 2: A = %0d, B = %0d", tb_A, tb_B);
    assert (unsigned_A_less_B && signed_A_less_B)
    else $fatal("Test 2 Failed: A should be less than B for both unsigned and signed");
    assert (unsigned_A_greater_B == 0 && signed_A_greater_B == 0)
    else $fatal("Test 2 Failed: A should not be greater than B");

    // Test 3: A = 100, B = 50
    tb_A = $signed(32'sd100);
    tb_B = $signed(32'sd50);
    #100;
    $display("Test 3: A = %0d, B = %0d", tb_A, tb_B);
    assert (unsigned_A_greater_B && signed_A_greater_B)
    else $fatal("Test 3 Failed: A should be greater than B for both unsigned and signed");
    assert (unsigned_A_less_B == 0 && signed_A_less_B == 0)
    else $fatal("Test 3 Failed: A should not be less than B");

    // Test 4: A = 0, B = 0
    tb_A = $signed(32'sd0);
    tb_B = $signed(32'sd0);
    #100;
    $display("Test 4: A = %0d, B = %0d", tb_A, tb_B);
    assert (unsigned_A_equal_B && signed_A_equal_B)
    else $fatal("Test 4 Failed: A != B for both unsigned and signed");
    assert(unsigned_A_lesseq_B && signed_A_lesseq_B && unsigned_A_greatereq_B && signed_A_greatereq_B)
    else $fatal("Test 4 Failed: A <= B and A >= B should be true when A == B");

    // Test 5: A = 1, B = -1 (Unsigned: A < B, Signed: A > B)
    tb_A = $signed(32'sd1);
    tb_B = $signed(-32'sd1);
    #100;
    $display("Test 5: A = %0d, B = %0d", tb_A, tb_B);
    assert (unsigned_A_less_B && signed_A_greater_B)
    else
      $fatal(
          "Test 5 Failed: Unsigned: A should be less than B, Signed: A should be greater than B"
      );
    assert (unsigned_A_greatereq_B == 0 && signed_A_less_B == 0)
    else
      $fatal(
          "Test 5 Failed: Unsigned: A should not be greater than B, Signed: A should not be less than B"
      );

    // Test 6: A = -20, B = 255 (Unsigned A > B, Signed A < B)
    tb_A = $signed(-32'sd20);
    tb_B = $signed(32'sd255);
    #100;
    $display("Test 6: A = %0d, B = %0d", tb_A, tb_B);
    assert (unsigned_A_greater_B && signed_A_less_B)
    else
      $fatal("Test 6 Failed: Unsigned A should be greater than B, Signed A should be less than B");
    assert (unsigned_A_less_B == 0 && signed_A_greater_B == 0)
    else
      $fatal(
          "Test 6 Failed: Unsigned A should not be less than B, Signed A should not be greater than B"
      );
    tb_en = 0;  // Disable the comparator

    $display("All tests passed");
    $finish;
  end

endmodule
