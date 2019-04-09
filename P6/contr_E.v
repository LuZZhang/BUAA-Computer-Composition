`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:06:14 12/19/2017 
// Design Name: 
// Module Name:    contr_E 
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
	 `define SLL 12'b000000000000
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
module contr_E(
    input [31:0] IR_E,
    output [4:0] ALUctr,
    output ALUsrc,
	 output [2:0] MDWrite,
	 output [2:0] MDsel,
	 output [1:0] MD_load,
	 output MD_u
	 //output [1:0] RegDst
    );
    wire [5:0] opcode,func;
	 wire [4:0] rt;
	 wire addu_,subu_,ori_,lw_,sw_,beq_,lui_,jr_,jal_,j_,sll_,lb_,lbu_,lh_,lhu_,sb_,sh_,slt_;
	 wire add_,addi_,addiu_,and_,andi_,bgez_,bgtz_,blez_,bltz_,bne_,div_,divu_,jalr_,mfhi_,mflo_;
    wire mthi_,mtlo_,mult_,multu_,nor_,or_,sllv_,slti_,sltiu_,sltu_,sra_,srav_,srl_,srlv_,sub_,xor_,xori_;
	 wire madd_,maddu_,msub_,msubu_;
	 assign opcode = IR_E[31:26];
	 assign func = IR_E[5:0];
	 assign rt = IR_E[20:16];
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
	 assign bgezal_ = (`BGEZAL=={opcode[5:0],rt[4:0]})?1:0;
	 assign lb_ = (`LB=={opcode[5:0]})?1:0;
	 assign lbu_ = (`LBU=={opcode[5:0]})?1:0;
	 assign lh_ = (`LH=={opcode[5:0]})?1:0;
	 assign lhu_ = (`LHU=={opcode[5:0]})?1:0;
	 assign sb_ = (`SB=={opcode[5:0]})?1:0; 
	 assign sh_ = (`SH=={opcode[5:0]})?1:0; 
	 assign slt_ = (`SLT=={opcode[5:0],func[5:0]})?1:0;
	 //
	 assign add_ = (`ADD=={opcode[5:0],func[5:0]})?1:0;
	 assign addi_ = (`ADDI=={opcode[5:0]})?1:0;
	 assign addiu_ = (`ADDIU=={opcode[5:0]})?1:0;	 
	 assign and_ = (`AND=={opcode[5:0],func[5:0]})?1:0;
    assign andi_ = (`ANDI=={opcode[5:0]})?1:0;
	 assign bgez_ = (`BGEZ=={opcode[5:0],rt[4:0]})?1:0;
	 assign bgtz_ = (`BGTZ=={opcode[5:0]})?1:0;
	 assign blez_ = (`BLEZ=={opcode[5:0]})?1:0;
	 assign bltz_ = (`BLTZ=={opcode[5:0],rt[4:0]})?1:0;
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
	 //
	 assign ALUctr[4] = sltiu_||sltu_;
	 assign ALUctr[3] = nor_||or_||xor_||xori_||sllv_||sra_||srav_||srl_||srlv_;
	 assign ALUctr[2] = sll_||slt_||slti_||and_||andi_||sra_||srav_||srl_||srlv_;
	 assign ALUctr[1] = ori_||lui_||slt_||slti_||and_||andi_||xor_||xori_||sllv_||srl_||srlv_;
	 assign ALUctr[0] = subu_||lui_||sll_||sub_||and_||andi_||or_||sllv_||srav_||srlv_;
    assign ALUsrc = ori_||lw_||sw_||lui_||lb_||lbu_||lh_||lhu_||sh_||sb_||addi_||addiu_||andi_||xori_||slti_||sltiu_; //确定第二个操作数
	 assign MDWrite[2] = 0;
	 assign MDWrite[1] = mtlo_;
	 assign MDWrite[0] = mthi_;
	 assign MDsel[2] = msub_||msubu_;
	 assign MDsel[1] = div_||divu_||madd_||maddu_;
	 assign MDsel[0] = mult_||multu_||madd_||maddu_;
	 assign MD_u = multu_||divu_||maddu_||msubu_;
	 assign MD_load[1] = mflo_;
	 assign MD_load[0] = mfhi_;

endmodule
