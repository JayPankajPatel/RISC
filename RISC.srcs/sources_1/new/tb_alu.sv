`timescale 1ns / 1ps

module tb_alu; 

    // Inputs to the ALU
    reg signed [31:0] A, B;
    reg [4:0] ALUControl;

    // Outputs from the ALU
    wire signed [31:0] Result;
    wire Zero;
    wire Overflow;
    wire Underflow;

    // Instantiate the ALU
    ALU dut (
        .A(A),
        .B(B),
        .ALUControl(ALUControl),
        .Zero(Zero),
        .Overflow(Overflow),
        .Underflow(Underflow),
        .Result(Result)
    );

    // Task to display test case results
    task display_test;
        input [255:0] test_name;
        input signed [31:0] expected_result;
        input expected_zero;
        input expected_overflow;
        input expected_underflow;
        begin
            if (Result !== expected_result || Zero !== expected_zero ||
                Overflow !== expected_overflow || Underflow !== expected_underflow) begin
                $display("Test Failed: %s", test_name);
                $display("Inputs: A = %0d, B = %0d, ALUControl = %b", A, B, ALUControl);
                $display("Expected Result = %0d, Zero = %b, Overflow = %b, Underflow = %b",
                         expected_result, expected_zero, expected_overflow, expected_underflow);
                $display("Actual   Result = %0d, Zero = %b, Overflow = %b, Underflow = %b",
                         Result, Zero, Overflow, Underflow);
            end else begin
                $display("Test Passed: %s", test_name);
            end
        end
    endtask

    initial begin
        // Test Addition (ALUControl = 5'b00000)
        A = 32'd10;
        B = 32'd20;
        ALUControl = 5'b00000;
        #10;
        display_test("Addition", 32'd30, 0, 0, 0);

        // Test Subtraction (ALUControl = 5'b00001)
        A = 32'd50;
        B = 32'd20;
        ALUControl = 5'b00001;
        #10;
        display_test("Subtraction", 32'd30, 0, 0, 0);

        // Test Subtraction with Negative Result
        A = 32'd20;
        B = 32'd50;
        ALUControl = 5'b00001;
        #10;
        display_test("Subtraction Negative Result", -32'd30, 0, 0, 1);

        // Test AND (ALUControl = 5'b00010)
        A = 32'hF0F0F0F0;
        B = 32'h0F0F0F0F;
        ALUControl = 5'b00010;
        #10;
        display_test("AND Operation", 32'h00000000, 1, 0, 0);

        // Test OR (ALUControl = 5'b00011)
        A = 32'hF0F0F0F0;
        B = 32'h0F0F0F0F;
        ALUControl = 5'b00011;
        #10;
        display_test("OR Operation", 32'hFFFFFFFF, 0, 0, 0);

        // Test XOR (ALUControl = 5'b00100)
        A = 32'hFF00FF00;
        B = 32'h00FF00FF;
        ALUControl = 5'b00100;
        #10;
        display_test("XOR Operation", 32'hFFFFFFFF, 0, 0, 0);

        // Test SLT (Set on Less Than) (ALUControl = 5'b00101)
        A = -32'd10;
        B = 32'd20;
        ALUControl = 5'b00101;
        #10;
        display_test("SLT Operation", 32'd1, 0, 0, 0);

        // Test SLTU (Set on Less Than Unsigned) (ALUControl = 5'b00110)
        A = 32'hFFFFFFFF;
        B = 32'd0;
        ALUControl = 5'b00110;
        #10;
        display_test("SLTU Operation", 32'd0, 1, 0, 0);

       

        // Test LUI (Load Upper Immediate) (ALUControl = 5'b00111)
        A = 32'h0000FFFF;
        B = 32'd0;
        ALUControl = 5'b00111;
        #10;
        display_test("LUI Operation", 32'h0000F000, 0, 0, 0);

        // Test MUL (Multiplication) (ALUControl = 5'b10000)
        A = 32'd1000;
        B = 32'd2000;
        ALUControl = 5'b10000;
        #10;
        display_test("MUL Operation", 32'd2000000, 0, 0, 0);

        // Test MULH (Multiplication High) (ALUControl = 5'b10001)
        A = -32'd1000;
        B = 32'd2000;
        ALUControl = 5'b10001;
        #10;
        display_test("MULH Operation", -1, 0, 0, 0);

        // Test Zero flag when Result is zero (stored in CC register)
        A = 32'd5;
        B = 32'd5;
        ALUControl = 5'b00001; // Subtraction
        #10;
        display_test("Zero Flag Test", 32'd0, 1, 0, 0);

        // Test Overflow in Addition
        A = 32'sh7FFFFFFF;
        B = 32'sh1;
        ALUControl = 5'b00000; // Addition
        #10;
        display_test("Overflow in Addition", -32'sh80000000, 0, 1, 0);

        // Test Underflow in Subtraction
        A = -32'sh80000000;
        B = 32'sh1;
        ALUControl = 5'b00001; // Subtraction
        #10;
        display_test("Underflow in Subtraction", 32'sh7FFFFFFF, 0, 1, 1);

        $display("All tests completed.");
        $finish;
    end

endmodule
