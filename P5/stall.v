`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:21:57 12/20/2017 
// Design Name: 
// Module Name:    stall 
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
`define ALU 2'b01
`define DM 2'b10
`define PC 2'b11
`define NW 2'b00
module stall(
    input [1:0] Res_E,
    input [1:0] Res_M,
    input [31:0] IR_D,
	 input [4:0] A3_E,
	 input [4:0] A3_M,
    output reg Stall
    );
	 wire [4:0] rs,rt;
	 wire [5:0] opcode,func;
	 wire addu_,subu_,ori_,lw_,sw_,beq_,lui_,jr_,jal_,j_,sll_,bgezal_,lb_,lbu_,lh_,lhu_,sb_,sh_,slt_;
	 wire add_,addi_,addiu_,and_,andi_,bgez_,bgtz_,blez_,bltz_,bne_,div_,divu_,jalr_,mfhi_,mflo_;
	 wire mthi_,mtlo_,mult_,multu_,nor_,or_,sllv_,slti_,sltiu_,sltu_,sra_,srav_,srl_,srlv_,sub_,xor_,xori_;
	 wire Tuse_RS0,Tuse_RS1,Tuse_RT0,Tuse_RT1,Tuse_RT2;
	 reg Stall_RS0_E1,Stall_RS0_E2,Stall_RS1_E2,Stall_RS0_M1,Stall_RT0_E1,Stall_RT0_E2,Stall_RT1_E2,Stall_RT0_M1,Stall_RS,Stall_RT;
	 assign rs = IR_D[25:21];
	 assign rt = IR_D[20:16];
	 assign opcode = IR_D[31:26];
	 assign func = IR_D[5:0];
	 
	 //RÐÍ
	 assign addu_ = (`ADDU=={opcode[5:0],func[5:0]})?1:0;
	 assign subu_ = (`SUBU=={opcode[5:0],func[5:0]})?1:0;
	 assign sll_ = (`SLL=={opcode[5:0],func[5:0]})?1:0;
	 assign jr_ = (`JR=={opcode[5:0],func[5:0]})?1:0;
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
	 assign Tuse_RS0 = beq_||jr_||bgezal_||jalr_||bne_||bgez_||bltz_;
	 assign Tuse_RS1 = addu_||subu_||lw_||sw_||ori_||lb_||lbu_||lh_||lhu_||sb_||sh_||slt_||add_||sub_||addi_||addiu_||and_;
	 assign Tuse_RT0 = beq_||bne_;
	 assign Tuse_RT1 = addu_||subu_||sll_||slt_||add_||sub_||and_;
	 assign Tuse_RT2 = sw_||sh_||sb_;
	 always @* begin
	   Stall_RS0_E1 = Tuse_RS0 & (Res_E==`ALU) & (rs == A3_E) & (rs != 0);
      Stall_RS0_E2 = Tuse_RS0 & (Res_E==`DM) & (rs == A3_E) & (rs != 0);
		Stall_RS1_E2 = Tuse_RS1 & (Res_E==`DM) & (rs == A3_E) & (rs != 0);
      Stall_RS0_M1 = Tuse_RS0 & (Res_M==`DM) & (rs == A3_M) & (rs != 0);
		
		Stall_RS = Stall_RS0_E1 ||Stall_RS0_E2 ||Stall_RS1_E2 ||Stall_RS0_M1;
		
		Stall_RT0_E1 = Tuse_RT0 & (Res_E==`ALU) & (rt == A3_E) & (rt != 0);
      Stall_RT0_E2 = Tuse_RT0 & (Res_E==`DM) & (rt == A3_E) & (rt != 0);
		Stall_RT1_E2 = Tuse_RT1 & (Res_E==`DM) & (rt == A3_E) & (rt != 0);
      Stall_RT0_M1 = Tuse_RT0 & (Res_M==`DM) & (rt == A3_M) & (rt != 0);
		
		Stall_RT = Stall_RT0_E1 ||Stall_RT0_E2 ||Stall_RT1_E2 ||Stall_RT0_M1;
		
		Stall = Stall_RS||Stall_RT;
	 end


endmodule
