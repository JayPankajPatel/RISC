module tb_alu;

    // Testbench parameters and signals
    parameter N = 32;
    logic signed [N-1:0] tb_A, tb_B;
    logic [3:0] tb_FN;
    logic signed [N-1:0] tb_Y, expected_Y;
    logic tb_overflow, tb_underflow, tb_zero;
    logic expected_overflow, expected_underflow, expected_zero;
    logic clk; 
    
    always begin 
       #5 clk = ~clk;  
    end

    // Instantiate the ALU module
    alu #(.N(N)) uut (
        .A(tb_A),
        .B(tb_B),
        .FN(tb_FN),
        .Y(tb_Y),
        .overflow(tb_overflow),
        .underflow(tb_underflow),
        .zero(tb_zero)
    );

    initial begin
        // Test case 1: Add, no overflow
        tb_A = 500;
        tb_B = 125;
        tb_FN = 0;  // Add
        expected_Y = tb_A + tb_B;
        expected_overflow = 0;
        expected_underflow = 0;
        expected_zero = 0;
        #10;
        assert(tb_Y === expected_Y) else $fatal("Error in FN 0 (Add), Expected %0d, Got %0d", expected_Y, tb_Y);
        assert(tb_overflow === expected_overflow) else $fatal("Overflow mismatch in Add");
        assert(tb_underflow === expected_underflow) else $fatal("Underflow mismatch in Add");
        assert(tb_zero === expected_zero) else $fatal("Zero flag mismatch in Add");

        // Test case 2: Add, overflow
        tb_A = 32'h7FFFFFFF;  // Largest positive 32-bit signed value
        tb_B = 1;
        tb_FN = 0;  // Add
        expected_Y = tb_A + tb_B;
        expected_overflow = 1;
        expected_underflow = 0;
        expected_zero = 0;
        #10;
        assert(tb_overflow === expected_overflow) else $fatal("Overflow mismatch in Add overflow case");
        assert(tb_underflow === expected_underflow) else $fatal("Underflow mismatch in Add overflow case");

        // Test case 3: Subtract, no underflow
        tb_A = 500;
        tb_B = 125;
        tb_FN = 1;  // Subtract
        expected_Y = tb_A - tb_B;
        expected_overflow = 0;
        expected_underflow = 0;
        expected_zero = 0;
        #10;
        assert(tb_Y === expected_Y) else $fatal("Error in FN 1 (Subtract), Expected %0d, Got %0d", expected_Y, tb_Y);
        assert(tb_overflow === expected_overflow) else $fatal("Overflow mismatch in Subtract");
        assert(tb_underflow === expected_underflow) else $fatal("Underflow mismatch in Subtract");
        assert(tb_zero === expected_zero) else $fatal("Zero flag mismatch in Subtract");

            // Test case 4: Subtract, underflow
        tb_A = 32'h80000000;  // Smallest negative 32-bit signed value (-2147483648)
        tb_B = 1;
        tb_FN = 1;  // Subtract
        expected_Y = tb_A - tb_B;  // Expected result will wrap around
        expected_overflow = 0;
        expected_underflow = 1;  // This case should cause an underflow
        expected_zero = 0;
        #10;
        assert(tb_underflow === expected_underflow) else $fatal("Underflow mismatch in Subtract underflow case");
        

        // Test case 5: AND operation
        tb_A = 32'hFF00FF00;
        tb_B = 32'h00FF00FF;
        tb_FN = 3;  // AND
        expected_Y = tb_A & tb_B;
        expected_overflow = 0;
        expected_underflow = 0;
        expected_zero = 0;
        #10;
        assert(tb_Y === expected_Y) else $fatal("Error in FN 3 (AND), Expected %0d, Got %0d", expected_Y, tb_Y);

        // Test case 6: OR operation
        tb_A = 32'hFF00FF00;
        tb_B = 32'h00FF00FF;
        tb_FN = 4;  // OR
        expected_Y = tb_A | tb_B;
        #10;
        assert(tb_Y === expected_Y) else $fatal("Error in FN 4 (OR), Expected %0d, Got %0d", expected_Y, tb_Y);

        // Test case 7: XOR operation
        tb_A = 32'hFF00FF00;
        tb_B = 32'h00FF00FF;
        tb_FN = 5;  // XOR
        expected_Y = tb_A ^ tb_B;
        #10;
        assert(tb_Y === expected_Y) else $fatal("Error in FN 5 (XOR), Expected %0d, Got %0d", expected_Y, tb_Y);

        // Test case 8: Zero flag (A == B)
        tb_A = 32'h12345678;
        tb_B = 32'h12345678;
        tb_FN = 8;  // Equal comparison
        expected_Y = 1;
        expected_zero = 1;
        #10;
        assert(tb_Y === expected_Y) else $fatal("Error in FN 8 (Equality), Expected %0d, Got %0d", expected_Y, tb_Y);
        assert(tb_zero === expected_zero) else $fatal("Zero flag mismatch in Equality");

        // Test case 9: Less than comparison (A < B)
        tb_A = 100;
        tb_B = 200;
        tb_FN = 10;  // A < B
        expected_Y = 1;
        expected_zero = 0;
        #10;
        assert(tb_Y === expected_Y) else $fatal("Error in FN 10 (Less Than), Expected %0d, Got %0d", expected_Y, tb_Y);

        // Test case 10: Greater than comparison (A > B)
        tb_A = 300;
        tb_B = 200;
        tb_FN = 12;  // A > B
        expected_Y = 1;
        expected_zero = 0;
        #10;
        assert(tb_Y === expected_Y) else $fatal("Error in FN 12 (Greater Than), Expected %0d, Got %0d", expected_Y, tb_Y);

        // Test case 11: Multiplication (Basic)
        tb_A = 32'h00000002;
        tb_B = 32'h00000003;
        tb_FN = 2;  // Multiplication
        expected_Y = tb_A * tb_B;
        expected_overflow = 0;
        expected_underflow = 0;
        expected_zero = 0;
        #10;
        assert(tb_Y === expected_Y) else $fatal("Error in FN 2 (Multiplication), Expected %0d, Got %0d", expected_Y, tb_Y);

        // Test case 12: NOT A operation
        tb_A = 32'hFFFFFF00;
        tb_FN = 6;  // NOT A
        expected_Y = ~tb_A;
        #10;
        assert(tb_Y === expected_Y) else $fatal("Error in FN 6 (NOT A), Expected %0d, Got %0d", expected_Y, tb_Y);

        // Test case 13: NOT B operation
        tb_B = 32'hFFFFFF00;
        tb_FN = 7;  // NOT B
        expected_Y = ~tb_B;
        #10;
        assert(tb_Y === expected_Y) else $fatal("Error in FN 7 (NOT B), Expected %0d, Got %0d", expected_Y, tb_Y);

        // Test case 14: Less than or equal comparison (A <= B)
        tb_A = 100;
        tb_B = 100;
        tb_FN = 11;  // A <= B
        expected_Y = 1;
        expected_zero = 1;
        #10;
        assert(tb_Y === expected_Y) else $fatal("Error in FN 11 (Less Than or Equal), Expected %0d, Got %0d", expected_Y, tb_Y);

        // Test case 15: Greater than or equal comparison (A >= B)
        tb_A = 200;
        tb_B = 100;
        tb_FN = 13;  // A >= B
        expected_Y = 1;
        expected_zero = 0;
        #10;
        assert(tb_Y === expected_Y) else $fatal("Error in FN 13 (Greater Than or Equal), Expected %0d, Got %0d", expected_Y, tb_Y);

        $display("All tests passed.");
        $finish;
    end

endmodule
