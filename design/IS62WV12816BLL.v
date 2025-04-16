//////////////////////////////////////////////////////////////////////////////////
// Engineer: Aaron Tartz
// 
// Create Date: 09/28/2024 01:46:59 AM
// Module Name: IS62WV12816BLL
// Description: data RAM, can read and write 16 bits of data at a time
// 
//////////////////////////////////////////////////////////////////////////////////


module IS62WV12816BLL(
    input wire CS1,
    input wire CS2,
    input wire OE,
    input wire WE,
    input wire LB,
    input wire UB,
    input wire [16:0] A,
    inout wire [15:0] IO
    );
    
    reg [15:0] data_mem [31:0];  // 128K x 16-bit (2 Mb), but decreasing from [131072:0] just so I can synthesize
    
    wire [15:0] io_in;
    reg [15:0] io_out;
    wire io_read;
    wire io_write;
    
    assign io_in = IO;
    assign io_read = ((~CS1) && (CS2) && (~OE) && (WE));
    assign io_write = ((~CS1) && (CS2) && (OE) && (~WE));
    
    assign IO = (io_read) ? (
               (~LB) ? (
                   (~UB) ? io_out : {8'bZ, io_out[7:0]}
               ) : (
                   (~UB) ? {io_out[15:8], 8'bZ} : 16'bZ
               )
           ) : 16'bZ;
    
    always @(*) begin
        if (io_read)
            io_out = data_mem[A[15:1]];
        else begin
            io_out = 16'bZ;
            if (io_write)
                data_mem[A[15:1]] = io_in;
        end
    end
endmodule

    
    always @(*) begin
        if (io_read)
            io_out = data_mem[A[15:1]];
        else begin
            io_out = 16'bZ;
            if (io_write)
                data_mem[A[15:1]] = io_in;
        end
    end
endmodule
