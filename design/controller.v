`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Aaron Tartz
// 
// Create Date: 09/29/2024 02:36:14 PM
// Module Name: controller
// Description: Connects the decoders that make up the controller and ultimately
// control the datapath
// 
//////////////////////////////////////////////////////////////////////////////////


module controller(
    input wire is_zero,
    input wire [6:0] op,
    input wire [2:0] funct3,
    input wire funct7,
    output wire pc_src,
    output wire result_src,
    output wire mem_write,
    output wire [2:0] alu_ctrl,
    output wire alu_src,
    output wire [1:0] imm_src,
    output wire reg_write
    );
    
    wire branch;
    wire [1:0] alu_op;
    
    assign pc_src = (is_zero & branch);
    
    decoder_main decoder_main_inst (
        .op(op),
        .reg_write(reg_write),
        .imm_src(imm_src),
        .alu_src(alu_src),
        .mem_write(mem_write),
        .result_src(result_src),
        .branch(branch),
        .alu_op(alu_op)
    );
    
    decoder_alu decoder_alu_inst (
        .op(op[5]),
        .alu_op(alu_op),
        .funct3(funct3),
        .funct7(funct7),
        .alu_ctrl(alu_ctrl)
    );
    
endmodule
