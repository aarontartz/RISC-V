`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Aaron Tartz
// 
// Create Date: 09/28/2024 04:45:51 PM
// Module Name: extend
// Description: Sign extends input
// 
//////////////////////////////////////////////////////////////////////////////////


module extend(
    input wire [24:0] instr,
    input wire sel,             // sw: sel = 1, lw: sel = 0
    output wire [31:0] imm_ext
    );
    
    assign imm_ext = (sel) ? {{20{instr[24]}}, instr[24:18], instr[4:0]} : {{20{instr[24]}}, instr[24:13]};
    
endmodule
