`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:11:08 01/01/2018 
// Design Name: 
// Module Name:    MD 
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
`define MULT 3'b001
`define DIV 3'b010
`define MADD 3'b011
`define MSUB 3'b100
`define MTHI 2'b01
`define MTLO 2'b10
`define MFHI 2'b01
`define MFLO 2'b10
module MD(
    input [31:0] MFALUa,
    input [31:0] MFALUb,
	 input clk,
	 input reset,
	 input [2:0] MDWrite,
	 input [2:0] MDsel,
	 input MD_u,
	 input start,
	 input [1:0] MD_load,
    output reg busy,
    output reg [31:0] MD_hi_lo
    );
	 wire [31:0] MD_WD;
	 integer flag;
	 reg [31:0] hi,lo;
	 integer i;
	 assign MD_WD = MFALUa;
	 initial begin
		 flag = 0;
		 busy = 0;
		 i = 0;
		 hi = 0;
		 lo = 0;
	 end
always @* begin
         if(MD_load!=0) begin
			   case(MD_load)
				  `MFHI: begin MD_hi_lo = hi; end
				  `MFLO: begin MD_hi_lo = lo; end
				endcase
			end
end
always @(posedge clk) begin
	   if(reset) begin
		    flag = 0;
		    busy = 0;
			 i = 0;
			 hi = 0;
			 lo = 0;
	   end
	   else begin
		    if(start) begin
			 //start = 0;
			 busy = 1;
			 end
			 if(busy) begin
			   i = i + 1;
				busy <= 1;
			 end
		  	 //if(busy==0&&MDsel!=0) begin
	         // start = 1;
	       //end
			 //if(i==flag) begin
	       case(MDsel) 
	        `MULT: begin
	          flag = 5;
	          if(MD_u) {hi,lo} = MFALUa * MFALUb;
	          else {hi,lo} = $signed(MFALUa) * $signed(MFALUb);
	        end
	        `DIV: begin
	          flag = 10;
	          if(MD_u) begin
	          lo = MFALUa / MFALUb;
	          hi = MFALUa % MFALUb;
	          end
	          else begin
	          lo = $signed(MFALUa) / $signed(MFALUb);
	          hi = $signed(MFALUa) % $signed(MFALUb);
	          end
				 if(MFALUb==0) begin
				    hi = 0;
					 lo = 0;
				 end
	        end
			  `MADD: begin
			    flag = 5;
				 if(MD_u) {hi,lo} = {hi,lo}+MFALUa*MFALUb;
				 else {hi,lo} = $signed({hi,lo})+$signed(MFALUa)*$signed(MFALUb);
			  end
			  `MSUB: begin
			    flag = 10;
				 if(MD_u) {hi,lo} <= $signed({hi,lo})-MFALUa*MFALUb;
				 else {hi,lo} = $signed({hi,lo})-$signed(MFALUa)*$signed(MFALUb);
			  end
			  //default: flag = 0;
	       endcase//MDsel
			 if(i==flag) begin
			 i = 0;
			 busy <= 0;
			// MD_u <= MD_u;//???
			 end
	   end//end else if(reset)
		if(!busy & MDWrite!=0) begin
		   case(MDWrite)
			 `MTHI: begin
			  hi <= MD_WD;
			 end
			 `MTLO: begin
			  lo <= MD_WD;
			 end
			endcase
			flag <= 0;
		end
end
	 

endmodule
