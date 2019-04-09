`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:50:32 12/05/2017 
// Design Name: 
// Module Name:    grf 
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
module grf(
    input clk,
    input [1:0] RegDst,
    input [4:0] A1,
    input [4:0] A2,
    input [4:0] ins15_11,
    input [31:0] WData,//WD3
    input RegWrite,
    input reset,
	 input [31:0] WPC,
    output [31:0] RD1,
    output [31:0] RD2
    );
    reg [31:0] registers [0:31];
	 reg [4:0] Waddr;//A3
	 integer i=0;
	 //初始化
	 initial begin
	   for(i=0;i<=31;i=i+1) begin
	   registers[i] = 0;
	   end
	 end
	 //确定RD1,RD2的值
	 assign	RD1 = (A1==0)?0: registers[A1];
	 assign	RD2 = (A2==0)?0: registers[A2];
	 always @(posedge clk) begin  //同步复位
	    if(reset) begin 
		   for(i=0;i<=31;i=i+1) begin 
	      registers[i] <= 0; 
	      end
	    end
	    else begin//复位信号无效时
	      //确定回写寄存器A3的位置,Waddr
			case(RegDst) 
			0:begin
			Waddr = A2;
			end
			1: begin
			Waddr = ins15_11;
			end
			2: begin
			Waddr = 5'b11111;
			end
			endcase
	      
			//开始存WD3到A3里
			if(RegWrite) begin
			   if(Waddr!=0) begin
			   registers[Waddr] <= WData;
				end
				$display("@%h: $%d <= %h", WPC, Waddr,WData);
			end
		 end //结束else（即复位信号无效时）
	 end //结束always
    
endmodule
