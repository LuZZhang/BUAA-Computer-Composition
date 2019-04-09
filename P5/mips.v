`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:15:13 12/18/2017 
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
module mips(
    input clk,
    input reset
    );
	 wire Stall;
	 wire [31:0] MPC_,PC_next,PC_add4,IR,PC4_D,PC8_D,IR_D,IR_E,IR_M,IR_W,PC8_E,RS_E,RT_E;
	 wire [31:0] WData,PC8_M,PC8_W,RF_RD1,RF_RD2,Ext_num,MFCMPD1,MFCMPD2,E32_E,AO_M,AO_W;
	 wire [31:0] NPC_next,DR_W,DR_WD,MFPC,MFALUa,MFALUb,ALUb,AO,RT_M,WriteData,ReadData;
	 wire j_zero,RegWrite,ExtOp,ALUsrc,load_u_M,load_u_W,Memwrite;
	 wire [1:0] PCSel,Res,Res_E,Res_M,Res_W,RegDst,word_bit_M,word_bit_W,MemtoReg;
	 wire [2:0] B_sel,ALUctr;
	 wire [4:0] A3,A3_E,A3_M,A3_W;
	 
	 PC PC_ (
    .clk(clk), 
    .reset(reset), 
    .MPC_(MPC_), 
    .Stall(Stall), 
    .PC_next(PC_next)
    );
	 
	 ADD4 ADD4_ (
    .clk(clk), 
    .PC_next(PC_next), 
    .PC_add4(PC_add4)
    );
	 
	 IM IM_ (
    .PC_next(PC_next), 
    .IR(IR)
    );
	 
	 stall Stall_ (
    .Res_E(Res_E), 
    .Res_M(Res_M), 
    .IR_D(IR_D), 
    .A3_E(A3_E), 
    .A3_M(A3_M), 
    .Stall(Stall)
    );
	 
	 D D1(
    .clk(clk), 
	 .reset(reset),
    .IR(IR), 
	 .Stall(Stall),
    .PC_add4(PC_add4), 
    .PC8_D(PC8_D), 
    .IR_D(IR_D), 
    .PC4_D(PC4_D)
    );
	 
	 contr_D contr_D_ (
    .IR_D(IR_D), 
    .j_zero(j_zero), 
    .ExtOp(ExtOp), 
    .B_sel(B_sel), 
    .PCSel(PCSel), 
    .Res(Res),
	 .RegDst(RegDst),
	 .j_sel(j_sel)
    );
	 
	 RF RF_ (
    .clk(clk), 
    .reset(reset), 
    .IR_D(IR_D), 
    .WData(WData), 
    .RegWrite(RegWrite), 
    .PC8_W(PC8_W), 
    .A3_W(A3_W), 
    .RF_RD1(RF_RD1), 
    .RF_RD2(RF_RD2)
    );
	 
	 EXT EXT_ (
    .IR_D(IR_D), 
    .ExtOp(ExtOp), 
    .Ext_num(Ext_num)
    );
	 
	 MFCMPD MFCMPD_ (
    .RF_RD1(RF_RD1), 
    .RF_RD2(RF_RD2), 
    .AO_M(AO_M), 
    .AO_W(AO_W), 
    .DR_WD(DR_WD), 
    .IR_D(IR_D), 
    .A3_E(A3_E), 
    .A3_M(A3_M), 
    .A3_W(A3_W), 
    .Res_E(Res_E), 
    .Res_M(Res_M), 
    .Res_W(Res_W), 
    .PC8_E(PC8_E), 
    .PC8_M(PC8_M), 
    .PC8_W(PC8_W), 
    .MFCMPD1(MFCMPD1), 
    .MFCMPD2(MFCMPD2)
    );
	 
	 CMP CMP_ (
    .MFCMPD1(MFCMPD1), 
    .MFCMPD2(MFCMPD2), 
    .B_sel(B_sel), 
    .j_zero(j_zero)
    );
	 
	 NPC NPC_ (
    .PC4_D(PC4_D), 
    .IR_D(IR_D), 
    .j_sel(j_sel), 
    .NPC_next(NPC_next)
    );
	 
	 MA3E MA3E_ (
    .RegDst(RegDst), 
    .IR_D(IR_D), 
    .A3(A3)
    );
	 
/* (
    .MFCMPD1(MFCMPD1), 
    .IR_D(IR_D), 
    .A3_M(A3_M), 
    .A3_W(A3_W), 
    .AO_M(AO_M), 
    .AO_W(AO_W), 
    .DR_W(DR_W), 
    .Res_W(Res_W), 
    .Res_M(Res_M),  
    .MFPC(MFPC)
    );*/
	 
	 MPC MPC1 (
    .PCSel(PCSel), 
    .PC_add4(PC_add4), 
    .NPC_next(NPC_next), 
    .MFCMPD1(MFCMPD1), 
    .MPC_(MPC_)
    );
	 
	 E E_ (
    .clk(clk), 
	 .reset(reset),
    .IR_D(IR_D), 
    .MFCMPD1(MFCMPD1), 
    .MFCMPD2(MFCMPD2), 
    .Ext_num(Ext_num), 
    .A3(A3), 
	 .j_zero(j_zero),
	 .j_zero_E(j_zero_E),
    .Res(Res), 
    .Stall(Stall), 
    .PC8_D(PC8_D), 
    .PC8_E(PC8_E), 
    .Res_E(Res_E), 
    .A3_E(A3_E), 
    .IR_E(IR_E), 
    .RS_E(RS_E), 
    .RT_E(RT_E), 
    .E32_E(E32_E)
    );
	 
	 contr_E contr_E_ (
    .IR_E(IR_E), 
    .ALUctr(ALUctr), 
    .ALUsrc(ALUsrc) 
    );
	 
	 MFALUA MFALUA_ (
    .RS_E(RS_E), 
    .AO_M(AO_M), 
    .AO_W(AO_W), 
    .DR_WD(DR_WD), 
    .IR_E(IR_E), 
    .A3_M(A3_M), 
    .A3_W(A3_W), 
	 .PC8_M(PC8_M),
	 .PC8_W(PC8_W),
    .Res_M(Res_M), 
    .Res_W(Res_W), 
    .MFALUa(MFALUa)
    );
	 
	 MFALUB MFALUB_ (
    .RT_E(RT_E), 
    .AO_M(AO_M), 
    .AO_W(AO_W), 
    .DR_WD(DR_WD), 
    .IR_E(IR_E), 
    .A3_M(A3_M), 
    .A3_W(A3_W), 
	 .PC8_M(PC8_M),
	 .PC8_W(PC8_W),
    .Res_M(Res_M), 
    .Res_W(Res_W), 
    .MFALUb(MFALUb)
    );
	 
	 MALUb MALUb_ (
    .MFALUb(MFALUb), 
    .E32_E(E32_E), 
    .ALUsrc(ALUsrc), 
    .ALUb(ALUb)
    );
	 
	 ALU ALU_ (
    .IR_E(IR_E), 
    .MFALUa(MFALUa), 
    .ALUb(ALUb), 
    .ALUctr(ALUctr), 
    .ALUsrc(ALUsrc), 
    .AO(AO)
    );
	 
	 M M_ (
    .clk(clk), 
	 .reset(reset),
    .IR_E(IR_E), 
    .PC8_E(PC8_E), 
    .AO(AO),
    .MFALUb(MFALUb),	  
    .A3_E(A3_E), 
	 .j_zero_E(j_zero_E),
	 .j_zero_M(j_zero_M),
    .Res_E(Res_E), 
    .Res_M(Res_M), 
    .A3_M(A3_M), 
    .IR_M(IR_M), 
    .PC8_M(PC8_M), 
    .AO_M(AO_M), 
    .RT_M(RT_M)
    );
	 
	 contr_M contr_M_ (
    .IR_M(IR_M), 
	 .load_u_M(load_u_M), 
    .word_bit_M(word_bit_M),
    .MemWrite(MemWrite)
    );
	 
	 MFV2M MFV2M_ (
    .RT_M(RT_M), 
    .DR_WD(DR_WD), 
    .AO_W(AO_W), 
    .IR_M(IR_M), 
    .A3_W(A3_W), 
    .Res_W(Res_W), 
	 .PC8_W(PC8_W),
    .WriteData(WriteData)
    );
	 
	 DM DM_ (
    .clk(clk), 
    .reset(reset), 
    .MemWrite(MemWrite), 
	 .load_u_M(load_u_M), 
    .word_bit_M(word_bit_M),
    .AO_M(AO_M), 
	 .PC8_M(PC8_M),
    .WriteData(WriteData), 
    .ReadData(ReadData)
    );
	 W W_ (
    .clk(clk), 
	 .reset(reset),
    .IR_M(IR_M), 
    .PC8_M(PC8_M), 
    .AO_M(AO_M), 
	 .j_zero_M(j_zero_M),
	 .j_zero_W(j_zero_W),
    .ReadData(ReadData), 
    .A3_M(A3_M), 
    .Res_M(Res_M), 
    .Res_W(Res_W), 
    .A3_W(A3_W), 
    .IR_W(IR_W), 
    .PC8_W(PC8_W), 
    .AO_W(AO_W), 
    .DR_W(DR_W)
    );
	 
	 contr_W contr_W_ (
    .IR_W(IR_W), 
	 .j_zero_W(j_zero_W),
	 .RegWrite(RegWrite), 
    .MemtoReg(MemtoReg),
	 .load_u_W(load_u_W), 
    .word_bit_W(word_bit_W)
    );
	 
	 DM_ext DM_ext_ (
    .load_u_W(load_u_W), 
    .word_bit_W(word_bit_W),
    .AO_W(AO_W), 
    .DR_W(DR_W), 
    .DR_WD(DR_WD)
    );
	 
	 MRFWD MRFWD_ (
    .MemtoReg(MemtoReg), 
    .AO_W(AO_W), 
    .DR_WD(DR_WD), 
    .PC8_W(PC8_W), 
    .WData(WData)
    );





endmodule
