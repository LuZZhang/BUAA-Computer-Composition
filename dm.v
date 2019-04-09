`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:19:05 12/05/2017 
// Design Name: 
// Module Name:    dm 
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
module dm(
    input MemWrite,
    input [31:0] ALUResult,
    input [31:0] WriteData,
    input reset,
    input [1:0] word_bit,
    input load_u,
    input clk,
	 input [31:0] pc,
    output reg [31:0] ReadData
    );
    reg [31:0] mem[0:1023];//初始化？
	 wire [31:0] addr;
	 reg [31:0] din;//真正写入数据
	 integer i;
	 assign addr[11:2] = ALUResult[11:2];
	 assign addr[31:12] = 0;
	 assign addr[1:0] = 0;
	 //assign ReadData = mem[addr[6:2]];
	 always @(posedge clk) begin
	    if(reset) begin //寄存器清零
		    for(i=0;i<=1023;i=i+1) begin
			    mem[i] <= 0; 
			 end
		 end
		 else begin
		    if(MemWrite) begin
			    case(word_bit)
				    0: begin
					 din = WriteData;
					 mem[addr[11:2]] <= din;
					 end//sw
					 1: begin
					 if(ALUResult[1]) begin
					    din[15:0] = mem[addr[6:2]][15:0];
						 din[31:16] = WriteData[15:0];
						 mem[addr[11:2]] <= din;
					 end
					 else begin
					    din[31:16] = mem[addr[11:2]][31:16];
						 din[15:0] = WriteData[15:0];
						 mem[addr[11:2]] <= din;
					 end
					 end//sh
					 2: begin
					 case(ALUResult[1:0])
					    0: begin
						 din[7:0] = WriteData[7:0];
						 din[31:8] = mem[addr[11:2]][31:8];
						 mem[addr[11:2]] <= din;
						 end
						 1: begin
						 din[15:8] = WriteData[7:0];
						 din[31:16] = mem[addr[11:2]][31:16];
						 din[7:0] = mem[addr[11:2]][7:0];
						 mem[addr[11:2]] <= din;
						 end
						 2: begin
						 din[23:16] = WriteData[7:0];
						 din[31:24] = mem[addr[11:2]][31:24];
						 din[16:0] = mem[addr[11:2]][16:0];
						 mem[addr[11:2]] <= din;
						 end
						 3: begin
						 din[31:24] = WriteData[7:0];
						 din[23:0] = mem[addr[11:2]][23:0];
						 mem[addr[11:2]] <= din;
						 end
					 endcase
					 end//2:end
				 endcase
			    //mem[addr] <= din;
				 $display("@%h: *%h <= %h",pc, addr,din);
			 end//end if(MemWrite)
			 
		 end//end 置位清零无效
	 end//end always
    always @(*) begin
	   // 开始load
			 case(word_bit)
			 0: begin
			 ReadData = mem[addr[11:2]];
			 end//lw
			 1: begin
			  case(ALUResult[1]) 
			  0: begin
			   if(load_u) begin
				  ReadData[15:0] = mem[addr[11:2]][15:0];
				  ReadData[31:16] = 0;
				end
				else begin
				  ReadData[15:0] = mem[addr[11:2]][15:0];
				  ReadData[31:16] = {16{ReadData[15]}};
				end
			  end
			  1: begin
			   if(load_u) begin
				  ReadData[15:0] = mem[addr[11:2]][31:16];
				  ReadData[31:16] = 0;
				end
				else begin
				  ReadData[15:0] = mem[addr[11:2]][31:16];
				  ReadData[31:16] = {16{ReadData[15]}};
				end
			  end
			  endcase
			  end
			 2: begin
			    case(ALUResult[1:0]) 
				  0: begin
				   ReadData[7:0] = mem[addr[11:2]][7:0];
					if(load_u)  ReadData[31:8] = 0;//无符号
					else ReadData[31:8] = {24{ReadData[7]}};
			     end
				  1: begin
				   ReadData[7:0] = mem[addr[11:2]][15:8];
					if(load_u)  ReadData[31:8] = 0;//无符号
					else ReadData[31:8] = {24{ReadData[7]}};
				  end
				  2: begin
				   ReadData[7:0] = mem[addr[11:2]][23:16];
					if(load_u)  ReadData[31:8] = 0;//无符号
					else ReadData[31:8] ={24{ReadData[7]}};
				  end
				  3: begin
				   ReadData[7:0] = mem[addr[11:2]][31:24];
					if(load_u)  ReadData[31:8] = 0;//无符号
					else ReadData[31:8] = {24{ReadData[7]}};
				  end
				 endcase
			  end
			 //end//lb(u)
			 endcase
	 end
endmodule
