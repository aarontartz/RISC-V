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
    input clk,
    input rst
    );
    
    wire [31:0] pc_next;
    wire [31:0] pc;
    wire [31:0] instr;
    
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
    
    
endmodule
