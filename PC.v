`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:30:22 12/06/2017 
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
    input reset,
	 input clk,
    input [31:0] pc,
	 input nPC_sel,
	 input zero,
    //input PCSrc,
	 input [1:0] j_src,
	 input [31:0] ext_num,
    input [31:0] RD_1,
    output reg [31:0] pc_next
    );
	 wire [31:0] PC_4;
	 wire PCSrc;
	 assign PCSrc = nPC_sel&&zero;
	 assign PC_4 = pc + 4;
	 initial begin
	   pc_next <= 32'h0000_3000;
	 end
	 always @(posedge clk) begin
	   if(reset) begin
		  pc_next <= 32'h0000_3000;
		end//end if(reset)
		else begin
		  if(PCSrc==0) pc_next <= PC_4;
		  else if(PCSrc==1) begin//if(PCSrc)
		    case(j_src)
			  0: begin
			  pc_next <= PC_4 + ext_num*4;
			  end
			  1: begin
			  pc_next <= ext_num;
			  end
			  2: begin
			  pc_next <= RD_1;
			  end
			 endcase
		  end//end if(PCSrc)
		end//end if(!reset)
	 end//end always

endmodule
