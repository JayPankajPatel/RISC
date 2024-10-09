`timescale 1ns / 1ps

module Register_File(
    input wire        clk, WE3,
    input wire        Lte, Lt, Zero, underflow, overflow,
    input wire [3:0]  RA1, RA2, WA3, // 16 register addr
    input wire [31:0] WD3,
    output wire [31:0] RD1, RD2
    );

    reg [31:0]        REG_MEM_BLOCK[15:0]; // 16 registers

    // cc register (x16) stores flags in lower 5 bits
    always @(posedge clk) begin
        if (WE3)
            REG_MEM_BLOCK[WA3] <= WD3;

        // Update condition flags in x16 (REG_MEM_BLOCK[15])
        REG_MEM_BLOCK[15][4:0] <= {overflow, underflow, Zero, Lt, Lte};
    end

    assign RD1 = (RA1 != 0) ? REG_MEM_BLOCK[RA1] : 0;
    assign RD2 = (RA2 != 0) ? REG_MEM_BLOCK[RA2] : 0;

endmodule
