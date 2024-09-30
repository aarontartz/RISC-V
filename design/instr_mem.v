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
    
    // TESTING
    initial
        $readmemh("C:/Users/Aaron/Desktop/instr.txt", instr_mem);
    
    // instruction memory read combinationally
    assign r_data = instr_mem[instr_addr[31:2]];
    
    // we have to do [31:2] because address is incremented by 4 each time (0000_0000, 0000_0004, ...) with [31:2],
    // we take out the last 2 bits: 0000_0012 = 0000_0000_ . . . _1100 becomes 0000_0001 = 0000_0000_ . . . _0011
    
endmodule
