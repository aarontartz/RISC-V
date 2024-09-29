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
    input wire [1:0] sel,       // lw: sel = 00, sw: sel = 01, beq: sel = 10
    output wire [31:0] imm_ext
    );
    
    reg [31:0] imm_ext_reg;
    assign imm_ext = imm_ext_reg;
    
    always @(*) begin
        case (sel)
            2'b00:  // imm_ext = sign-extended immediate
                imm_ext_reg = {{20{instr[24]}}, instr[24:13]};  // I-type (e.g. lw)
            2'b01:  // imm_ext = sign-extended immediate
                imm_ext_reg = {{20{instr[24]}}, instr[24:18], instr[4:0]};  // S-type (e.g. sw)
            2'b10:  // imm_ext = branch offset
                imm_ext_reg = {{20{instr[24]}}, instr[0], instr[23:18], instr[4:1], 1'b0};  // B-type (e.g. beq)
            default:
                imm_ext_reg = 32'bxxxx_xxxx_xxxx_xxxx;
        endcase
    end
    
endmodule
