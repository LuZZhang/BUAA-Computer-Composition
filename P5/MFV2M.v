`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:26:10 12/21/2017 
// Design Name: 
// Module Name:    MFV2M 
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
`define W2M_ALU 3
`define W2M_DM 2
`define W2M_PC 1
`define M2M_RT 0
`define ALU 2'b01
`define DM 2'b10
`define PC 2'b11
`define NW 2'b00
module MFV2M(
    input [31:0] RT_M,
    input [31:0] DR_WD,
    input [31:0] AO_W,
    input [31:0] IR_M,
    input [4:0] A3_W,
    input [1:0] Res_W,
	 input [31:0] PC8_W,
    output reg[31:0] WriteData
    );
	 reg [1:0] FV2M;
	 wire [4:0] A2_M;
	 assign A2_M = IR_M[20:16];
	 always @* begin
	   FV2M = ((A2_M==A3_W) & (A2_M!= 0) & (Res_W==`ALU)) ? `W2M_ALU : 
				 ((A2_M==A3_W) & (A2_M!= 0) & (Res_W==`DM))  ? `W2M_DM  :
             ((A2_M==A3_W) & (A2_M==31) & (Res_W==`PC))  ? `W2M_PC  : 
					                                0;
	   case(FV2M)
		  0: begin
		    WriteData = RT_M;
		  end
		  1: begin
		    WriteData = PC8_W;
		  end
		  2: begin
		    WriteData = DR_WD;
		  end
		  3: begin
		    WriteData = AO_W;
		  end
		endcase 
	 end


endmodule
