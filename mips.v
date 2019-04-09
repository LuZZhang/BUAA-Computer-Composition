`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:24:09 12/02/2017 
// Design Name: 
// Module Name:    mips 
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
`include "ifu.v"
`include "control.v"
`include "grf.v"
`include "ext.v"
`include "alu.v"
`include "dm.v"
`include "mux_WData.v"
`include "PC.v"

module mips(
    input clk,
    input reset
    );
	 wire [5:0] opcode,func;
	 wire [4:0] ins21_25,ins16_20,ins11_15;
	 wire [15:0] imm;
	 wire [1:0] RegDst,MemtoReg,j_src,j_zero,word_bit,ExtOp;
	 wire ALUSrc,RegWrite,MemWrite,nPC_sel,zero,load_u;
	 wire [2:0] ALUctr;
	 wire [31:0] PC,WData,Ext_num,SrcA,SrcB, ALUResult,WriteData,ReadData;
	 //initial begin
	  //assign PC = 32'h0000_3000;
	 //end
    //always @(posedge clk,posedge reset) begin
	   ifu ifu1 (.PC(PC),.opcode(opcode),.func(func),.ins21_25(ins21_25),
		   .ins16_20(ins16_20),.ins11_15(ins11_15),.imm(imm));
		control control1 (.opcode(opcode),.func(func),.RegDst(RegDst),.ALUSrc(ALUSrc),.MemtoReg(MemtoReg), 
         .RegWrite(RegWrite),.MemWrite(MemWrite),.nPC_sel(nPC_sel),.ExtOp(ExtOp),.word_bit(word_bit), 
         .load_u(load_u),.j_src(j_src),.j_zero(j_zero),.ALUctr(ALUctr));
		grf grf1 (.clk(clk),.RegDst(RegDst),.A1(ins21_25),.A2(ins16_20),.ins15_11(ins11_15),
		   .WData(WData),.RegWrite(RegWrite),.reset(reset),.WPC(PC), .RD1(SrcA),.RD2(WriteData));
		ext ext1 (.ExtOp(ExtOp),.imm(imm),.in_16_20(ins16_20), 
         .in_21_25(ins21_25), .Ext_num(Ext_num)); 
	   alu alu1 (.ALUctr(ALUctr),.SrcA(SrcA),.SrcB(SrcB),.j_zero(j_zero),.zero(zero),.ALUResult(ALUResult));
		dm dm1 (.MemWrite(MemWrite),.ALUResult(ALUResult),.WriteData(WriteData),.reset(reset), 
         .word_bit(word_bit),.load_u(load_u),.clk(clk),.pc(PC),.ReadData(ReadData));
      mux_WData mux1 (.ALUResult(ALUResult),.ReadData(ReadData),.PC(PC), .MemtoReg(MemtoReg),
         .RD2(WriteData),.Ext_num(Ext_num),.ALUSrc(ALUSrc), .SrcB(SrcB),.WData(WData));
		PC PC1 (.reset(reset),.clk(clk),.pc(PC),.nPC_sel(nPC_sel),.zero(zero),.j_src(j_src),
		   .ext_num(Ext_num),.RD_1(SrcA),.pc_next(PC));
	 //end//end always

endmodule
