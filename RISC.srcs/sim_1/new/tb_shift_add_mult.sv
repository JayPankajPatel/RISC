`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/22/2024 11:05:24 AM
// Design Name: 
// Module Name: tb_shift_add_mult
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

module tb_shift_add_mult();
    parameter N = 32; 
    parameter NUM_TESTS = 100; 
    reg tb_clk, tb_rst, tb_en; 
    reg [N-1:0] tb_A; 
    reg [N-1:0] tb_B; 
    
    wire [(2*N)-1:0] tb_Product;
    wire done; 
    
    reg [(2*N)-1:0] expected_Product; 
    
    shift_add_mult #(
        .N(N)
    ) MUT(
        .clk(tb_clk),
        .rst(tb_rst),
        .en(tb_en),
        .A(tb_A),  
        .B(tb_B),  
        .Product(tb_Product),
        .done(done)
    );

    // Clock generation
    always begin
    #5 tb_clk = ~tb_clk;
    end 
    
    initial begin 
        tb_clk = 0; tb_en = 0; tb_rst = 0; tb_A = 0; tb_B = 0;
       
        tb_rst = 1; 
        #10; 
        tb_rst = 0;
        #10; 
         
        tb_en = 1;
        #10; 
        
        
        for (int i = 0; i < NUM_TESTS; i = i + 1) begin 
            tb_A = $urandom_range(0, N); 
            tb_B = $urandom_range(0, N); 
            
            expected_Product = tb_A * tb_B;
            wait(MUT.done);
            $display("This is the a reg: %0d", MUT.a);
            $display("Test %0d: tb_A = %0d, tb_B = %0d, tb_Product = %0d, Expected Product = %0d", i, tb_A, tb_B, tb_Product, expected_Product); 
            assert (tb_Product == expected_Product) else $error(
                "Assertion Failed at Test %0d: tb_A = %0d, tb_B = %0d, tb_Product = %0d, Expected Product = %0d", i, tb_A, tb_B, tb_Product, expected_Product
            );
        end
        
        tb_A = 1;
        tb_B = $urandom % (1 << N); 
        expected_Product = tb_A * tb_B;
        
        wait(MUT.done);
        $display("Test Final: tb_A = %0d, tb_B = %0d, tb_Product = %0d, Expected Product = %0d", tb_A, tb_B, tb_Product, expected_Product); 
        assert (tb_Product == expected_Product) else $error(
            "Assertion Failed at Final Test: tb_A = %0d, tb_B = %0d, tb_Product = %0d, Expected Product = %0d", tb_A, tb_B, tb_Product, expected_Product
        );
        
        tb_A = 0;
        tb_B = $urandom % (1 << N); 
        expected_Product = tb_A * tb_B;
        
        wait(MUT.done);
        $display("Test Final Zero: tb_A = %0d, tb_B = %0d, tb_Product = %0d, Expected Product = %0d", tb_A, tb_B, tb_Product, expected_Product); 
        assert (tb_Product == expected_Product) else $error(
            "Assertion Failed at Final Zero Test: tb_A = %0d, tb_B = %0d, tb_Product = %0d, Expected Product = %0d", tb_A, tb_B, tb_Product, expected_Product
        );
    end
endmodule
