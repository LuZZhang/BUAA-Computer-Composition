`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:28:39 12/20/2017 
// Design Name: 
// Module Name:    MFALUB 
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
`define M2E_ALU 7//5
`define M2E_MD 6
`define M2E_PC 5//4
`define W2E_ALU 4//3
`define W2E_MD 3
`define W2E_DM 2
`define W2E_PC 1
`define D2E_RT 0
`define ALU 3'b001
`define DM 3'b010
`define PC 3'b011
`define MD 3'b100
`define NW 3'b000
module MFALUB(
    input [31:0] RT_E,
    input [31:0] AO_M,
    input [31:0] AO_W,
    input [31:0] DR_WD,
    input [31:0] IR_E,
    input [4:0] A3_M,
    input [4:0] A3_W,
    input [2:0] Res_M,
    input [2:0] Res_W,
	 input [31:0] PC8_M,
	 input [31:0] PC8_W,
	 input [31:0] MD_hi_lo_M,
	 input [31:0] MD_hi_lo_W,
    output reg[31:0] MFALUb
    );
	 wire [4:0] A2_E;
	 assign A2_E = IR_E[20:16];
	 reg [2:0] FALUBE;//����ѡ���ĸ�MUX����
	 always @* begin
	   FALUBE = ((A2_E==A3_M) & (A2_E!=0) & (Res_M==`ALU)) ? `M2E_ALU :
		         ((A2_E==A3_M) & (A2_E!=0) & (Res_M==`MD))  ?  `M2E_MD :
		         ((A2_E==A3_M) & (A2_E!=0)& (Res_M==`PC))  ? `M2E_PC  :
               ((A2_E==A3_W) & (A2_E!=0) & (Res_W==`ALU)) ? `W2E_ALU :
					((A2_E==A3_W) & (A2_E!=0) & (Res_W==`MD)) ?   `W2E_MD :
               ((A2_E==A3_W) & (A2_E!=0) & (Res_W==`DM))  ? `W2E_DM  : 
					((A2_E==A3_W) & (A2_E!=0)& (Res_W==`PC))  ? `W2E_PC  :
					                                0;
		case(FALUBE)
		  0: begin
		    MFALUb = RT_E;
		  end
		  1: begin
		    MFALUb = PC8_W;
		  end
		  2: begin
		    MFALUb = DR_WD;
		  end
		  3: begin
		    MFALUb = MD_hi_lo_W;
		  end
		  4: begin
		    MFALUb = AO_W;
		  end
		  5: begin
		    MFALUb = PC8_M;
		  end
		  6: begin
		    MFALUb = MD_hi_lo_M;
		  end
		  7: begin
		    MFALUb = AO_M;
		  end
		endcase
	 end


endmodule