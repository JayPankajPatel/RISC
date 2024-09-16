module shiftreg #(parameter N = 32)(
    input logic clk, 
    input logic rst, 
    input logic sin, 
    input logic load, 
    input logic [N-1:0] d, 
    input logic shift_right,  
    output logic [N-1:0] q, 
    output logic sout 
);
    
    always_ff@(posedge clk, posedge rst) begin 
        if(rst) begin
            q <= '0;  
        end
        else if(load) begin
            q <= d;  
        end
        else if(shift_right) begin
            q <= {sin, q[N-1:1]}; 
        end
        else begin 
            q <= {q[N-2:0], sin}; 
        end
    end
    
    assign sout = shift_right ? q[0] : q[N-1]; 
endmodule
