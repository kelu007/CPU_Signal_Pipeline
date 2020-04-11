
module IDEX(jump,RegDst,Branch,MemR,Mem2R,MemW,RegW,Alusrc,Aluctrl
,PC_IDIF,rfDataOut1,rfDataOut2,extDataOut,rfReSel1,rfReSel2,rfReSel3
,jump_ID,RegDst_ID,Branch_ID,MemR_ID,Mem2R_ID,MemW_ID,RegW_ID,Alusrc_ID,Aluctrl_ID
,PC_IDEX,DataIn1,EX_rfDataOut2,EX_extDataOut,EX_rfReSel1,EX_rfReSel2,EX_rfReSel3,Clk
,Nop,shamt,shamt_ID);
 	input  jump;						
 	input RegDst;						
	input Branch;						
	input MemR;					
	input Mem2R;						
	input MemW;
	input RegW;						
	input Alusrc;						
	//input reg[1:0]ExtOp;
	input  [4:0] Aluctrl;	     
	input  [31:0]PC_IDIF;     
	
	input  [31:0]rfDataOut1;     
	input  [31:0]rfDataOut2;
	input  [31:0]extDataOut;      //opCode[15:0] ?????? [31:0]
	input  [4:0] rfReSel1;
	input  [4:0] rfReSel2;       //opCode[20:16] rt
	input  [4:0] rfReSel3;       //opCode[15:11] rd
	input Clk;
	input Nop;
	input [4:0] shamt;
  	
	output reg jump_ID;						
 	output reg RegDst_ID;						
	output reg Branch_ID;						
	output reg MemR_ID;					
	output reg Mem2R_ID;						
	output reg MemW_ID;
	output reg RegW_ID;						
	output reg Alusrc_ID;						
	//output reg[1:0]ExtOp_ID;
	output reg[4:0] Aluctrl_ID; 	
	
	output reg [31:0]PC_IDEX;  
	
	output reg [31:0] DataIn1;       
	output reg [31:0] EX_rfDataOut2;
	output reg [31:0] EX_extDataOut;
	
	output reg [4:0] EX_rfReSel1;
	output reg [4:0] EX_rfReSel2;
  output reg [4:0] EX_rfReSel3;
  output reg [4:0] shamt_ID;
	
	
always@( posedge Clk)
  begin		
	jump_ID=jump;
	RegDst_ID=RegDst;
	Branch_ID=Branch;	
	MemR_ID=MemR;
	Mem2R_ID=Mem2R;	

	if(Nop==1)
  begin
    MemW_ID=0;
	  RegW_ID=0;
	end	
	else
	begin
	  MemW_ID=MemW;
	  RegW_ID=RegW;	
	end
	Alusrc_ID=Alusrc;					
//	ExtOp_ID=ExtOp;
	Aluctrl_ID=Aluctrl;
	
	PC_IDEX=PC_IDIF;
	
	DataIn1=rfDataOut1;
	EX_rfDataOut2=rfDataOut2;
	EX_extDataOut=extDataOut;
	
  EX_rfReSel1=rfReSel1;
	EX_rfReSel2=rfReSel2;
  EX_rfReSel3=rfReSel3;
 	shamt_ID=shamt;

	end
  
  
  
  /*
  	Ctrl U_Ctrl(.jump(jump),.RegDst(RegDst),.Branch(Branch),.MemR(MemR),.Mem2R(Mem2R)
				,.MemW(MemW),.RegW(RegW),.Alusrc(Alusrc),.ExtOp(ExtOp),.Aluctrl(Aluctrl)
				,.OpCode(op),.funct(funct));
 	output reg jump;						//指令跳转
	output reg RegDst;						
	output reg Branch;						//分支
	output reg MemR;						//读存储器
	output reg Mem2R;						//数据存储器到寄存器堆
	output reg MemW;						//写数据存储器
	output reg RegW;						//寄存器堆写入数据
	output reg Alusrc;						//运算器操作数选择
	output reg[1:0]ExtOp;						//位扩展符号扩展选择
	output reg[4:0] Aluctrl;						//Alu运算选择
*/
endmodule