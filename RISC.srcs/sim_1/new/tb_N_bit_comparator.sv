`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/23/2024 11:41:31 PM
// Design Name: 
// Module Name: tb_N_bit_comparator
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


`timescale 1ns / 1ps

module tb_N_bit_comparator;

    
    localparam N = 32; 

    
    logic [N-1:0] tb_A, tb_B;
    logic tb_A_equal_B, tb_A_neq_B, tb_A_less_B, tb_A_lesseq_B, tb_A_greater_B, tb_A_greateq_B, tb_en; 

    
    N_bit_comparator #(.N(N)) MUT (
        .A(tb_A),
        .B(tb_B),
        .en(tb_en), 
        .A_equal_B(tb_A_equal_B),
        .A_neq_B(tb_A_neq_B),
        .A_less_B(tb_A_less_B),
        .A_lesseq_B(tb_A_lesseq_B),
        .A_greater_B(tb_A_greater_B),
        .A_greateq_B(tb_A_greateq_B)
    );

    
    initial begin
        // Test case 1: A == B
        tb_A = 8'd50; 
        tb_B = 8'd50;
        tb_en = 1;
        #10;
        $display("Test 1: A = %0d, B = %0d", tb_A, tb_B);
        assert(tb_A_equal_B) else $fatal("Test 1 Failed: A != B when expected equal");
        assert(tb_A_lesseq_B && tb_A_greateq_B) else $fatal("Test 1 Failed: A <= B and A >= B should be true when A == B");

        // Test case 2: A < B
        tb_A = 8'd10; 
        tb_B = 8'd20;
        #10;
        $display("Test 2: A = %0d, B = %0d", tb_A, tb_B);
        assert(tb_A_less_B && tb_A_lesseq_B) else $fatal("Test 2 Failed: A should be less than B");
        assert(tb_A_greater_B == 0 && tb_A_greateq_B == 0) else $fatal("Test 2 Failed: A should not be greater than or equal to B");

        // Test case 3: A > B
        tb_A = 8'd100; 
        tb_B = 8'd50;
        #10;
        $display("Test 3: A = %0d, B = %0d", tb_A, tb_B);
        assert(tb_A_greater_B && tb_A_greateq_B) else $fatal("Test 3 Failed: A should be greater than B");
        assert(tb_A_less_B == 0 && tb_A_lesseq_B == 0) else $fatal("Test 3 Failed: A should not be less than or equal to B");

        // Test case 4: A == 0, B == 0
        tb_A = 8'd0; 
        tb_B = 8'd0;
        #10;
        $display("Test 4: A = %0d, B = %0d", tb_A, tb_B);
        assert(tb_A_equal_B) else $fatal("Test 4 Failed: A != B when expected equal");
        assert(tb_A_lesseq_B && tb_A_greateq_B) else $fatal("Test 4 Failed: A <= B and A >= B should be true when A == B");

        // Test case 5: A < B (Corner case)
        tb_A = 8'd1; 
        tb_B = 8'd255;
        #10;
        $display("Test 5: A = %0d, B = %0d", tb_A, tb_B);
        assert(tb_A_less_B && tb_A_lesseq_B) else $fatal("Test 5 Failed: A should be less than B");
        assert(tb_A_greater_B == 0 && tb_A_greateq_B == 0) else $fatal("Test 5 Failed: A should not be greater than or equal to B");
        
        tb_en = 0;
        
        #10;
        $display("Test 6: A = %0d, B = %0d", tb_A, tb_B); 
        $display("All tests passed");
        $finish;
    end

endmodule
