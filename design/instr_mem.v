`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Aaron Tartz
// 
// Create Date: 09/28/2024 01:46:59 AM
// Module Name: instr_mem
// 
//////////////////////////////////////////////////////////////////////////////////


module instr_mem(
    input wire [31:0] instr_addr,
    output wire [31:0] r_data
    );
    
    reg [31:0] instr_mem [31:0];
    
    // instruction memory read combinationally
    assign r_data = instr_mem[instr_addr[31:0]];  //might have to change instr_addr index later
    
endmodule
