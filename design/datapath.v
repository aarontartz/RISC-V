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
    output wire led_io
    );
    
    wire [1:0] instr_mem_sel;
    wire [1:0] data_mem_sel;
    wire [31:0] pc;
    wire [31:0] pc_next;
    wire [31:0] instr;
    wire [31:0] src_a;
    wire [31:0] src_b;
    wire [31:0] alu_result;
    wire [31:0] data;
    wire [31:0] read_data;
    wire [31:0] write_data;
    wire [31:0] pc_plus_2;
    wire [31:0] result;         // alu_result (R-type) or read_data (lw)
    wire [31:0] imm_ext;
    wire [31:0] pc_target;
    
    assign instr_out = instr;   // for control unit input
    assign data = w_en ? write_data : 32'bz;    // SRAM inout
    assign read_data = data;
    
    pc pc_inst (
        .clk(clk),
        .rst(rst),
        .pc_next(pc_next),
        .pc(pc)
    );
    
    decoder_instr decoder_instr_inst (
        .addr_in(pc),
        .mem_sel(instr_mem_sel)
    );
    
    S29AL008J_upper instr_upper_inst1 (
        .CE(instr_mem_sel[0]),
        .OE(1'b0),          // Read Only Memory
        .WE(1'b1),
        .RESET(1'b1),
        .BYTE(1'b1),        // always set to 16-bit mode
        .A(pc[18:0]),
        .DQ(instr[31:16])  // upper 16 bits
    );
    
    S29AL008J_lower instr_lower_inst1 (
        .CE(instr_mem_sel[0]),
        .OE(1'b0),
        .WE(1'b1),
        .RESET(1'b1),
        .BYTE(1'b1),
        .A(pc[18:0]),
        .DQ(instr[15:0])  // lower 16 bits
    );
    
    S29AL008J_upper instr_upper_inst2 (
        .CE(instr_mem_sel[1]),
        .OE(1'b0),          // Read Only Memory
        .WE(1'b1),
        .RESET(1'b1),
        .BYTE(1'b1),        // always set to 16-bit mode
        .A(pc[18:0]),
        .DQ(instr[31:16])  // upper 16 bits
    );
    
    S29AL008J_lower instr_lower_inst2 (
        .CE(instr_mem_sel[1]),
        .OE(1'b0),
        .WE(1'b1),
        .RESET(1'b1),
        .BYTE(1'b1),
        .A(pc[18:0]),
        .DQ(instr[15:0])  // lower 16 bits
    );
    
    reg_file reg_file_inst (
        .clk(clk),
        .w_en3(w_en3),
        .addr1(instr[19:15]),
        .addr2(instr[24:20]),
        .addr3(instr[11:7]),
        .w_data3(result),
        .r_data1(src_a),
        .r_data2(write_data)
    );
    
    decoder_data decoder_data_inst (
        .addr_in(alu_result),
        .mem_sel(data_mem_sel),
        .led_io(led_io)
    );
    
    IS62WV12816BLL data_upper_inst1 (
        .CS1(data_mem_sel[0]),
        .CS2(1'b1),
        .OE(~w_en),
        .WE(w_en),
        .LB(1'b0),       // always set to 16-bit mode
        .UB(1'b0),
        .A(alu_result[16:0]),
        .IO(data[31:16]) // upper 16 bits
    );
    
    IS62WV12816BLL data_lower_inst1 (
        .CS1(data_mem_sel[0]),
        .CS2(1'b1),
        .OE(~w_en),
        .WE(w_en),
        .LB(1'b0),
        .UB(1'b0),
        .A(alu_result[16:0]),
        .IO(data[15:0])  // lower 16 bits
    );
    
    IS62WV12816BLL data_upper_inst2 (
        .CS1(data_mem_sel[1]),
        .CS2(1'b1),
        .OE(~w_en),
        .WE(w_en),
        .LB(1'b0),       // always set to 16-bit mode
        .UB(1'b0),
        .A(alu_result[16:0]),
        .IO(data[31:16]) // upper 16 bits
    );
    
    IS62WV12816BLL data_lower_inst2 (
        .CS1(data_mem_sel[1]),
        .CS2(1'b1),
        .OE(~w_en),
        .WE(w_en),
        .LB(1'b0),
        .UB(1'b0),
        .A(alu_result[16:0]),
        .IO(data[15:0])  // lower 16 bits
    );
    
    extend extend_inst (
        .instr(instr[31:7]),
        .sel(imm_src),
        .imm_ext(imm_ext)
    );
    
    alu alu_reg_file (          // sources from reg file
        .op_a(src_a),
        .op_b(src_b),
        .sel(alu_ctrl),
        .is_zero(is_zero),
        .result(alu_result)
    );
    
    alu alu_plus_2 (            // next instruction (instructions are 32 bits / 4 bytes)
        .op_a(pc),
        .op_b(32'h00000002),
        .sel(3'b000),           // addition
        .is_zero(),
        .result(pc_plus_2)      // to program counter (pc)
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
        .in_a(pc_plus_2),        // goes to next instruction
        .in_b(pc_target),        // branches to different instruction
        .sel(pc_src),
        .out(pc_next)
    );
    
endmodule
