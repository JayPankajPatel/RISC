`timescale 1ns / 1ps

module tb_Single_Cycle ();

  reg clk = 0, reset;
  wire [31:0] WriteData, DataAddr;
  wire MemWrite;

  always #10 clk = ~clk;  // 50 MHz clock

  Single_Cycle_Top DUT (
      .clk(clk),
      .reset(reset),
      .WriteData(WriteData),
      .DataAddr(DataAddr),
      .MemWrite(MemWrite)
  );

  initial begin
    // Start by asserting reset (hold reset for the first 20 ns)
    reset = 1;
    #20;
    reset = 0;  // De-assert reset after 20 ns
  end

  always @(posedge clk) begin
    if (MemWrite) begin
      // Check if data -610 is written to address 0x275
      if (DataAddr === 'h275 && WriteData === -610) begin
        $display("PASSED: Data -610 written at address 0x275");
        // Continue testing for the next operation, or stop if the test is complete
      end

    end
  end

endmodule
