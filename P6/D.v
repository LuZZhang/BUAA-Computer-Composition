`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:13:16 12/18/2017 
// Design Name: 
// Module Name:    D 
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
module D(
    input clk,
	 input reset,
	 input [31:0] IR,
	 input [31:0] PC_add4,
	 input Stall,
	 output reg[31:0] PC8_D,
	 output reg[31:0] IR_D,
	 output reg[31:0] PC4_D
    );
	 always @(posedge clk) begin
	   if(reset) begin
		IR_D <= 0;
		PC4_D <= 0;
		PC8_D <= 0;
		end
		else begin
		if(Stall) begin
		end
		else begin
	   IR_D <= IR;
	   PC4_D <= PC_add4;//ADD4
		PC8_D <= PC_add4 + 4;
		end
		end
	 end


endmodule
