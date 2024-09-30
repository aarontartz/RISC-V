`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Aaron Tartz
// 
// Create Date: 09/29/2024 03:02:22 AM
// Module Name: top_tb
// Description: Executes machine code stored in external instr.txt file
// 
//////////////////////////////////////////////////////////////////////////////////


module top_tb;
    reg clk;
    reg rst;
    
    top top_inst(
        .clk(clk),
        .rst(rst)
    );
    
    always #20 clk = ~clk;
    
    initial begin
        clk <= 1;
        rst <= 1;
        @(posedge clk);
        rst <= 0;
    end
    
endmodule
