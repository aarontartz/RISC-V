`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Aaron Tartz
// 
// Create Date: 09/29/2024 02:36:14 PM
// Module Name: decoder_main
// 
//////////////////////////////////////////////////////////////////////////////////


module decoder_main(
    input wire [6:0] op,
    output wire reg_write,
    output wire [1:0] imm_src,
    output wire alu_src,
    output wire mem_write,
    output wire result_src,
    output wire branch,
    output wire [1:0] alu_op
    );
    
    reg [8:0] out_reg;  // reg_write, imm_src, alu_src, mem_write, result_src, branch, alu_op
    
    assign reg_write = out_reg[8];
    assign imm_src = out_reg[7:6];
    assign alu_src = out_reg[5];
    assign mem_write = out_reg[4];
    assign result_src = out_reg[3];
    assign branch = out_reg[2];
    assign alu_op = out_reg[1:0];
    
    always @(*) begin
        case (op)
            7'b0000011:
                out_reg = 9'b1_00_1_0_1_0_00;  // lw
            7'b0100011:
                out_reg = 9'b0_01_1_1_x_0_00;  // sw
            7'b0110011:
                out_reg = 9'b1_xx_0_0_0_0_10;  // R-type
            7'b1100011:
                out_reg = 9'b0_10_0_0_x_1_01;  // beq
            7'b0010011:
                out_reg = 9'b1_00_1_0_0_0_10;  // addi
            default:
                out_reg = 9'bx_xx_x_x_x_x_xx;
        endcase
    end
    
endmodule
