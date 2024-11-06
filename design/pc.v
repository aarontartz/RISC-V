`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Aaron Tartz
// 
// Create Date: 09/28/2024 01:46:59 AM
// Module Name: pc
// 
//////////////////////////////////////////////////////////////////////////////////


module pc(
    input wire clk,
    input wire [31:0] pc_next,
    output wire [31:0] pc
    );
    
    reg [31:0] pc_reg;
    
    assign pc = pc_reg;  // pc contains address of instruction to execute
    
    always @(posedge clk) begin
        pc_reg <= pc_next;  // pc_next contains address of next instruction to execute
    end
    
endmodule
