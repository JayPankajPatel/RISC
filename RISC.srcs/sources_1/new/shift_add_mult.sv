`timescale 1ns / 1ps

module shift_add_mult #(
    parameter N = 32
) (
    input logic clk,
    input logic rst,
    input logic en,
    input logic [N-1:0] A,  // Multiplicand
    input logic [N-1:0] B,  // Multiplier
    output logic [2*N-1:0] Product,
    output logic done
);

    typedef enum {IDLE, ADD, SHIFT} state_t;
    state_t state;
    state_t next_state;


    logic A_one, algo_done;
    
    logic [N-1:0] a; 
    logic [N-1:0] b;
    logic [N-1:0] p;
    
    logic carry_out; 
    
    logic [$clog2(N):0] algo_count;

   
    // control datapaths using these 
    logic decrement_algo_count; 
    logic add_B; 
    logic shift_all;
    logic load_data;
    logic out_p; 
    
    
     
    assign A_one = a[0];
    assign Product = {p, a}; 
    assign algo_done = (algo_count == 0);  // once the algorithm reaches n iterations.
    assign done = algo_done;  
    
    
//    N_bit_adder  #(.N(N)) ADD_TO_P (
//    .A(p),
//    .B(b),
//    .en(add_B), 
//    .cin(0),
//    .cout(carry_out_result),
//    .Sum(adder_for_p), 
//    .overflow()
//);

//N_bit_subtract  #(.N(N)) DECREMENT_ALGO_COUNT (
//    .A(algo_count),
//    .B({{(N-1){1'b0}}, 1'b1}),
//    .en(decrement_algo_count),
//    .Sum(subractor_for_algo_count), 
//    .overflow()
//);
    
    
    
    // update state
    always_ff@(posedge clk , posedge rst) begin
        if(rst) begin
            state <= IDLE;
        end 
        else begin 
            state <= next_state; 
        end
    end
    
    // control data path unit
    always_comb begin
        load_data = 0; 
        add_B = 0; 
        shift_all = 0; 
        decrement_algo_count = 0; 
        next_state = IDLE;
        
        case(state)
            IDLE: begin 
                load_data = 1;
                add_B = 0; 
                shift_all = 0; 
                decrement_algo_count = 0; 
                next_state = ADD;
            end
            
            ADD: begin
                // if the lsb of the register a is 1
                add_B = A_one ? 1 : 0; 
                load_data = 0;
                shift_all = 0; 
                decrement_algo_count = 0; 
                next_state = SHIFT; 
            end
            
            SHIFT: begin
                    load_data = 0;
                    add_B = 0;
                    shift_all = 1;
                    decrement_algo_count = 1;
                    if(algo_done) begin
                        next_state = IDLE; 
                    end
                    else begin
                        next_state = ADD;
                    end
                end
     
        endcase    
    end
    
    always_ff@(posedge clk or posedge rst) begin
        if(load_data) begin
            a <= A;
            b <= B;
            p <= 0; 
            carry_out <= 0; 
            algo_count <= N; 
            out_p <= 0; 
        end
        
        if(add_B) begin 
            {carry_out, p} <= p + b;
        end
        if(shift_all) begin
            {carry_out, p, a} <= {carry_out, p, a} >> 1; 
        end
        
        if(decrement_algo_count) begin 
            algo_count <= algo_count - 1; 
        end
    end
  

endmodule
