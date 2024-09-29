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
    
    // control unit inputs
    input wire w_en,            // to data mem
    input wire w_en3,           // to reg file
    input wire [2:0] alu_ctrl,  // to (reg file) alu
    input wire imm_src          // to extend
    );
    
    wire [31:0] pc;
    wire [31:0] instr;
    wire [31:0] src_a;
    wire [31:0] src_b;
    wire [31:0] alu_result;
    wire [31:0] read_data;
    wire [31:0] write_data;
    wire [31:0] pc_plus_4;
    
    pc pc_inst (
        .clk(clk),
        .rst(rst),
        .pc_next(pc_plus_4),
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
        .w_data3(read_data),
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
        .imm_ext(src_b)
    );
    
    alu alu_reg_file (
        .op_a(src_a),
        .op_b(src_b),
        .sel(alu_ctrl),
        .result(alu_result)
    );
    
    alu alu_plus_4 (
        .op_a(pc),
        .op_b(3'b100),      // 4
        .sel(3'b000),       // addition
        .result(pc_plus_4)  // to program counter (pc)
    );
    
endmodule
