`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Aaron Tartz
// 
// Create Date: 09/29/2024 02:36:14 PM
// Module Name: decoder_alu
// 
//////////////////////////////////////////////////////////////////////////////////


module decoder_alu(
    input wire op,              // op[5] from op[6:0]
    input wire [1:0] alu_op,
    input wire [2:0] funct3,
    input wire funct7,
    output wire [2:0] alu_ctrl
    );
    
    reg [2:0] alu_ctrl_reg;
    assign alu_ctrl = alu_ctrl_reg;
    
    always @(*) begin
        case (alu_op)
            2'b00:
                alu_ctrl_reg = 3'b000;  // lw, sw: addition
            2'b01:
                alu_ctrl_reg = 3'b001;  // beq: subtraction
            2'b10:
                case (funct3)
                    3'b000:
                        case ({op, funct7})
                            2'b00, 2'b01, 2'b10:
                                alu_ctrl_reg = 3'b000;  // add: addition
                            2'b11:
                                alu_ctrl_reg = 3'b001;  // sub: subtraction
                        endcase
                    3'b010:
                        alu_ctrl_reg = 3'b101;  // slt: set less than
                    3'b110:
                        alu_ctrl_reg = 3'b001;  // or: or
                    3'b111:
                        alu_ctrl_reg = 3'b010;  // and: and
                endcase
        endcase
    end
    
endmodule
