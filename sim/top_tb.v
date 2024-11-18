`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/29/2024 08:32:45 PM
// Design Name: 
// Module Name: top_tb
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


module top_tb;
    reg clk;
    reg btn0;
    wire ck_io0;
    
    top top_inst(
        .clk(clk),
        .btn0(btn0),
        .ck_io0(ck_io0)
    );
    
    always #20 clk = ~clk;
    
    initial begin
        clk <= 1;
        btn0 <= 1;
        @(posedge clk);
        btn0 <= 0;
    end
    
endmodule
