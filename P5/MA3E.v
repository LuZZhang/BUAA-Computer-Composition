`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:06:03 12/19/2017 
// Design Name: 
// Module Name:    MA3E 
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
module MA3E(
    input [1:0] RegDst,
	 input [31:0] IR_D,
    output reg[4:0] A3
    );
	 wire [4:0] IR_rt_D,IR_rd_D;
	 assign IR_rt_D = IR_D[20:16];
	 assign IR_rd_D = IR_D[15:11]; 
	 always @* begin
	   case(RegDst) 
		  0: begin
		  A3 = IR_rt_D;
		  end
		  1: begin
		  A3 = IR_rd_D;
		  end
		  2: begin
		  A3 = 5'b11111;
		  end
		endcase
	 end


endmodule
