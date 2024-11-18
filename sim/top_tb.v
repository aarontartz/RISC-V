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
    reg [1:0] btn;
    wire led;
    
    top top_inst(
        .clk(clk),
        .btn(btn[0]),
        .led(led)
    );
    
    always #20 clk = ~clk;
    
    initial begin
        clk <= 1;
        btn[0] <= 1;
        @(posedge clk);
        btn[0] <= 0;
    end
    
endmodule
