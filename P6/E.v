`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:10:12 12/18/2017 
// Design Name: 
// Module Name:    E 
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
module E(
    input clk,
	 input reset,
	 input [31:0] IR_D,
	 input [31:0] MFCMPD1,
	 input [31:0] MFCMPD2,
	 input [31:0] Ext_num,
	 input [4:0] A3,
	 input [2:0] Res,
	 input Stall,
	 input [31:0] PC8_D,
	 input j_zero,
	 input start_D,
	 output reg start,
	 output reg j_zero_E,
	 output reg[31:0] PC8_E,
	 output reg[2:0] Res_E,
	 output reg[4:0] A3_E,
	 output reg[31:0] IR_E,
    output reg[31:0] RS_E,
    output reg[31:0] RT_E,
    output reg[31:0] E32_E
    );
	 always @(posedge clk) begin
	   if(reset) begin
		PC8_E <= 0;
	   IR_E <= 0;
	   RS_E <= 0;
		RT_E <= 0;
		E32_E <= 0;
		A3_E <= 0;
		Res_E <= 0;
		j_zero_E <= 0;
		start <= 0;
		end
		else begin
		if(Stall) begin
		IR_E <= 0;
		Res_E <= 0;
		start <= 0;
		end
		else begin
	   PC8_E <= PC8_D;
	   IR_E <= IR_D;
	   RS_E <= MFCMPD1;
		RT_E <= MFCMPD2;
		E32_E <= Ext_num;
		A3_E <= A3;
		Res_E <= Res;
		j_zero_E <= j_zero;
		start <= start_D;
		end
		end
	 end


endmodule
