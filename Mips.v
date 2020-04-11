
module Mips();
	
   reg Clk, Reset;
  
   initial begin
      $readmemh( "Test_Pipeline.txt", U_im_4k.IMem ) ; 
      
      $monitor("PC = 0x%8X, IR = 0x%8X", U_PC.PC, opCode );        
      Clk = 1 ;
      Reset = 0 ;
      #5 Reset = 1 ;
      #20 Reset = 0 ;
   end
   
   always
	   #(50) Clk = ~Clk;
	   
	   
//PC	
	wire [31:0] pcOut;
	wire [31:0] jalPC;
	wire [31:0] jrPC;

//im	
	wire [5:0]  imAdr;
	wire [31:0] opCode;
	
	
//IFID
	wire [31:0] PC_IDIF;
	wire [31:0] jalPC_IDIF;
	wire [31:0] jrPC_IDIF;
	wire [4:0]  rfWeSel,rfReSel1,rfReSel2,rfReSel3;
	wire [15:0] extDataIn;
	wire [5:0]	op;
	wire [5:0]	funct;
	wire [25:0] jumpstr;
 	wire [4:0]  shamt; 

	
//IDEX
	wire [31:0] PC_IDEX;
	wire [31:0] PC_EX;
	wire  		jump_ID; 
	wire  		RegDst_ID;
	wire 		Branch_ID;
	wire 		MemR_ID; 
	wire  		Mem2R_ID;
	wire  		MemW_ID; 
	wire  		RegW_ID; 
	wire  		Alusrc_ID;
	//wire [1:0]  ExtOp_ID;						
	wire [4:0]  Aluctrl_ID;	
	
	wire [31:0] DataIn1;       
	wire [31:0] EX_rfDataOut2;
	wire [31:0] EX_extDataOut; 
            
	wire [4:0] EX_rfReSel1;                     
	wire [4:0] EX_rfReSel2;   
	wire [4:0] EX_rfReSel3;   
	wire [4:0] shamt_ID;


//EXMEM
//  wire  jump_EX; 
	wire  Branch_EX;
	wire  MemR_EX; 
	wire  Mem2R_EX;
	wire  MemW_EX; 
	wire  RegW_EX; 

	wire [31:0] PC_EXMEM;
	wire  		zero;	
	wire [31:0] aluDataOut_EX;       
	wire [31:0] MEM_rfDataOut2; 
                       
	wire [4:0]  EX_rfWeSel;  
	wire [31:0] DataInD; 
	
	
//RF
	//wire [4:0] rfWeSel,rfReSel1,rfReSel2,rfResel3;
	wire [31:0] rfDataIn;
	wire [31:0] rfDataOut1,rfDataOut2;
	
	
	
//EXT
	//wire [15:0] extDataIn;
	wire [31:0] extDataOut;
	
	
//dm
	wire [4:0]  dmDataAdr;
	wire [31:0] dmDataOut;
	
	
//Ctrl
	//wire [5:0]		op;
	//wire [5:0]		funct;
	wire 		jump;						//指令跳转
	wire 		RegDst;						
	wire 		Branch;						//分支
	wire 		MemR;						//读存储器
	wire 		Mem2R;						//数据存储器到寄存器堆
	wire 		MemW;						//写数据存储器
	wire 		RegW;						//寄存器堆写入数据
	wire		Alusrc;						//运算器操作数选择
	wire [1:0]  ExtOp;						//位扩展/符号扩展选择
	wire [4:0]  Aluctrl;					//Alu运算选择
	wire   		AluctrlB;
	wire 		jal;
	wire		jr;	

//Alu
	wire [31:0] aluDataIn2;
	wire [31:0]	aluDataOut;
//	wire [4:0]  shamt; 
	wire 		Zero;


//MEMWB
	wire   Mem2R_WB;
	wire   RegW_WB;
	wire [31:0] dmDataOut_WB;
	wire [31:0] aluDataOut_WB;
	wire [4:0]  WB_rfWeSel;
	
	
//DataHazard
	wire [1:0] ForwardA;
	wire [1:0] ForwardB;
  
  
//DataHazardImp
	wire  [31:0]  DataInA;
	wire  [31:0]  DataInB;
	wire  [31:0]  DataInC; 
  
  
//Bubble
	wire Nop;
  
  
//AluBranch
	wire  [31:0]  PC_ID;
 	wire 		  Zero1;
 	wire  		  IF_Flush;
 	
	
//AluBranchHazard 	
	wire  [1:0]	 	ForwardA1;
	wire  [1:0] 	ForwardB1;
  
  
//AluBranchHazardImp
	wire  [31:0]  DataInA1;  
	wire  [31:0]  DataInB1;
	
	
//	assign pcSel = ((Branch&&zero)==1)?1:0;
	
	
//PC块实例化	
    PC U_PC(.PC(pcOut),.rst(Reset),.PcSel(pcSel),.PC_ID(PC_ID)
                    ,.Clk(Clk),.jumpstr(jumpstr),.jump(jump),.Nop(Nop),.PC_IDIF(PC_IDIF),.jalPC(jalPC),.jrPC(jrPC),.jr(jr));
	
	assign imAdr = pcOut[7:2];
	
	
//指令寄存器实例化	
	im_4k U_im_4k(.OpCode(opCode),.ImAdress(imAdr));
	
	//assign op = opCode[31:26];
	//assign funct = opCode[5:0];
	//assign rfReSel1 = opCode[25:21];
	//assign rfReSel2 = opCode[20:16];
//	assign shamt= opCode[10:6];
//	assign jumpstr= jumpstr1;
	//assign jumpstr= EX_extDataOut[25:0];
//	assign jumpstr = opCode[25:0];
//	assign rfWeSel = (RegDst==1)?EX_rfResel2:EX_rfResel3;
	//assign rfWeSel = (RegDst==1)?opCode[20:16]:opCode[15:11];

	//assign extDataIn = opCode[15:0];
	
	
  
//Bubble
	Bubble U_Bubble(.MemR_ID(MemR_ID),.EX_rfReSel2(EX_rfReSel2),.rfReSel1(rfReSel1)
  ,.rfReSel2(rfReSel2),.Nop(Nop),.rfWeSel(rfWeSel),.Branch(Branch),.pcSel(pcSel));
  	
	
//IFID
	IFID U_IFID(.PC(pcOut),.OpCode(opCode),.rfReSel1(rfReSel1),.rfReSel2(rfReSel2)
  ,.rfReSel3(rfReSel3),.extDataIn(extDataIn),.op(op),.funct(funct),.PC_IDIF(PC_IDIF),.Clk(Clk)
  ,.jumpstr(jumpstr),.Nop(Nop),.IF_Flush(IF_Flush),.shamt(shamt),.jalPC(jalPC),.jalPC_IDIF(jalPC_IDIF)
  ,.jrPC(jrPC),.jrPC_IDIF(jrPC_IDIF));
  


  
//寄存器堆实例化
	RF U_rf(.RD1(rfDataOut1),.RD2(rfDataOut2),.WD(rfDataIn)
			  ,.RFWr(RegW_WB),.A1(WB_rfWeSel),.A2(rfReSel1),.A3(rfReSel2)
			  ,.jalPC_IDIF(jalPC_IDIF),.jal(jal),.jrPC(jrPC),.jr(jr));


//控制器实例化	
	Ctrl U_Ctrl(.jump(jump),.RegDst(RegDst),.Branch(Branch),.MemR(MemR),.Mem2R(Mem2R)
				,.MemW(MemW),.RegW(RegW),.Alusrc(Alusrc),.ExtOp(ExtOp),.Aluctrl(Aluctrl)
				,.OpCode(op),.funct(funct),.AluctrlB(AluctrlB),.jal(jal),.jr(jr));
	
	
//扩展器实例化	
	EXT U_extend(.Imm32(extDataOut),.Imm16(extDataIn),.ExtOp(ExtOp));
	//assign jumpstr= extDataOut[25:0];


//AluBranchHazard
	AluBranchHazard  U_AluBranchHazard(.RegW_EX(RegW_EX),.RegW_WB(RegW_WB),.EX_rfWeSel(EX_rfWeSel),.rfReSel1(rfReSel1)
                  ,.rfReSel2(rfReSel2),.WB_rfWeSel(WB_rfWeSel)
                  ,.ForwardA1(ForwardA1),.ForwardB1(ForwardB1),.Clk(Clk),.Branch(Branch));
	
	
//AluBranchHazardImp
	AluBranchHazardImp U_AluBranchHazardImp(.ForwardA1(ForwardA1),.ForwardB1(ForwardB1),.rfDataOut1(rfDataOut1)
                                  ,.aluDataOut_EX(aluDataOut_EX),.rfDataIn(rfDataIn)
                                  ,.rfDataOut2(rfDataOut2),.DataInA1(DataInA1),.DataInB1(DataInB1));


//AluBranch
	AluBranch U_AluBranch(.extDataOut(extDataOut),.PC_IDIF(PC_IDIF),.DataInA1(DataInA1)
                        ,.DataInB1(DataInB1),.PC_ID(PC_ID),.Zero1(Zero1),.AluctrlB(AluctrlB));
  
	assign pcSel = ((Branch&&Zero1)==1)?1:0;
	assign IF_Flush = (pcSel||jump);
	
	//assign aluDataIn2 = (Alusrc==1)?EX_extDataOut:EX_rfDataOut2;
	
	
//IDEX
	IDEX U_IDEX(.jump(jump),.RegDst(RegDst),.Branch(Branch),.MemR(MemR),.Mem2R(Mem2R)
				,.MemW(MemW),.RegW(RegW),.Alusrc(Alusrc),.Aluctrl(Aluctrl)
				,.PC_IDIF(PC_IDIF),.rfDataOut1(rfDataOut1),.rfDataOut2(rfDataOut2)
				,.extDataOut(extDataOut),.rfReSel1(rfReSel1),.rfReSel2(rfReSel2),.rfReSel3(rfReSel3)
				,.jump_ID(jump_ID),.RegDst_ID(RegDst_ID),.Branch_ID(Branch_ID)
				,.MemR_ID(MemR_ID),.Mem2R_ID(Mem2R_ID),.MemW_ID(MemW_ID),.RegW_ID(RegW_ID)
				,.Alusrc_ID(Alusrc_ID),.Aluctrl_ID(Aluctrl_ID)
				,.PC_IDEX(PC_IDEX),.DataIn1(DataIn1),.EX_rfDataOut2(EX_rfDataOut2)
				,.EX_extDataOut(EX_extDataOut),.EX_rfReSel1(EX_rfReSel1),.EX_rfReSel2(EX_rfReSel2)
				,.EX_rfReSel3(EX_rfReSel3),.Clk(Clk),.Nop(Nop),.shamt(shamt),.shamt_ID(shamt_ID));

	assign aluDataIn2 = (Alusrc_ID==1)?EX_extDataOut:EX_rfDataOut2;	
	assign rfWeSel = (RegDst_ID==1)?EX_rfReSel2:EX_rfReSel3;


//ALU实例化	
	Alu U_Alu(.C(aluDataOut),.Zero(Zero),.PC_EX(PC_EX),.A(DataInA),.B(DataInB)
            ,.ALUOp(Aluctrl_ID),.shamt_ID(shamt_ID),.PC_IDEX(PC_IDEX),.EX_extDataOut(EX_extDataOut));
	

//	assign rfDataIn = (Mem2R==1)?dmDataOut:aluDataOut;


//EXMEM
	EXMEM U_EMMEM(.Branch_ID(Branch_ID),.MemR_ID(MemR_ID),.Mem2R_ID(Mem2R_ID)
                ,.MemW_ID(MemW_ID),.RegW_ID(RegW_ID),.PC_EX(PC_EX)
                ,.Zero(Zero),.aluDataOut(aluDataOut)
                ,.DataInD(DataInD),.rfWeSel(rfWeSel)
                ,.Branch_EX(Branch_EX),.MemR_EX(MemR_EX),.Mem2R_EX(Mem2R_EX)
                ,.MemW_EX(MemW_EX),.RegW_EX(RegW_EX),.PC_EXMEM(PC_EXMEM),.zero(zero),.aluDataOut_EX(aluDataOut_EX)
                ,.MEM_rfDataOut2(MEM_rfDataOut2),.EX_rfWeSel(EX_rfWeSel),.Clk(Clk));
                
//  assign pcSel = ((Branch_EX&&zero)==1)?1:0;


//DM实例化

	assign dmDataAdr = aluDataOut_EX[6:2];
	dm_4k U_dm_4k(.dout(dmDataOut),.addr(dmDataAdr)
	,.din(MEM_rfDataOut2),.DMWr(MemW_EX),.DMemR(MemR_EX));
	
	
//WB
	MEMWB U_MEMWB(.Mem2R_EX(Mem2R_EX),.RegW_EX(RegW_EX)
  ,.dmDataOut(dmDataOut),.aluDataOut_EX(aluDataOut_EX)
  ,.EX_rfWeSel(EX_rfWeSel),.Mem2R_WB(Mem2R_WB)
  ,.RegW_WB(RegW_WB),.dmDataOut_WB(dmDataOut_WB)
  ,.aluDataOut_WB(aluDataOut_WB)
  ,.WB_rfWeSel(WB_rfWeSel),.Clk(Clk));

	assign rfDataIn = (Mem2R_WB==1)?dmDataOut_WB:aluDataOut_WB;	
 
 
//DataHazard  
	DataHazard U_DataHazard(.RegW_EX(RegW_EX),.RegW_WB(RegW_WB),.EX_rfWeSel(EX_rfWeSel)
                    ,.EX_rfReSel1(EX_rfReSel1),.EX_rfReSel2(EX_rfReSel2)
                    ,.WB_rfWeSel(WB_rfWeSel),.ForwardA(ForwardA)
                    ,.ForwardB(ForwardB),.Clk(Clk),.Alusrc_ID(Alusrc_ID));


//DataHazardImp
	DataHazardImp U_DataHazardImp(.ForwardA(ForwardA),.ForwardB(ForwardB)
                          ,.DataIn1(DataIn1),.aluDataOut_EX(aluDataOut_EX)
                          ,.rfDataIn(rfDataIn),.aluDataIn2(aluDataIn2)
                          ,.DataInA(DataInA),.DataInB(DataInB)
                          ,.Alusrc_ID(Alusrc_ID),.DataInC(DataInC));
	assign DataInD= (((Alusrc_ID==1)&&(ForwardB!=0))==1)? DataInC:DataInB ;
	
  
endmodule