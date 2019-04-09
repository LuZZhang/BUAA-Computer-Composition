`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:44:23 12/18/2017 
// Design Name: 
// Module Name:    ALU 
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
module ALU(
    input [31:0] IR_E,
    //input [31:0] E32_E,
    //input [31:0] RT_E,
	 input [31:0] MFALUa,
	 input [31:0] ALUb,
	 input [2:0] ALUctr,//
	 input ALUsrc,//
    output reg[31:0] AO
    );
	 wire [4:0] s;
	 assign s = IR_E[10:6];
    always @* begin
	   case(ALUctr) 
		   0: begin
			AO <= MFALUa + ALUb;
			end
			1: begin
			AO <= MFALUa - ALUb;
			end
			2: begin//ori
			AO <= MFALUa | ALUb;
			end
			3: begin//lui
			AO[31:16] <= ALUb[15:0];
			AO[15:0] <= 0;
			end
			4: begin//xori
			AO <= MFALUa ^ ALUb;
			end
			5: begin//sll
			AO <= ALUb << s;
			end
			6: begin//slt
			if($signed(MFALUa) < $signed(ALUb)) AO <= 1;
			else AO <= 0;
			end
			7: begin//and
			AO <= MFALUa & ALUb;
			end
		endcase
	 end

endmodule
