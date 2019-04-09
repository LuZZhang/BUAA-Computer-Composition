`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:13:21 12/18/2017 
// Design Name: 
// Module Name:    CMP 
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
module CMP(
    input [31:0] MFCMPD1,
    input [31:0] MFCMPD2,
    input [2:0] B_sel,//控制信号，决定是哪种B指令
    output reg j_zero
    );
	 
	 always @* begin
	 case(B_sel)
	    0: begin //beq
		 if(MFCMPD1==MFCMPD2) j_zero = 1;
		 else j_zero = 0;
		 end
		 1: begin//bgezal
		 if(MFCMPD1[31]== 0) begin
		    j_zero = 1;
		 end
		 else begin
		    j_zero = 0;
		 end
		 end//1 end
		 2: begin//bne
		 if(MFCMPD1!=MFCMPD2) j_zero = 1;
		 else j_zero = 0;
		 end
		 3: begin//bgez
		 if(MFCMPD1[31]== 0) begin
		    j_zero = 1;
		 end
		 else begin
		    j_zero = 0;
		 end
		 end
		 4: begin//bltz
		 if(MFCMPD1[31]== 1) begin
		    j_zero = 1;
		 end
		 else begin
		    j_zero = 0;
		 end
		 end
		 default: begin
		 j_zero = 0;
		 end
	 endcase
	 end


endmodule
