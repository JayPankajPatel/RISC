`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/08/2024 07:22:57 PM
// Design Name: 
// Module Name: full_adder_tb
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
module full_adder_tb;

    logic test_a, test_b, test_cin; 
    logic test_sum, test_cout; 
    
    one_bit_adder dut(
        .a(test_a),
        .b(test_b),
        .cin(test_cin),
        .sum(test_sum),
        .cout(test_cout)
    );

   
    initial begin
        // Display headers for the results
        $display("A B Cin | Sum Cout");
        $display("-----------------");

        // Test case 0: a = 0, b = 0, cin = 0
        test_a = 0;
        test_b = 0;
        test_cin = 0;
        #10;
        $display("%b %b  %b   |  %b   %b", test_a, test_b, test_cin, test_sum, test_cout);
        assert(test_sum == 0 && test_cout == 0) else $fatal("Test case 0 failed!");

        // Test case 1: a = 0, b = 0, cin = 1
        test_a = 0;
        test_b = 0;
        test_cin = 1;
        #10;
        $display("%b %b  %b   |  %b   %b", test_a, test_b, test_cin, test_sum, test_cout);
        assert(test_sum == 1 && test_cout == 0) else $fatal("Test case 1 failed!");

        // Test case 2: a = 0, b = 1, cin = 0
        test_a = 0;
        test_b = 1;
        test_cin = 0;
        #10;
        $display("%b %b  %b   |  %b   %b", test_a, test_b, test_cin, test_sum, test_cout);
        assert(test_sum == 1 && test_cout == 0) else $fatal("Test case 2 failed!");

        // Test case 3: a = 0, b = 1, cin = 1
        test_a = 0;
        test_b = 1;
        test_cin = 1;
        #10;
        $display("%b %b  %b   |  %b   %b", test_a, test_b, test_cin, test_sum, test_cout);
        assert(test_sum == 0 && test_cout == 1) else $fatal("Test case 3 failed!");

        // Test case 4: a = 1, b = 0, cin = 0
        test_a = 1;
        test_b = 0;
        test_cin = 0;
        #10;
        $display("%b %b  %b   |  %b   %b", test_a, test_b, test_cin, test_sum, test_cout);
        assert(test_sum == 1 && test_cout == 0) else $fatal("Test case 4 failed!");

        // Test case 5: a = 1, b = 0, cin = 1
        test_a = 1;
        test_b = 0;
        test_cin = 1;
        #10;
        $display("%b %b  %b   |  %b   %b", test_a, test_b, test_cin, test_sum, test_cout);
        assert(test_sum == 0 && test_cout == 1) else $fatal("Test case 5 failed!");

        // Test case 6: a = 1, b = 1, cin = 0
        test_a = 1;
        test_b = 1;
        test_cin = 0;
        #10;
        $display("%b %b  %b   |  %b   %b", test_a, test_b, test_cin, test_sum, test_cout);
        assert(test_sum == 0 && test_cout == 1) else $fatal("Test case 6 failed!");

        // Test case 7: a = 1, b = 1, cin = 1
        test_a = 1;
        test_b = 1;
        test_cin = 1;
        #10;
        $display("%b %b  %b   |  %b   %b", test_a, test_b, test_cin, test_sum, test_cout);
        assert(test_sum == 1 && test_cout == 1) else $fatal("Test case 7 failed!");

        // End simulation
        $finish;
    end
endmodule
