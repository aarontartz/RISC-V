`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2024 03:07:03 AM
// Design Name: 
// Module Name: IS62WV12816BLL_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module IS62WV12816BLL_tb;
    reg CS1;
    reg CS2;
    reg OE;
    reg WE;
    reg LB;
    reg UB;
    reg [16:0] A;
    wire [31:0] IO;
    
    IS62WV12816BLL IS62WV12816BLL_upper_inst(
        .CS1(CS1),
        .CS2(CS2),
        .OE(OE),
        .WE(WE),
        .LB(LB),
        .UB(UB),
        .A(A),
        .IO(IO[31:16])
    );
    
    IS62WV12816BLL IS62WV12816BLL_lower_inst(
        .CS1(CS1),
        .CS2(CS2),
        .OE(OE),
        .WE(WE),
        .LB(LB),
        .UB(UB),
        .A(A),
        .IO(IO[15:0])
    );

    
    reg clk;
    reg [31:0] write_data;
    wire [31:0] read_data;
    
    always #20 clk = ~clk;
    
    assign IO = (~WE) ? write_data : 32'bz;    // SRAM inout
    assign read_data = IO;
    
    initial begin
        clk <= 1;
        write_data <= 32'h0;
        CS1 <= 1;   // disable
        CS2 <= 0;   // disable
        A <= 17'h0;
        LB <= 0;
        UB <= 0;
        OE <= 1;    // begin with set to write
        WE <= 0;    // ^
    end
    
    initial begin
        @(posedge clk);
        @(posedge clk);
        CS1 <= 0;
        CS2 <= 1;
        A <= 17'h2;
        write_data <= 32'h12345678;
        @(posedge clk);
        A <= 17'h4;
        OE <= 0;    // set to read
        WE <= 1;    // ^
        @(posedge clk);
    end

endmodule
