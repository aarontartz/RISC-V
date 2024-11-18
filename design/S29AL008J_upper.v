`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Aaron Tartz
// 
// Create Date: 09/28/2024 01:46:59 AM
// Module Name: S29AL008J_upper
// Description: instruction ROM, contains upper 16 bits of each instruction
// 
//////////////////////////////////////////////////////////////////////////////////


module S29AL008J_upper(
    input wire CE,
    input wire OE,
    input wire WE,
    input wire RESET,
    input wire BYTE,
    input wire [18:0] A,
    inout wire [15:0] DQ
    );
    
    reg [15:0] instr_mem [31:0];  // 512K x 16-bit (8 Mb), but decreasing from [524288:0] just so I can synthesize
    
    // TESTING
    initial
        $readmemh("C:/Users/Aaron/Desktop/instr_upper.txt", instr_mem);
    
    wire [15:0] dq_in;
    reg [15:0] dq_out;
    wire dq_read;
    
    assign dq_in = DQ;
    assign dq_read = ((~CE) && (~OE) && (WE) && (RESET));
    assign DQ = (dq_read) ? ((BYTE) ? dq_out : {8'bZ, dq_out[7:0]}) : 16'bZ;
    
    always @(*) begin
        if (dq_read)
            dq_out = instr_mem[A[18:1]];
        else
            dq_out = 16'bZ;
    end
    
endmodule
