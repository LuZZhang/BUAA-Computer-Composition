`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:32:17 12/18/2017 
// Design Name: 
// Module Name:    PC 
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
module PC(
    input clk,
	 input reset,
    input [31:0] MPC_,
	 input Stall,
	 output reg[31:0] PC_next
    );
	 wire PC_en;
	 assign PC_en = !Stall;
	 initial begin
	   PC_next <= 32'h0000_3000;
	 end
    always @(posedge clk) begin
	   if(reset) begin
		  PC_next <= 32'h0000_3000;
		end
		else if(PC_en) begin
		  PC_next <= MPC_;
		end//PC_en=1ÇÒreset=0
	 end//end always

endmodule
