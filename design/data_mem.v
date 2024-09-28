`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Aaron Tartz
// 
// Create Date: 09/28/2024 01:46:59 AM
// Module Name: data_mem
// 
//////////////////////////////////////////////////////////////////////////////////


module data_mem(
    input clk,
    input w_en,
    input [31:0] addr,
    input [31:0] w_data,
    output [31:0] r_data
    );
    
    reg [31:0] data_mem [31:0];
    
    // data memory read combinationally
    assign r_data = data_mem[addr];
    
    always @(posedge clk) begin
        if (w_en)
            data_mem[addr] <= w_data;
    end
    
endmodule
