`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Aaron Tartz
// 
// Create Date: 09/28/2024 04:52:49 PM
// Module Name: extend_tb
//////////////////////////////////////////////////////////////////////////////////


module extend_tb;
    reg [11:0] instr;
    wire [31:0] imm_ext;

    extend extend_inst (
        .instr(instr),
        .imm_ext(imm_ext)
    );
    
    initial begin
        instr <= 12'hFFC;
    end

endmodule
