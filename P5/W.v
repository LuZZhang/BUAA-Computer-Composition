`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:36:49 12/18/2017 
// Design Name: 
// Module Name:    W 
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
module W(
    input clk,
	 input reset,
    input [31:0] IR_M,
    input [31:0] PC8_M,
    input [31:0] AO_M,
    input [31:0] ReadData,
	 input [4:0] A3_M,
	 input [1:0] Res_M,
	 input j_zero_M,
	 output reg j_zero_W,
	 output reg[1:0] Res_W,
	 output reg[4:0] A3_W,
    output reg[31:0] IR_W,
    output reg[31:0] PC8_W,
    output reg[31:0] AO_W,
    output reg[31:0] DR_W
    );
    always @(posedge clk) begin
	   if(reset) begin
		IR_W <= 0;
		PC8_W <= 0;
		AO_W <= 0;
		DR_W <= 0;
		A3_W <= 0;
		Res_W <= 0;
		j_zero_W <= 0;
		end
	   else begin
	   IR_W <= IR_M;
		PC8_W <= PC8_M;
		AO_W <= AO_M;
		DR_W <= ReadData;
		A3_W <= A3_M;
		Res_W <= Res_M;
		j_zero_W <= j_zero_M;
		end
	 end//end always

endmodule
