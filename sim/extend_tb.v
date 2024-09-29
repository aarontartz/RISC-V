`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Aaron Tartz
// 
// Create Date: 09/28/2024 04:52:49 PM
// Module Name: extend_tb
// 
//////////////////////////////////////////////////////////////////////////////////


module extend_tb;
    reg sel;
    reg [31:0] instr;
    wire [31:0] imm_ext;
    
    reg clk = 1;
    
    localparam [31:0] TEST1 = 32'hFFC4A303;  // lw test
    localparam [31:0] TEST2 = 32'h0064A423;  // sw test

    extend extend_inst (
        .instr(instr[31:7]),
        .sel(sel),
        .imm_ext(imm_ext)
    );
    
    always #100 clk = ~clk;
    
    initial begin
        sel <= 0;
        instr <= TEST1;
        @(posedge clk);
        sel <= 1;
        instr <= TEST2;
    end

endmodule
