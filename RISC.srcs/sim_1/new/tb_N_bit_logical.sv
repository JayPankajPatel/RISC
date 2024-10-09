`timescale 1ns / 1ps

module tb_N_bit_logical ();

  localparam N = 32;

  logic [N-1:0] tb_A, tb_B;
  logic tb_en;
  logic [N-1:0] tb_AND_A_B, tb_OR_A_B, tb_XOR_A_B, tb_NOT_A, tb_NOT_B;

  // DUT instantiation
  N_bit_logical_operators #(
      .N(N)
  ) DUT (
      .A(tb_A),
      .B(tb_B),
      .en(tb_en),
      .AND_A_B(tb_AND_A_B),
      .OR_A_B(tb_OR_A_B),
      .XOR_A_B(tb_XOR_A_B),
      .NOT_A(tb_NOT_A),
      .NOT_B(tb_NOT_B)
  );

  // Testbench logic
  initial begin
    // Test Case 1: Enable is off (outputs should be high impedance 'z')
    tb_A  = 32'hFFFFFFFF;
    tb_B  = 32'h00000000;
    tb_en = 1'b0;

    #10;  // Wait for 10 time units
    $display("Test Case 1: Enable off");
    $display("Actual AND_A_B: %h", tb_AND_A_B);
    $display("Actual OR_A_B: %h", tb_OR_A_B);
    $display("Actual XOR_A_B: %h", tb_XOR_A_B);
    $display("Actual NOT_A: %h", tb_NOT_A);
    $display("Actual NOT_B: %h", tb_NOT_B);

    assert (tb_AND_A_B === {N{1'bz}})
    else $error("Assertion Failed: AND_A_B != 'z' when en = 0");
    assert (tb_OR_A_B === {N{1'bz}})
    else $error("Assertion Failed: OR_A_B != 'z' when en = 0");
    assert (tb_XOR_A_B === {N{1'bz}})
    else $error("Assertion Failed: XOR_A_B != 'z' when en = 0");
    assert (tb_NOT_A === {N{1'bz}})
    else $error("Assertion Failed: NOT_A != 'z' when en = 0");
    assert (tb_NOT_B === {N{1'bz}})
    else $error("Assertion Failed: NOT_B != 'z' when en = 0");

    // Test Case 2: Enable is on with default inputs
    tb_en = 1'b1;
    #10;  // Wait for 10 time units
    $display("Test Case 2: Enable on, A = 32'hFFFFFFFF, B = 32'h00000000");
    $display("Actual AND_A_B: %h", tb_AND_A_B);
    $display("Actual OR_A_B: %h", tb_OR_A_B);
    $display("Actual XOR_A_B: %h", tb_XOR_A_B);
    $display("Actual NOT_A: %h", tb_NOT_A);
    $display("Actual NOT_B: %h", tb_NOT_B);

    assert (tb_AND_A_B == (tb_A & tb_B))
    else $error("Assertion Failed: AND_A_B incorrect");
    assert (tb_OR_A_B == (tb_A | tb_B))
    else $error("Assertion Failed: OR_A_B incorrect");
    assert (tb_XOR_A_B == (tb_A ^ tb_B))
    else $error("Assertion Failed: XOR_A_B incorrect");
    assert (tb_NOT_A == ~tb_A)
    else $error("Assertion Failed: NOT_A incorrect");
    assert (tb_NOT_B == ~tb_B)
    else $error("Assertion Failed: NOT_B incorrect");

    // Test Case 3: Different input values
    tb_A = 32'hA5A5A5A5;
    tb_B = 32'h5A5A5A5A;
    #10;  // Wait for 10 time units
    $display("Test Case 3: A = 32'hA5A5A5A5, B = 32'h5A5A5A5A");
    $display("Actual AND_A_B: %h", tb_AND_A_B);
    $display("Actual OR_A_B: %h", tb_OR_A_B);
    $display("Actual XOR_A_B: %h", tb_XOR_A_B);
    $display("Actual NOT_A: %h", tb_NOT_A);
    $display("Actual NOT_B: %h", tb_NOT_B);

    assert (tb_AND_A_B == (tb_A & tb_B))
    else $error("Assertion Failed: AND_A_B incorrect");
    assert (tb_OR_A_B == (tb_A | tb_B))
    else $error("Assertion Failed: OR_A_B incorrect");
    assert (tb_XOR_A_B == (tb_A ^ tb_B))
    else $error("Assertion Failed: XOR_A_B incorrect");
    assert (tb_NOT_A == ~tb_A)
    else $error("Assertion Failed: NOT_A incorrect");
    assert (tb_NOT_B == ~tb_B)
    else $error("Assertion Failed: NOT_B incorrect");

    $stop;
  end

endmodule
