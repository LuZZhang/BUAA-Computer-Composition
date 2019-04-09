`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:10:29 12/27/2017 
// Design Name: 
// Module Name:    DM_ext 
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
module DM_ext(
    input load_u_W,
	 input [1:0] word_bit_W,
	 input [31:0] AO_W,
	 input [31:0] DR_W,
	 output reg [31:0] DR_WD
    );
	 
	 always @(*) begin
	   // 开始load
			 case(word_bit_W)
			 0: begin
			 DR_WD = DR_W;
			 end//lw
			 1: begin
			  case(AO_W[1]) 
			  0: begin
			   if(load_u_W) begin
				  DR_WD[15:0] = DR_W[15:0];
				  DR_WD[31:16] = 0;
				end
				else begin
				  DR_WD[15:0] = DR_W[15:0];
				  DR_WD[31:16] = {16{DR_WD[15]}};
				end
			  end
			  1: begin
			   if(load_u_W) begin
				  DR_WD[15:0] = DR_W[31:16];
				  DR_WD[31:16] = 0;
				end
				else begin
				  DR_WD[15:0] = DR_W[31:16];
				  DR_WD[31:16] = {16{DR_WD[15]}};
				end
			  end
			  endcase
			  end
			 2: begin
			    case(AO_W[1:0]) 
				  0: begin
				   DR_WD[7:0] = DR_W[7:0];
					if(load_u_W)  DR_WD[31:8] = 0;//无符号
					else DR_WD[31:8] = {24{DR_WD[7]}};
			     end
				  1: begin
				   DR_WD[7:0] = DR_W[15:8];
					if(load_u_W)  DR_WD[31:8] = 0;//无符号
					else DR_WD[31:8] = {24{DR_WD[7]}};
				  end
				  2: begin
				   DR_WD[7:0] = DR_W[23:16];
					if(load_u_W)  DR_WD[31:8] = 0;//无符号
					else DR_WD[31:8] ={24{DR_WD[7]}};
				  end
				  3: begin
				   DR_WD[7:0] = DR_W[31:24];
					if(load_u_W)  DR_WD[31:8] = 0;//无符号
					else DR_WD[31:8] = {24{DR_WD[7]}};
				  end
				 endcase
			  end
			 //end//lb(u)
			 endcase
	 end//end always


endmodule
