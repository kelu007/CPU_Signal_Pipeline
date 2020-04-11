module MEMWB(Mem2R_EX,RegW_EX,dmDataOut,aluDataOut_EX,EX_rfWeSel,Mem2R_WB,RegW_WB,dmDataOut_WB,aluDataOut_WB,WB_rfWeSel,Clk);
  										
	input  Mem2R_EX;						
	input  RegW_EX;
	input  [31:0] dmDataOut;					
	input  [31:0] aluDataOut_EX;
	input  [4:0] EX_rfWeSel;
	
	input Clk;
	
	output reg Mem2R_WB;
	output reg RegW_WB;
	output reg [31:0] dmDataOut_WB;
	output reg [31:0] aluDataOut_WB;
	output reg [4:0] WB_rfWeSel;
	
	always@(posedge Clk)
	begin
	Mem2R_WB=Mem2R_EX;
	RegW_WB=RegW_EX;
	dmDataOut_WB=dmDataOut;
	aluDataOut_WB=aluDataOut_EX;
	WB_rfWeSel=EX_rfWeSel;
	end
	
endmodule