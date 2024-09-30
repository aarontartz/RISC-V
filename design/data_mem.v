`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Aaron Tartz
// 
// Create Date: 09/28/2024 01:46:59 AM
// Module Name: data_mem
// 
//////////////////////////////////////////////////////////////////////////////////


module data_mem(
    input wire clk,
    input wire w_en,
    input wire [31:0] addr,
    input wire [31:0] w_data,
    output wire [31:0] r_data
    );
    
    reg [31:0] data_mem [31:0];
    
    // data memory read combinationally
    assign r_data = data_mem[addr[31:2]];  // we also have to do [31:2] here to match instr_mem module
    
    always @(posedge clk) begin
        if (w_en)
            data_mem[addr[31:2]] <= w_data;
    end
    
endmodule
