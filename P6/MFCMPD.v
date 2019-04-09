`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    03:35:58 12/20/2017 
// Design Name: 
// Module Name:    MFCMPD 
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
`define E2D_PC 8//6
`define M2D_MD 7
`define M2D_ALU 6//5
`define M2D_PC 5//4
`define W2D_MD 4
`define W2D_ALU 3
`define W2D_DM 2
`define W2D_PC 1
`define D2E_RT 0
`define ALU 3'b001
`define DM 3'b010
`define PC 3'b011
`define MD 3'b100
`define NW 3'b000
module MFCMPD(
    input [31:0] RF_RD1,
	 input [31:0] RF_RD2,
    input [31:0] AO_M,
    input [31:0] AO_W,
    input [31:0] DR_WD,
    input [31:0] IR_D,
	 input [4:0] A3_E,
    input [4:0] A3_M,
    input [4:0] A3_W,
	 input [2:0] Res_E,
    input [2:0] Res_M,
    input [2:0] Res_W,
	 input [31:0] PC8_E,
	 input [31:0] PC8_M,
	 input [31:0] PC8_W,
	 input [31:0] MD_hi_lo_M,
	 input [31:0] MD_hi_lo_W,
    output reg[31:0] MFCMPD1,
    output reg[31:0] MFCMPD2
    );
	 reg [3:0] FCMPE1,FCMPE2;
	 wire [4:0] A1_D,A2_D;
	 assign A1_D = IR_D[25:21];
	 assign A2_D = IR_D[20:16];
	 always @* begin
	    FCMPE1 =((A1_D==A3_E) & (A1_D!=0)& (Res_E==`PC))  ? `E2D_PC  :
		         ((A1_D==A3_M) & (A1_D!=0) & (Res_M==`MD))  ? `M2D_MD  :
		         ((A1_D==A3_M) & (A1_D!=0) & (Res_M==`ALU)) ? `M2D_ALU :
		         ((A1_D==A3_M) & (A1_D!=0)& (Res_M==`PC))  ? `M2D_PC  :
					((A1_D==A3_W) & (A1_D!=0) & (Res_W==`MD))  ? `W2D_MD  :
               ((A1_D==A3_W) & (A1_D!=0) & (Res_W==`ALU)) ? `W2D_ALU :
               ((A1_D==A3_W) & (A1_D!=0) & (Res_W==`DM))  ? `W2D_DM  :
					((A1_D==A3_W) & (A1_D!=0)& (Res_W==`PC))  ? `W2D_PC  :
					                                0;
	    FCMPE2 =((A2_D==A3_E) & (A2_D!=0)& (Res_E==`PC))  ? `E2D_PC  : 
		         ((A2_D==A3_M) & (A2_D!=0) & (Res_M==`MD))  ? `M2D_MD  :
		         ((A2_D==A3_M) & (A2_D!=0) & (Res_M==`ALU)) ? `M2D_ALU :
					((A2_D==A3_M) & (A2_D!=0)& (Res_M==`PC))  ? `M2D_PC  :
					((A2_D==A3_W) & (A2_D!=0) & (Res_W==`MD))  ? `W2D_MD  :
               ((A2_D==A3_W) & (A2_D!=0) & (Res_W==`ALU)) ? `W2D_ALU :
               ((A2_D==A3_W) & (A2_D!=0) & (Res_W==`DM))  ? `W2D_DM  :
               ((A2_D==A3_W) & (A2_D!=0)& (Res_W==`PC))  ? `W2D_PC  :					
					                                0;
	    case(FCMPE1)
		  0: begin
		    MFCMPD1 = RF_RD1;
		  end
		  1: begin
		    MFCMPD1 = PC8_W;
		  end
		  2: begin
		    MFCMPD1 = DR_WD;
		  end
		  3: begin
		    MFCMPD1 = AO_W;
		  end
		  4: begin
		    MFCMPD1 = MD_hi_lo_W;
		  end
		  5: begin
		    MFCMPD1 = PC8_M;
		  end
		  6: begin
		    MFCMPD1 = AO_M;
		  end
		  7: begin
		    MFCMPD1 = MD_hi_lo_M;
		  end
		  8: begin
		    MFCMPD1 = PC8_E;
		  end
		endcase
		case(FCMPE2)
		  0: begin
		    MFCMPD2 = RF_RD2;
		  end
		  1: begin
		    MFCMPD2 = PC8_W;
		  end
		  2: begin
		    MFCMPD2 = DR_WD;
		  end
		  3: begin
		    MFCMPD2 = AO_W;
		  end
		  4: begin
		    MFCMPD2 = MD_hi_lo_W;
		  end
		  5: begin
		    MFCMPD2 = PC8_M;
		  end
		  6: begin
		    MFCMPD2 = AO_M;
		  end
		  7: begin
		    MFCMPD2 = MD_hi_lo_M;
		  end
		  8: begin
		    MFCMPD2 = PC8_E;
		  end
		endcase
	 end
	 


endmodule
