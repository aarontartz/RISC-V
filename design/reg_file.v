`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Aaron Tartz
// 
// Create Date: 09/28/2024 01:46:59 AM
// Module Name: reg_file
// 
//////////////////////////////////////////////////////////////////////////////////


module reg_file(
    input wire clk,
    input wire w_en3,
    input wire [4:0] addr1,
    input wire [4:0] addr2,
    input wire [4:0] addr3,
    input wire [31:0] w_data3,
    output wire [31:0] r_data1,
    output wire [31:0] r_data2
    );
    
    reg [31:0] reg_file [31:0];  // 32 element (registers) x 32 bits (for each register)
    
    // register file read combinationally
    assign r_data1 = (addr1 == 0) ? 0 : reg_file[addr1];  // registe x0 is hardwired to always 0
    assign r_data2 = (addr1 == 0) ? 0 : reg_file[addr2];
    
    always @(posedge clk) begin
        if (w_en3)
            reg_file[addr3] <= w_data3;  // addr3 input represents register #
    end
    
endmodule
