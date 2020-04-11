
module IFID(PC,OpCode,rfReSel1,rfReSel2,rfReSel3,extDataIn,op,funct,PC_IDIF,Clk,jumpstr,Nop,IF_Flush,shamt,jalPC,jalPC_IDIF,jrPC,jrPC_IDIF);
  
  input [31:0]  PC;               // from PcUnit
  input [31:0]  jalPC;			  // from PcUnit
  input [31:0]  jrPC;			  // from PcUnit
  input [31:0]  OpCode;           // from IM
  
  input Clk;
  input Nop;
  input IF_Flush;
  
  output reg [31:0]  PC_IDIF;               // to IDEX
  output reg [31:0]  jalPC_IDIF;            // to IDEX
  output reg [31:0]  jrPC_IDIF;            // to IDEX
  
 	output reg [4:0] rfReSel1,rfReSel2,rfReSel3;    // to rf and IDEX
 	
 	output reg [15:0] extDataIn;        // to Extender
 	
 	output reg [5:0] op;                // to Ctrl
 	output reg [5:0] funct;
  output reg [25:0]jumpstr;
  output reg [4:0] shamt;
  reg [31:0] OpCode1;

 always@(posedge Clk)	
 begin
  if(Nop==1)
    begin
    PC_IDIF=PC_IDIF+0;
    OpCode1=OpCode1;
  end
  else
    begin
    OpCode1=OpCode;
    PC_IDIF = PC;
	jalPC_IDIF = jalPC;
	jrPC_IDIF = jrPC;
  end

    
	rfReSel1 = OpCode1[25:21];
	rfReSel2 = OpCode1[20:16];             
	rfReSel3 = OpCode1[15:11];
	extDataIn = OpCode1[15:0];
	shamt= OpCode1[10:6];
	
	op = OpCode1[31:26];
	funct = OpCode1[5:0];

//  PC_IDIF = PC;
  jumpstr = OpCode1[25:0];

  if(IF_Flush==1)
  begin
  OpCode1=32'b0;
	rfReSel1 = OpCode1[25:21];
	rfReSel2 = OpCode1[20:16];             
	rfReSel3 = OpCode1[15:11];
	extDataIn = OpCode1[15:0];
	shamt= OpCode1[10:6];
	
	op = OpCode1[31:26];
	funct = OpCode1[5:0];

//  PC_IDIF = PC;
  jumpstr = OpCode1[25:0];
  end
 end 
 
endmodule
 
  /*
  	rf U_rf(.DataOut1(rfDataOut1),.DataOut2(rfDataOut2),.clk(Clk),.WData(rfDataIn)
			  ,.WE(RegW),.WeSel(rfWeSel),.ReSel1(rfReSel1),.ReSel2(rfReSel2));
  	assign op = opCode[31:26];
	assign funct = opCode[5:0];
	assign rfReSel1 = opCode[25:21];
	assign rfReSel2 = opCode[20:16];
	assign shamt= opCode[10:6];
	assign jumpstr = opCode[25:0];
	assign rfWeSel = (RegDst==1)?opCode[20:16]:opCode[15:11];

	assign extDataIn = opCode[15:0];
	input   PcReSet;
	input   PcSel;
	input   Clk;
	input   jump;
	input   [25:0] jumpstr;
	input   [31:0] Adress;
	
	output reg[31:0] PC;
	
	integer i;
	reg [31:0] temp;
	always@(posedge Clk or posedge PcReSet)
	begin
		if(PcReSet == 1)
			PC <= 32'h0000_3000;
			
		PC = PC+4;
	  if(PcSel == 1)
				begin
					for(i=0;i<30;i=i+1)
						temp[31-i] = Adress[29-i];
					temp[0] = 0;
					temp[1] = 0;
					
					PC = PC+temp;
				end
		if(jump==1)
		  PC={{4{PC[31:28]}},{26{jumpstr[25:0]}},2'd0};		
	end
endmodule
*/