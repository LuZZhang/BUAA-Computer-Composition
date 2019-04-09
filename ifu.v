`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:41:11 12/05/2017 
// Design Name: 
// Module Name:    ifu 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module ifu(
    input [31:0] PC,
    output [5:0] opcode,
    output [5:0] func,
    output [4:0] ins21_25,
    output [4:0] ins16_20,
    output [4:0] ins11_15,
    output [15:0] imm
    );
	 reg [31:0] im_reg[1023:0];//¥Ê÷∏¡Ó
	 wire [31:0] instr; //÷∏¡Ó
	 
    initial begin
       $readmemh("code.txt",im_reg);
    end
    assign instr = im_reg[PC[11:2]];
	 assign opcode[5:0] = instr[31:26];
	 assign func[5:0] = instr[5:0];
	 assign ins21_25 = instr[25:21];
	 assign ins16_20 = instr[20:16];
	 assign ins11_15 = instr[15:11];
	 assign imm = instr[15:0];

endmodule
