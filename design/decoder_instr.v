`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Aaron Tartz
// 
// Create Date: 11/03/2024 11:28:49 PM
// Module Name: decoder_instr

// Revision 0.01 - File Created
// 
//////////////////////////////////////////////////////////////////////////////////


module decoder_instr(
    input wire [31:0] addr_in,
    output wire [1:0] mem_sel  // chip enables/selects are all active LOW
    );
    
    assign mem_sel[0] = (addr_in[19] == 1'b0) ? 0 : 1;
    assign mem_sel[1] = (addr_in[19] == 1'b1) ? 0 : 1;
    
endmodule
