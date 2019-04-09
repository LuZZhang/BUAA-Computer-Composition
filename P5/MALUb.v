`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:29:41 12/19/2017 
// Design Name: 
// Module Name:    MALUb 
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
module MALUb(
    input [31:0] MFALUb,
    input [31:0] E32_E,
    input ALUsrc,
    output reg[31:0] ALUb
    );
	 always @* begin
	 if(ALUsrc) ALUb = E32_E;
	 else ALUb = MFALUb;
	 end


endmodule
