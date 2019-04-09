`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:27:44 12/05/2017 
// Design Name: 
// Module Name:    ext 
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
module ext(
    input [1:0] ExtOp,
    input [15:0] imm,
	 input [4:0] in_16_20,
	 input [4:0] in_21_25,
    output reg [31:0] Ext_num
    );
	 wire [25:0] jal_offset;
	 assign jal_offset[15:0] = imm;
	 assign jal_offset[20:16] = in_16_20;
	 assign jal_offset[25:21] = in_21_25;
    always @(*) begin
	    case(ExtOp)
		   0: begin
			Ext_num[15:0] = imm;
			Ext_num[31:16] = 0;
         end
			1: begin
			Ext_num[15:0] = imm;
			Ext_num[31:16] = {15{imm[15]}};
			end
			2: begin
			Ext_num[1:0] = 0;
			Ext_num[27:2] = jal_offset;
			Ext_num[31:28] = 0;
			end
			default: begin
			Ext_num = 0;
			end
		 endcase
	 end

endmodule
