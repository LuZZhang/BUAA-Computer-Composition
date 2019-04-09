`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:24:18 12/19/2017 
// Design Name: 
// Module Name:    MRFWD 
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
module MRFWD(
    input [1:0] MemtoReg,
	 input [31:0] AO_W,
    input [31:0] DR_WD,
    input [31:0] PC8_W,
    output reg[31:0] WData
    );
	 always @* begin
	 case(MemtoReg)
	   0: begin
		WData = AO_W;
		end
		1: begin
		WData = DR_WD;
		end
		2: begin
		WData = PC8_W;
		end
	 endcase
	 end


endmodule
