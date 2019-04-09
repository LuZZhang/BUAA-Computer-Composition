`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:37:51 12/19/2017 
// Design Name: 
// Module Name:    contr_D 
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
    `define ADDU 12'b000000100001
	 `define SUBU 12'b000000100011
	 `define ORI 6'b001101
	 `define LW 6'b100011
	 `define SW 6'b101011
	 `define BEQ 6'b000100
	 `define LUI 6'b001111
	 `define SLL 12'b000000000000//sll 
	 `define JAL 6'b000011
	 `define JR 12'b000000001000
	 `define J 6'b000010
	 //
	 `define BGEZAL 11'b00000110001
	 `define LB 6'b100000
	 `define LBU 6'b100100
	 `define LH 6'b100001
	 `define LHU 6'b100101
	 `define SB 6'b101000
	 `define SH 6'b101001
	 `define SLT 12'b000000101010
     //P6
	 `define ADD 12'b000000100000
	 `define ADDI 6'b001000
	 `define ADDIU 6'b001001
	 `define AND 12'b000000100100
	 `define ANDI 6'b001100
	 `define BGEZ 11'b00000100001//rt
	 `define BGTZ 6'b000111
	 `define BLEZ 6'b000110
	 `define BLTZ 11'b00000100000
	 `define BNE 6'b000101
	 `define DIV 12'b000000011010
	 `define DIVU 12'b000000011011
	 `define JALR 12'b000000001001
	 `define MFHI 12'b000000010000
	 `define MFLO 12'b000000010010
	 `define MTHI 12'b000000010001
	 `define MTLO 12'b000000010011
	 `define MULT 12'b000000011000
	 `define MULTU 12'b000000011001
	 `define NOR 12'b000000100111
	 `define OR 12'b000000100101
	 `define SLLV 12'b000000000100
	 `define SLTI 6'b001010
	 `define SLTIU 6'b001011
	 `define SLTU 12'b000000101011
	 `define SRA 12'b000000000011
	 `define SRAV 12'b000000000111
	 `define SRL 12'b000000000010
	 `define SRLV 12'b000000000110
	 `define SUB 12'b000000100010
	 `define XOR 12'b000000100110
	 `define XORI 6'b001110
	 //
	 `define MADD 12'b011100000000
	 `define MADDU 12'b011100000001
	 `define MSUB 12'b011100000100
	 `define MSUBU 12'b011100000101
module contr_D(
    input [31:0] IR_D,
	 input j_zero,
    //output RegWrite,
    output ExtOp,
    output [2:0] B_sel,
	 output [1:0] PCSel,
	 output [2:0] Res,
	 output [1:0] RegDst,
	 output start_D,
	 output j_sel
    );
	 wire [5:0] opcode,func;
	 wire [4:0] rt_D;
	 wire addu_,subu_,ori_,lw_,sw_,beq_,lui_,jr_,jal_,j_,bgezal_,lb_,lbu_,lh_,lhu_,sb_,sh_,sll_,slt_;
	 wire add_,addi_,addiu_,and_,andi_,bgez_,bgtz_,blez_,bltz_,bne_,div_,divu_,jalr_,mfhi_,mflo_;
	 wire mthi_,mtlo_,mult_,multu_,nor_,or_,sllv_,slti_,sltiu_,sltu_,sra_,srav_,srl_,srlv_,sub_,xor_,xori_;
	 wire madd_,maddu_,msub_,msubu_;
	 assign opcode = IR_D[31:26];
	 assign func = IR_D[5:0];
	 assign rt_D = IR_D[20:16];
	 //R型
	 assign addu_ = (`ADDU=={opcode[5:0],func[5:0]})?1:0;
	 assign subu_ = (`SUBU=={opcode[5:0],func[5:0]})?1:0;
	 assign sll_ = (`SLL=={opcode[5:0],func[5:0]})?1:0;
	 assign jr_ = (`JR=={opcode[5:0],func[5:0]})?1:0;
	 //
	 assign ori_ = (`ORI=={opcode[5:0]})?1:0;
	 assign lw_ = (`LW=={opcode[5:0]})?1:0;
	 assign sw_ = (`SW=={opcode[5:0]})?1:0; 
    assign beq_ = (`BEQ=={opcode[5:0]})?1:0;	
    assign lui_ = (`LUI=={opcode[5:0]})?1:0;
    assign j_ = (`J=={opcode[5:0]})?1:0;	 
	 assign jal_ = (`JAL=={opcode[5:0]})?1:0;
	 //
	 assign bgezal_ = (`BGEZAL=={opcode[5:0],rt_D[4:0]})?1:0;
	 assign lb_ = (`LB=={opcode[5:0]})?1:0;
	 assign lbu_ = (`LBU=={opcode[5:0]})?1:0;
	 assign lh_ = (`LH=={opcode[5:0]})?1:0;
	 assign lhu_ = (`LHU=={opcode[5:0]})?1:0;
	 assign sb_ = (`SB=={opcode[5:0]})?1:0; 
	 assign sh_ = (`SH=={opcode[5:0]})?1:0; 
	 assign slt_ = (`SLT=={opcode[5:0],func[5:0]})?1:0;
	 //p6
	 assign add_ = (`ADD=={opcode[5:0],func[5:0]})?1:0;
	 assign addi_ = (`ADDI=={opcode[5:0]})?1:0;
	 assign addiu_ = (`ADDIU=={opcode[5:0]})?1:0;	 
	 assign and_ = (`AND=={opcode[5:0],func[5:0]})?1:0;
    assign andi_ = (`ANDI=={opcode[5:0]})?1:0;
	 assign bgez_ = (`BGEZ=={opcode[5:0],rt_D[4:0]})?1:0;
	 assign bgtz_ = (`BGTZ=={opcode[5:0]})?1:0;
	 assign blez_ = (`BLEZ=={opcode[5:0]})?1:0;
	 assign bltz_ = (`BLTZ=={opcode[5:0],rt_D[4:0]})?1:0;
	 assign bne_ = (`BNE=={opcode[5:0]})?1:0;
	 assign div_ = (`DIV=={opcode[5:0],func[5:0]})?1:0;
	 assign divu_ = (`DIVU=={opcode[5:0],func[5:0]})?1:0;
	 assign jalr_ = (`JALR=={opcode[5:0],func[5:0]})?1:0;
	 assign mfhi_ = (`MFHI=={opcode[5:0],func[5:0]})?1:0;
	 assign mflo_ = (`MFLO=={opcode[5:0],func[5:0]})?1:0;
	 assign mthi_ = (`MTHI=={opcode[5:0],func[5:0]})?1:0;
	 assign mtlo_ = (`MTLO=={opcode[5:0],func[5:0]})?1:0;
	 assign mult_ = (`MULT=={opcode[5:0],func[5:0]})?1:0;
	 assign multu_ = (`MULTU=={opcode[5:0],func[5:0]})?1:0;
	 assign nor_ = (`NOR=={opcode[5:0],func[5:0]})?1:0;
	 assign or_ = (`OR=={opcode[5:0],func[5:0]})?1:0;
	 assign sllv_ = (`SLLV=={opcode[5:0],func[5:0]})?1:0;
	 assign slti_ = (`SLTI=={opcode[5:0]})?1:0;
	 assign sltiu_ = (`SLTIU=={opcode[5:0]})?1:0;
	 assign sltu_ = (`SLTU=={opcode[5:0],func[5:0]})?1:0;
	 assign sra_ = (`SRA=={opcode[5:0],func[5:0]})?1:0;
	 assign srav_ = (`SRAV=={opcode[5:0],func[5:0]})?1:0;
	 assign srl_ = (`SRL=={opcode[5:0],func[5:0]})?1:0;
	 assign srlv_ = (`SRLV=={opcode[5:0],func[5:0]})?1:0;
	 assign sub_ = (`SUB=={opcode[5:0],func[5:0]})?1:0;
	 assign xor_ = (`XOR=={opcode[5:0],func[5:0]})?1:0;
	 assign xori_ = (`XORI=={opcode[5:0]})?1:0;
    //
	 assign madd_ = (`MADD=={opcode[5:0],func[5:0]})?1:0;
    assign maddu_ = (`MADDU=={opcode[5:0],func[5:0]})?1:0;
	 assign msub_ = (`MSUB=={opcode[5:0],func[5:0]})?1:0;
	 assign msubu_ = (`MSUBU=={opcode[5:0],func[5:0]})?1:0;
	 //assign RegWrite = addu_||subu_||ori_||lw_||lui_||jal_; //GPR使能端
	 assign ExtOp = lw_||sw_||lb_||lbu_||lh_||lhu_||sb_||sh_||addi_||addiu_||slti_||sltiu_;
	 assign B_sel[2] = bltz_||bgtz_||blez_;//bltz=100
	 assign B_sel[1] = bne_||bgez_||blez_;//bne=10,bgez=11
	 assign B_sel[0] = bgezal_||bgez_||bgtz_;//beq_=00,bgezal_=01,
	 assign PCSel[1] = jr_||jalr_;
	 assign PCSel[0] = (beq_&j_zero)||(bgezal_&j_zero)||(bne_&j_zero)||(bgez_&j_zero)||(bltz_&j_zero)||(blez_&j_zero)||(bgtz_&j_zero)||j_||jal_;
	 assign Res[2] = mfhi_||mflo_;
	 assign Res[1] = lw_||jal_||(bgezal_&j_zero)||lb_||lbu_||lh_||lhu_||jalr_;
	 assign Res[0] = jal_||addu_||subu_||ori_||lui_||(bgezal_&j_zero)||sll_||slt_||add_||sub_||jalr_||addi_||addiu_||and_||andi_||nor_||or_||xor_||xori_||sllv_||slti_||sltiu_||sltu_||sra_||srav_||srl_||srlv_;
	 assign RegDst[1] = jal_||bgezal_;
	 assign RegDst[0] = addu_||subu_||sll_||slt_||add_||sub_||jalr_||and_||nor_||or_||xor_||sllv_||sltu_||sra_||srav_||srl_||srlv_||mfhi_||mflo_;//确定回写寄存器位置
	 assign j_sel = jal_||j_||jalr_;
	 assign start_D = mult_||multu_||div_||divu_||madd_||maddu_||msub_||msubu_;
endmodule
