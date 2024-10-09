module tb_shiftreg;
  // Parameters
  parameter N = 32;

  // Testbench signals
  logic tb_clk;
  logic tb_rst;
  logic tb_sin;
  logic tb_load;
  logic tb_shift_right;
  logic [N-1:0] tb_d;
  logic [N-1:0] tb_q;
  logic tb_sout;
  logic [N-1:0] expected_q;
  logic expected_sout;

  // Instantiate the shift register module
  shiftreg #(N) uut (
      .clk(tb_clk),
      .rst(tb_rst),
      .sin(tb_sin),
      .load(tb_load),
      .d(tb_d),
      .shift_right(tb_shift_right),
      .q(tb_q),
      .sout(tb_sout)
  );

  // Clock generation
  always #5 tb_clk = ~tb_clk;

  initial begin
    // Initialize signals
    tb_clk = 0;
    tb_rst = 0;
    tb_sin = 0;
    tb_load = 0;
    tb_shift_right = 0;
    tb_d = 0;

    // Apply stimulus
    #10;
    tb_rst = 1;
    #10;
    tb_rst = 0;
    tb_sin = 1;
    #10;
    tb_load = 1;
    tb_d = 32'b1010_1010_1010_1010_1010_1010_1010_1010;
    #10;
    tb_load = 0;
    tb_shift_right = 1;

    // Calculate expected results
    expected_q = {tb_sin, tb_d[N-1:1]};
    expected_sout = tb_q[0];

    // Check results
    #10;
    assert (expected_q == tb_q)
    else $error("Wrong Right Shift: Expected %0b, Got %0b", expected_q, tb_q);
    assert (expected_sout == tb_sout)
    else $error("Wrong Sout: Expected %0b, Got %0b", expected_sout, tb_sout);

    // Finish simulation
    #10;
    $finish;
  end

endmodule
