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
`define M2E_ALU 5
`define M2E_PC 4
`define W2E_ALU 3
`define W2E_DM 2
`define W2E_PC 1
`define D2E_RT 0
`define ALU 2'b01
`define DM 2'b10
`define PC 2'b11
`define NW 2'b00
module MFALUB(
    input [31:0] RT_E,
    input [31:0] AO_M,
    input [31:0] AO_W,
    input [31:0] DR_WD,
    input [31:0] IR_E,
    input [4:0] A3_M,
    input [4:0] A3_W,
    input [1:0] Res_M,
    input [1:0] Res_W,
	 input [31:0] PC8_M,
	 input [31:0] PC8_W,
    output reg[31:0] MFALUb
    );
	 wire [4:0] A2_E;
	 assign A2_E = IR_E[20:16];
	 reg [2:0] FALUBE;//控制选择哪个MUX出口
	 always @* begin
	   FALUBE = ((A2_E==A3_M) & (A2_E!=0) & (Res_M==`ALU)) ? `M2E_ALU :
		         ((A2_E==A3_M) & (A2_E==31)& (Res_M==`PC))  ? `M2E_PC  :
               ((A2_E==A3_W) & (A2_E!=0) & (Res_W==`ALU)) ? `W2E_ALU :
               ((A2_E==A3_W) & (A2_E!=0) & (Res_W==`DM))  ? `W2E_DM  : 
					((A2_E==A3_W) & (A2_E==31)& (Res_W==`PC))  ? `W2E_PC  :
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
		    MFALUb = AO_W;
		  end
		  4: begin
		    MFALUb = PC8_M;
		  end
		  5: begin
		    MFALUb = AO_M;
		  end
		endcase
	 end


endmodule
