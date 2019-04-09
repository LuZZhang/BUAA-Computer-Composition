`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:23:15 12/20/2017 
// Design Name: 
// Module Name:    MFALUA 
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
`define D2E_RS 0
`define ALU 2'b01
`define DM 2'b10
`define PC 2'b11
`define NW 2'b00
module MFALUA(
    input [31:0] RS_E,
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
    output reg [31:0] MFALUa
    );
	 wire [4:0] A1_E;
	 reg [2:0] FALUAE;
	 assign A1_E = IR_E[25:21];
     always @* begin
	   FALUAE = ((A1_E==A3_M) & (A1_E!=0) & (Res_M==`ALU)) ? `M2E_ALU :
		         ((A1_E==A3_M) & (A1_E==31)& (Res_M==`PC))  ? `M2E_PC  :
               ((A1_E==A3_W) & (A1_E!=0) & (Res_W==`ALU)) ? `W2E_ALU :
               ((A1_E==A3_W) & (A1_E!=0) & (Res_W==`DM))  ? `W2E_DM  : 
					((A1_E==A3_W) & (A1_E==31)& (Res_W==`PC))  ? `W2E_PC  :
					                                0;
		case(FALUAE)
		  0: begin
		    MFALUa = RS_E;
		  end
		  1: begin
		    MFALUa = PC8_W;
		  end
		  2: begin
		    MFALUa = DR_WD;
		  end
		  3: begin
		    MFALUa = AO_W;
		  end
		  4: begin
		    MFALUa = PC8_M;
		  end
		  5: begin
		    MFALUa = AO_M;
		  end
		endcase
	 end

endmodule
