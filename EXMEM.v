module EXMEM(Branch_ID,MemR_ID,Mem2R_ID,MemW_ID,RegW_ID,PC_EX
              ,Zero,aluDataOut,DataInD,rfWeSel
              ,Branch_EX,MemR_EX,Mem2R_EX,MemW_EX
              ,RegW_EX,PC_EXMEM,zero,aluDataOut_EX
              ,MEM_rfDataOut2,EX_rfWeSel,Clk);
 //	input reg jump_ID;						
 //	input reg RegDst;						
	input  Branch_ID;						
	input  MemR_ID;					
	input  Mem2R_ID;						
	input  MemW_ID;
	input  RegW_ID;						
//	input reg Alusrc;						
//	input reg[1:0]ExtOp;
//	input reg[4:0] Aluctrl;	    
	
	input [31:0]PC_EX;     
	
	input  Zero; 
	input  [31:0] aluDataOut;          
//	input  [31:0] EX_rfDataOut2;      
	input  [31:0] DataInD;
	input  [4:0] rfWeSel;       //opCode[20:16] rt  or opCode[15:11] rd ?

  input Clk;
  
	
  	
//	output reg jump_EX;						
// 	output reg RegDst_EX;						
	output reg Branch_EX;						
	output reg MemR_EX;					
	output reg Mem2R_EX;						
	output reg MemW_EX;
	output reg RegW_EX;						
//	output reg Alusrc_ID;						
//	output reg[1:0]ExtOp_ID;
//	output reg[4:0] Aluctrl_ID;  
	
	output reg [31:0]PC_EXMEM;  
	
	output reg zero;   
	output reg [31:0] aluDataOut_EX;       
	output reg [31:0] MEM_rfDataOut2;
	output reg [4:0] EX_rfWeSel;
	
	
	always@(posedge Clk)
	begin
//	jump_EX=jump_ID;
//	RegDst_ID=RegDst_ID;
	Branch_EX=Branch_ID;	
	MemR_EX=MemR_ID;
	Mem2R_EX=Mem2R_ID;	
	MemW_EX=MemW_ID;
	RegW_EX=RegW_ID;	
//	Alusrc_EX=Alusrc_ID;					
//	ExtOp_ID=ExtOp;
//	Aluctrl_ID=Aluctrl;
	
	PC_EXMEM=PC_EX;
	
	zero=Zero;
	aluDataOut_EX=aluDataOut;
	//MEM_rfDataOut2=EX_rfDataOut2;
	MEM_rfDataOut2=DataInD;
	EX_rfWeSel=rfWeSel;
  end
	
	
	endmodule