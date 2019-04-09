`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:58:09 12/18/2017 
// Design Name: 
// Module Name:    M 
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
module M(
    input clk,
	 input reset,
	 input [31:0] IR_E,
    input [31:0] PC8_E,
    input [31:0] AO,
	 input [4:0] A3_E,
	 input [1:0] Res_E,
	 input [31:0] MFALUb,
	 input j_zero_E,
	 output reg j_zero_M,
	 output reg[1:0] Res_M,
	 output reg[4:0] A3_M,
    output reg[31:0] IR_M,
    output reg[31:0] PC8_M,
    output reg[31:0] AO_M,
    output reg[31:0] RT_M
    );
	 always @(posedge clk) begin
	   if(reset) begin
		IR_M <= 0;
		PC8_M <= 0;
		AO_M <= 0;
		RT_M <= 0;
		A3_M <= 0;
		Res_M <= 0;
		j_zero_M <= 0;
		end
		else begin
	   IR_M <= IR_E;
		PC8_M <= PC8_E;
		AO_M <= AO;
		RT_M <= MFALUb;
		A3_M <= A3_E;
		Res_M <= Res_E;
		j_zero_M <= j_zero_E;
		end
	 end


endmodule
