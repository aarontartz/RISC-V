`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Aaron Tartz
// 
// Create Date: 09/29/2024 01:16:11 AM
// Module Name: mux
// 
//////////////////////////////////////////////////////////////////////////////////


module mux(
    input wire [31:0] in_a,
    input wire [31:0] in_b,
    input wire sel,         // in_a when sel = 0, in_b when sel = 1
    output wire [31:0] out
    );
    
    assign out = (sel) ? in_b : in_a;
    
endmodule
