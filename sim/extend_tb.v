`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Aaron Tartz
// 
// Create Date: 09/28/2024 04:52:49 PM
// Module Name: extend_tb
// 
//////////////////////////////////////////////////////////////////////////////////


module extend_tb;
    reg [31:0] instr;
    reg [1:0] sel;
    wire [31:0] imm_ext;
    
    reg clk = 1;
    
    localparam [31:0] TEST1 = 32'hFFC4A303;  // lw test
    localparam [31:0] TEST2 = 32'h0064A423;  // sw test
    localparam [31:0] TEST3 = 32'hFE420AE3;  // beq test

    extend extend_inst (
        .instr(instr[31:7]),
        .sel(sel),
        .imm_ext(imm_ext)
    );
    
    always #100 clk = ~clk;
    
    initial begin
        sel <= 2'b00;
        instr <= TEST1;
        @(posedge clk);
        sel <= 2'b01;
        instr <= TEST2;
        @(posedge clk);
        sel <= 2'b10;
        instr <= TEST3;
        @(posedge clk);
        $finish;
    end
endmodule
