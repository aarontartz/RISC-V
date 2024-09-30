`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Aaron Tartz
// 
// Create Date: 09/28/2024 04:02:51 PM
// Module Name: datapath
// Description: Connects all the structures that make up the datapath
// 
//////////////////////////////////////////////////////////////////////////////////


module datapath(
    input wire clk,
    input wire rst,
    
    // control unit inputs & outputs
    input wire w_en,                // to data mem
    input wire w_en3,               // to reg file
    input wire [2:0] alu_ctrl,      // to (reg file) alu
    input wire [1:0] imm_src,       // to extend
    input wire result_src,          // to mux (output to reg file)
    input wire alu_src,             // to mux (output to alu)
    input wire pc_src,              // to mux (output to pc)
    output wire is_zero,            // from alu (inputs from reg file)
    output wire [31:0] instr_out,    // from instr_mem_inst
    
    // TESTING
    output wire [31:0] pc_out
    );
    
    wire [31:0] pc;
    wire [31:0] pc_next;
    wire [31:0] instr;
    wire [31:0] src_a;
    wire [31:0] src_b;
    wire [31:0] alu_result;
    wire [31:0] read_data;
    wire [31:0] write_data;
    wire [31:0] pc_plus_4;
    wire [31:0] result;         // alu_result (R-type) or read_data (lw)
    wire [31:0] imm_ext;
    wire [31:0] pc_target;
    
    assign instr_out = instr;   // for control unit input
    
    assign pc_out = pc;  // TESTING
    
    pc pc_inst (
        .clk(clk),
        .rst(rst),
        .pc_next(pc_next),
        .pc(pc)
    );
    
    instr_mem instr_mem_inst (
        .instr_addr(pc),
        .r_data(instr)
    );
    
    reg_file reg_file_inst (
        .clk(clk),
        .w_en3(w_en3),
        .addr1(instr[19:15]),
        .addr2(write_data),
        .addr3(instr[11:7]),
        .w_data3(result),
        .r_data1(src_a),
        .r_data2(write_data)
    );
    
    data_mem data_mem_inst (
        .clk(clk),
        .w_en(w_en),
        .addr(alu_result),
        .w_data(write_data),    // read from reg (file), written to (data) mem
        .r_data(read_data)      // read from (data) mem, written to reg (file)
    );
    
    extend extend_inst (
        .instr(instr[31:7]),
        .imm_ext(imm_ext)
    );
    
    alu alu_reg_file (          // sources from reg file
        .op_a(src_a),
        .op_b(src_b),
        .sel(alu_ctrl),
        .is_zero(is_zero),
        .result(alu_result)
    );
    
    alu alu_plus_4 (            // next instruction (instructions are 32 bits / 4 bytes)
        .op_a(pc),
        .op_b(3'h4),            // 4
        .sel(3'b000),           // addition
        .is_zero(),
        .result(pc_plus_4)      // to program counter (pc)
    );
    
    alu alu_pc_target (         // computes branch target address
        .op_a(pc),
        .op_b(imm_ext),
        .sel(3'b000),           // addition
        .is_zero(),
        .result(pc_target)
    );
    
    mux mux_reg_file (          // outputs to reg file
        .in_a(alu_result),
        .in_b(read_data),
        .sel(result_src),
        .out(result)
    );
    
    mux mux_alu (               // outputs to alu
        .in_a(write_data),       // just shares same wire as write_data to data_mem_inst
        .in_b(imm_ext),
        .sel(alu_src),
        .out(src_b)
    );
    
    mux mux_pc (                // outputs to pc
        .in_a(pc_plus_4),        // goes to next instruction
        .in_b(pc_target),        // branches to different instruction
        .sel(pc_src),
        .out(pc_next)
    );
    
endmodule
