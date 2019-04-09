`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:44:49 12/03/2017 
// Design Name: 
// Module Name:    control 
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
module control(
    input [5:0] opcode,
    input [5:0] func,
    output [1:0] RegDst,
    output ALUSrc,
    output [1:0] MemtoReg,
    output RegWrite,
    output MemWrite,
    output nPC_sel,
    output [1:0] ExtOp,
    output [1:0] word_bit,
	 output load_u,
    output [1:0] j_src,
	 output [1:0] j_zero,
    output [2:0] ALUctr
    );
	 wire addu,subu,ori,lw,sw,beq,lui,jr,nop,sb,lhu,xori,sh,lh,lbu,lb;
	 //与阵列
	 assign addu = (!opcode[5])&&(!opcode[4])&&(!opcode[3])&&(!opcode[2])&&(!opcode[1])&&(!opcode[0])&&(func[5])&&(!func[4])&&(!func[3])&&(!func[2])&&(!func[1])&&(func[0]);
	 assign subu = (!opcode[5])&&(!opcode[4])&&(!opcode[3])&&(!opcode[2])&&(!opcode[1])&&(!opcode[0])&&(func[5])&&(!func[4])&&(!func[3])&&(!func[2])&&(func[1])&&(func[0]);
	 assign ori = (!opcode[5])&&(!opcode[4])&&(opcode[3])&&(opcode[2])&&(!opcode[1])&&(opcode[0]);
	 assign lw = (opcode[5])&&(!opcode[4])&&(!opcode[3])&&(!opcode[2])&&(opcode[1])&&(opcode[0]);
	 assign sw = (opcode[5])&&(!opcode[4])&&(opcode[3])&&(!opcode[2])&&(opcode[1])&&(opcode[0]);
	 assign beq = (!opcode[5])&&(!opcode[4])&&(!opcode[3])&&(opcode[2])&&(!opcode[1])&&(!opcode[0]);
	 assign lui = (!opcode[5])&&(!opcode[4])&&(opcode[3])&&(opcode[2])&&(opcode[1])&&(opcode[0]);
	 assign jal = (!opcode[5])&&(!opcode[4])&&(!opcode[3])&&(!opcode[2])&&(opcode[1])&&(opcode[0]);
	 assign jr = (!opcode[5])&&(!opcode[4])&&(!opcode[3])&&(!opcode[2])&&(!opcode[1])&&(!opcode[0])&&(!func[5])&&(!func[4])&&(func[3])&&(!func[2])&&(!func[1])&&(!func[0]);
	 assign nop = (!opcode[5])&&(!opcode[4])&&(!opcode[3])&&(!opcode[2])&&(!opcode[1])&&(!opcode[0])&&(!func[5])&&(!func[4])&&(!func[3])&&(!func[2])&&(!func[1])&&(!func[0]);
	 //
	 assign sb = (opcode[5])&&(!opcode[4])&&(opcode[3])&&(!opcode[2])&&(!opcode[1])&&(!opcode[0]);
	 assign lhu = (opcode[5])&&(!opcode[4])&&(!opcode[3])&&(opcode[2])&&(!opcode[1])&&(opcode[0]);
	 assign xori = (!opcode[5])&&(!opcode[4])&&(opcode[3])&&(opcode[2])&&(opcode[1])&&(!opcode[0]);
	 assign lh = (opcode[5])&&(!opcode[4])&&(!opcode[3])&&(!opcode[2])&&(!opcode[1])&&(opcode[0]);
	 assign sh = (opcode[5])&&(!opcode[4])&&(opcode[3])&&(!opcode[2])&&(!opcode[1])&&(opcode[0]);
	 assign lb = (opcode[5])&&(!opcode[4])&&(!opcode[3])&&(!opcode[2])&&(!opcode[1])&&(!opcode[0]);
	 assign lbu = (opcode[5])&&(!opcode[4])&&(!opcode[3])&&(opcode[2])&&(!opcode[1])&&(!opcode[0]);
	 //或阵列
	 assign RegDst[1] = jal;
	 assign RegDst[0] = addu||subu; //确定回写寄存器位置
	 assign ALUSrc = ori||lw||sw||lui||sb||lhu||sh||lh||lbu||lb||xori; //确定第二个操作数
	 assign MemtoReg[1] = jal; 
	 assign MemtoReg[0] = lw||lh||lhu||lb||lbu; //回写什么
	 assign RegWrite = addu||subu||ori||lw||lui||jal||lhu||lh||lbu||lb; //GPR使能端
	 assign MemWrite = sw||sb||sh;//DM使能端
	 assign nPC_sel = beq||jal||jr; //是否可能跳转
	 assign ExtOp[1] = jal;
	 assign ExtOp[0] = lw||sw||beq||sb||lhu||sh||lh||lbu||lb;
	 assign word_bit[1] = sb||lbu||lb;
	 assign word_bit[0] = lhu||sh||lh;
	 assign load_u = lhu||lbu;
	 assign j_src[1] = jr;
	 assign j_src[0] = jal;
	 assign j_zero[1] = 0;
	 assign j_zero[0] = beq;
	 assign ALUctr[2] = xori;
	 assign ALUctr[1] = ori||lui;
	 assign ALUctr[0] = subu||beq||lui;


endmodule
