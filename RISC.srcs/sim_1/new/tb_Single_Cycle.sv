`timescale 1ns / 1ps

module tb_Single_Cycle();

reg clk = 0, reset;
wire [31:0] WriteData, DataAddr;
wire MemWrite;

always #10 clk = ~clk;  // 50 MHz clock

Single_Cycle_Top DUT(
    .clk(clk),
    .reset(reset),
    .WriteData(WriteData),
    .DataAddr(DataAddr),
    .MemWrite(MemWrite)
);
  
initial begin
    // Start by asserting reset (hold reset for the first 20 ns)
    reset = 1;
    #20; reset = 0;  // De-assert reset after 20 ns
end

always @(posedge clk) begin
    if (MemWrite) begin
        // Check if data 25 is written to address 100
        if (DataAddr === 'h275 && WriteData === -61) begin
            $display("PASSED: Data -61 written at address 0x275");
            // Continue testing for the next operation, or stop if the test is complete
        end
        // (Optional) Uncomment for second store check
        // else if (DataAddr == 104 && WriteData == 375) begin
        //     $display("PASSED: Data 375 written at address 104");
        //     $stop;
        // end
    end
end

endmodule
