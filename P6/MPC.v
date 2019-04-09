`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:49:35 12/19/2017 
// Design Name: 
// Module Name:    MPC 
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
module MPC(
    input [1:0] PCSel,
	 input [31:0] PC_add4,
    input [31:0] NPC_next,
    input [31:0] MFCMPD1,
    output reg[31:0] MPC_
    );
	 always @* begin
	   case(PCSel) 
		  0: begin
		  MPC_ <= PC_add4;
		  end
		  1: begin
		  MPC_ <= NPC_next;
		  end
		  2: begin
		  MPC_ <= MFCMPD1;
		  end
		endcase
	 end


endmodule
