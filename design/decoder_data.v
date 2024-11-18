`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Aaron Tartz
// 
// Create Date: 11/03/2024 11:28:49 PM
// Module Name: decoder_data

// Revision 0.01 - File Created
// 
//////////////////////////////////////////////////////////////////////////////////


module decoder_data(
    input wire [31:0] addr_in,
    output wire [1:0] mem_sel,  // chip enables/selects are all active LOW
    output wire led_io
    );
    
    localparam LED_ADDR = 32'h0000_4000;
    localparam BTN_ADDR = 32'h0000_4004;
    
    assign mem_sel[0] = (addr_in[17] == 1'b0) ? 0 : 1;
    assign mem_sel[1] = (addr_in[17] == 1'b1) ? 0 : 1;
    assign led_io = (addr_in == LED_ADDR) ? 1 : 0;
    
endmodule
