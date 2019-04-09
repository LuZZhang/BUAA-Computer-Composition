`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:41:05 12/18/2017 
// Design Name: 
// Module Name:    RF 
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
module RF(
    input clk,
	 input reset,
	 input [31:0] IR_D,
	 input [31:0] WData,//WD3
	 input RegWrite,
	 input [31:0] PC8_W,//
	 input [4:0] A3_W,//Waddr
    output [31:0] RF_RD1,
    output [31:0] RF_RD2
    );
	 wire [4:0] A1,A2;
	 assign A1 = IR_D[25:21];
	 assign A2 = IR_D[20:16];
	 wire [31:0] WPC;
	 assign WPC = PC8_W - 8;
	 reg [31:0] registers [0:31];
	 //reg [4:0] Waddr;//A3
	 integer i=0;
	 //初始化
	 initial begin
	   for(i=0;i<=31;i=i+1) begin
	   registers[i] = 0;
	   end
	 end
	 //确定RD1,RD2的值
	 assign	RF_RD1 = (A1==0)?0: registers[A1];
	 assign	RF_RD2 = (A2==0)?0: registers[A2];
	 
	 always @(posedge clk) begin  //同步复位
	    if(reset) begin 
		   for(i=0;i<=31;i=i+1) begin 
	      registers[i] <= 0; 
	      end
	    end
	    else begin//复位信号无效时
			//开始存WData到A3里
			if(RegWrite) begin
			   if(A3_W!=0) begin
			   registers[A3_W] <= WData;
				//end
				//$display("$%d <= %h", A3_W,WData);
				$display("%d@%h: $%d <= %h", $time, WPC, A3_W,WData);
				end
			end
		 end //结束else（即复位信号无效时）
	 end //结束always

endmodule
