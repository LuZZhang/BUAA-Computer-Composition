`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:53:18 12/05/2017 
// Design Name: 
// Module Name:    alu 
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
module alu(
    input [2:0] ALUctr,
    input [31:0] SrcA,
    input [31:0] SrcB,
	 input [1:0] j_zero,
    output reg zero,
    output reg [31:0] ALUResult
    );
	 
	 always @(*) begin
	    case(ALUctr)
		 0: begin
		 ALUResult = SrcA + SrcB;
		 end
		 1: begin
		 ALUResult = SrcA - SrcB;
		 end
		 2: begin
		 ALUResult = SrcA | SrcB;
		 end
		 3: begin//lui
		 ALUResult[31:16] = SrcB[15:0];
		 ALUResult[15:0] = 0;
		 end
		 4: begin
		 ALUResult = SrcA ^ SrcB;
		 end
		 default: begin
		 ALUResult = 0;
		 end
		 endcase//end case(ALUctr)
		 case(j_zero)
		 0: begin
		 zero = 1;
		 end
		 1: begin
		 if(SrcA==SrcB) zero = 1;
		 else zero = 0;
		 end
		 default: begin
		 zero = 0;
		 end
		 endcase//end case(j_zero)
	 end


endmodule
