`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:08:19 12/18/2017 
// Design Name: 
// Module Name:    EXT 
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
module EXT(
    input [31:0] IR_D,
    input ExtOp,
    output reg[31:0] Ext_num
    );
	 wire [15:0] IR_i16_D;
	 assign IR_i16_D = IR_D[15:0];
	 always @* begin
	   case(ExtOp)
		   0: begin
			Ext_num[15:0] = IR_i16_D;
			Ext_num[31:16] = 0;
         end
			1: begin
			Ext_num[15:0] = IR_i16_D;
			Ext_num[31:16] = {15{IR_i16_D[15]}};
			end
		endcase
	 end


endmodule
