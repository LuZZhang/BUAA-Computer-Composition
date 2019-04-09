`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:54:03 12/18/2017 
// Design Name: 
// Module Name:    IM 
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
module IM(
    input [31:0] PC_next,
    output [31:0] IR
    );
	 wire [31:0] PC;
	 assign PC = PC_next - 12288;
    reg [31:0] im_reg[0:4095];//¥Ê÷∏¡Ó
	 
    initial begin
       $readmemh("code.txt",im_reg);
    end
    assign IR = im_reg[PC[13:2]];
	 
endmodule
