`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:03:11 12/18/2017 
// Design Name: 
// Module Name:    DM 
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
module DM(
    input clk,
	 input reset,
	 input MemWrite,
	 input [1:0] word_bit_M,
	 input load_u_M,
	 input [31:0] AO_M,
    input [31:0] WriteData,
	 input [31:0] PC8_M,
    output [31:0] ReadData
    );
	 wire [1:0] word_bit;
	 wire load_u;
	 assign word_bit = word_bit_M;
	 assign load_u = load_u_M;
	 reg [31:0] mem[0:4095];//dm
	 integer i;
	 wire [31:0] addr,pc;
	 reg [31:0] dmw;
	 assign pc = PC8_M - 8;
	 reg [31:0] din;//写入的数据
	 assign addr[12:2] = AO_M[12:2];
	 assign addr[31:13] = 0;
	 assign addr[1:0] = 0;
	 assign ReadData = mem[addr[12:2]];
	 initial begin//初始化
	   for(i=0;i<=4095;i=i+1) begin
			    mem[i] <= 0; 
		end
	 end
	 always @(posedge clk) begin
	    if(reset) begin //存储器清零
		    for(i=0;i<=4095;i=i+1) begin
			    mem[i] <= 0; 
			 end
		 end
		 else begin
		    if(MemWrite) begin
			    case(word_bit)
				    0: begin
					 //din = WriteData;
					 //mem[addr[12:2]] <= din;
					 mem[addr[12:2]] = WriteData;
					 din = WriteData;
					 //dmw=mem[addr[12:2]];
					 end//sw
					 1: begin
					 if(AO_M[1]) begin
					    din[15:0] = mem[addr[12:2]][15:0];
						 din[31:16] = WriteData[15:0];
						 mem[addr[12:2]] = din;
					 end
					 else begin
					    din[31:16] = mem[addr[12:2]][31:16];
						 din[15:0] = WriteData[15:0];
						 mem[addr[12:2]] = din;
					 end
					 end//sh
					 2: begin
					 case(AO_M[1:0])
					    0: begin
						 din[7:0] = WriteData[7:0];
						 din[31:8] = mem[addr[12:2]][31:8];
						 mem[addr[12:2]] = din;
						 end
						 1: begin
						 din[15:8] = WriteData[7:0];
						 din[31:16] = mem[addr[12:2]][31:16];
						 din[7:0] = mem[addr[12:2]][7:0];
						 mem[addr[12:2]] = din;
						 end
						 2: begin
						 din[23:16] =WriteData[7:0];
						 din[31:24] = mem[addr[12:2]][31:24];
						 din[16:0] = mem[addr[12:2]][16:0];
						 mem[addr[12:2]] = din;
						 end
						 3: begin
						 din[31:24] = WriteData[7:0];
						 din[23:0] = mem[addr[12:2]][23:0];
						 mem[addr[12:2]] = din;
						 end
					 endcase
					 end//2:end
				 endcase
			    //mem[addr] <= din;
				 //$display("*%h <= %h",addr,din);
				 $display("%d@%h: *%h <= %h", $time, pc, addr,din);
			 end//end if(MemWrite)
			 
		 end//end 置位清零无效
	 end//end always
    

endmodule
