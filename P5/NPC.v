`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:27:56 12/18/2017 
// Design Name: 
// Module Name:    NPC 
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
module NPC(
    input [31:0] PC4_D,
	 input [31:0] IR_D,
    input j_sel,//确定何种跳转指令
    output reg[31:0] NPC_next
    );
	 wire [31:0] PC_D;
	 wire [25:0] IR_i26_D;
	 wire [15:0] IR_i16_D;
	 wire [31:0] ext_i16;
	 wire [31:0] ext_i26;
	 assign PC_D = PC4_D - 4;
	 assign IR_i26_D = IR_D[25:0];
	 assign IR_i16_D = IR_D[15:0];
	 assign ext_i16[15:0] = IR_i16_D;
	 assign ext_i16[31:16] = {16{IR_i16_D[15]}};
	 assign ext_i26[1:0] = 0;
	 assign ext_i26[27:2] = IR_i26_D;
	 assign ext_i26[31:28] = PC_D[31:28];
	 
	 always @* begin
	   if(j_sel==0) begin
		NPC_next <= PC4_D + 4*ext_i16;
		end
		else if(j_sel==1) begin
		NPC_next <= ext_i26;
		end
	 end
	  
		  


endmodule
