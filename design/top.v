`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////: 
// Engineer: Aaron Tartz
// 
// Create Date: 09/29/2024 05:29:49 PM
// Module Name: top
// Description: Connects controller to datapath
// 
//////////////////////////////////////////////////////////////////////////////////


module top(
    input wire clk,
    input wire btn0,
    output wire ck_io0
    );
    
    wire [31:0] instr;
    wire [6:0] op;
    wire [2:0] funct3;
    wire funct7;
    wire is_zero;
    wire reg_write;
    wire [1:0] imm_src;
    wire alu_src;
    wire [2:0] alu_ctrl;
    wire mem_write;
    wire result_src;
    wire pc_src;
    
    assign op = instr[6:0];
    assign funct3 = instr[14:12];
    assign funct7 = instr[30];
    
    controller controller_inst (
        .is_zero(is_zero),
        .op(op),
        .funct3(funct3),
        .funct7(funct7),
        .pc_src(pc_src),
        .result_src(result_src),
        .mem_write(mem_write),
        .alu_ctrl(alu_ctrl),
        .alu_src(alu_src),
        .imm_src(imm_src),
        .reg_write(reg_write)
    );
    
    datapath datapath_inst (
        .clk(clk),
        .rst(btn0),
        .w_en(mem_write),
        .w_en3(reg_write),
        .alu_ctrl(alu_ctrl),
        .imm_src(imm_src),
        .result_src(result_src),
        .alu_src(alu_src),
        .pc_src(pc_src),
        .is_zero(is_zero),
        .instr_out(instr),
        .led_io(ck_io0)
    );
    
endmodule
