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
    reg rst;
    //reg [31:0] instr;
    wire [31:0] pc_out;
    
    top top_inst(
        .clk(clk),
        .rst(rst),
        //.instr(instr),
        .pc_out(pc_out)
    );
    
    always #20 clk = ~clk;
    
    initial begin
        clk <= 1;
        rst <= 1;
        @(posedge clk);
        rst <= 0;
    end
    
endmodule
