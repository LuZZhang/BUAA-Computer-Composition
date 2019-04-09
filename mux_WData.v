`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:22:15 12/06/2017 
// Design Name: 
// Module Name:    mux_WData 
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
module mux_WData(
    input [31:0] ALUResult,
    input [31:0] ReadData,
    input [31:0] PC,
    input [1:0] MemtoReg,
	 input [31:0] RD2,
	 input [31:0] Ext_num,
	 input ALUSrc,
	 output reg [31:0] SrcB,
    output reg [31:0] WData
    );
    always @(*) begin
	   case(MemtoReg)
		0: begin
		  WData <= ALUResult;
		end
		1: begin 
		  WData <= ReadData;
		end
		2: begin
		  WData <= PC+4;
		end
		default: begin
		  WData <= 0;
		end
		endcase
		case(ALUSrc) 
		0: begin
		  SrcB <= RD2;
		end
		1: begin
		  SrcB <= Ext_num;
		end
		endcase
	 end

endmodule
