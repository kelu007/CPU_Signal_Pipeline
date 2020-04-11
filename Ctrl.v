`include "ctrl_encode_def.v"
`include "instruction_def.v"

module Ctrl(jump,RegDst,Branch,MemR,Mem2R,MemW,RegW,Alusrc,ExtOp,Aluctrl,OpCode,funct,AluctrlB,jal,jr);
	
	input [5:0]		OpCode;					//指令操作码字码 				
	input [5:0]		funct;					//指令功能字段
	
	output reg jump;						//指令跳转
	output reg RegDst;						//写寄存器端口选择
	output reg Branch;						//分支
	output reg MemR;						//读存储器
	output reg Mem2R;						//数据存储器到寄存器堆
	output reg MemW;						//写数据存储器
	output reg RegW;						//寄存器堆写入数据
	output reg Alusrc;						//运算器操作数选择
	output reg[1:0]ExtOp;					//位扩展/符号扩展选择
	output reg[4:0] Aluctrl;				//Alu运算选择
	output reg AluctrlB;
	output reg      jal;					//jal指令
	output reg      jr;						//jr指令
	
	always @(OpCode or funct)
	 begin
	   case(OpCode)
	   
	   
	     `INSTR_RTYPE_OP:        //R type 000000
	     begin
	      //assign
	      Branch=0;
	      //assign 
	      Mem2R=0;
	      //assign 
	      MemW=1'b0;
	      //assign 
	      MemR=1'b0;
	      //assign 
	      Alusrc=0;
	      //assign 
	      ExtOp=`EXT_ZERO;
	      //assign 
	      RegDst=0;
	      //assign 
	      RegW=1'b1;
		  //assign 
		  jal = 0;
	      case(funct)
			`INSTR_ADD_FUNCT:
				begin
	              //assign 
	              Aluctrl=`ALUOp_ADDU;
				  jr = 0;
				  jump=0;
				end  
			`INSTR_SUB_FUNCT:
				begin
	              //assign 
	              Aluctrl=`ALUOp_SUBU;
				  jr = 0;
				  jump=0;
				end
			`INSTR_OR_FUNCT:
			    begin
	              //assign 
	              Aluctrl=`ALUOp_OR;  
				  jr = 0;
				  jump=0;
				end
			`INSTR_ADDU_FUNCT:
			    begin
			      //assign 
			      Aluctrl=`ALUOp_ADDU;
				  jr = 0;
				  jump=0;
				end
			`INSTR_SUBU_FUNCT:
			    begin
			      //assign 
			      Aluctrl=`ALUOp_SUBU;
				  jr = 0;
				  jump=0;
				end  
		    `INSTR_SLT_FUNCT:
			    begin
			      //assign 
			      Aluctrl=`ALUOp_SLT;
				  jr = 0;
				  jump=0;
				end  
			`INSTR_SLL_FUNCT:
			    begin
				  //assign 
				  Aluctrl=`ALUOp_SLL;
				  jr = 0;
				  jump=0;
				end  
			`INSTR_SRL_FUNCT:
			    begin
	              //assign 
	              Aluctrl=`ALUOp_SRL;
				  jr = 0;
				  jump=0;
				end  
			`INSTR_AND_FUNCT:  
                begin			
	              //assign 
	              Aluctrl=`ALUOp_AND;
				  jr = 0;
				  jump=0;
				end  
			`INSTR_SRA_FUNCT:
				begin
				  //assign
				  Aluctrl=`ALUOp_SRA;
				  jr = 0;
				  jump=0;
				end  
			`INSTR_JR_FUNCT:
				begin
				  //assign
				  Aluctrl=`ALUOp_NOP;	//x
				  jr = 1;
				  jump = 1;
				end
	      default: ;        
        endcase	    
	 end


		`INSTR_LUI_OP:		//lui
		begin
		  //assign 
		  Branch=0;
	      // assign 
	      jump=0;
	      //assign 
	      Mem2R=0;
	      //assign 
	      MemW=1'b0;
	      //assign 
	      MemR=1'b0;
	      //assign 
	      Alusrc=1;
	      //assign 
	      ExtOp=`EXT_HIGHPOS;
	      //assign 
	      RegDst=1;
	      //assign 
	      RegW=1'b1;
		  //assign 
		  Aluctrl = `ALUOp_ADDU;
		  //assign 
		  jal = 0;
		  jr = 0;
		end

		`INSTR_ORI_OP:		//ori
		begin
		  //assign 
		  Branch=0;
	      //assign 
	      jump=0;
	      //assign 
	      Mem2R=0;
	      //assign 
	      MemW=1'b0;
	      //assign 
	      MemR=1'b0;
	      //assign 
	      Alusrc=1;
	      //assign 
	      ExtOp=`EXT_ZERO;
	      //assign 
	      RegDst=1;
	      //assign 
	      RegW=1'b1;
		  //assign 
		  Aluctrl = `ALUOp_OR;
		   //assign 
		  jal = 0;
		  jr = 0;
		end
		
		`INSTR_SW_OP:		//sw  
		begin
		  //assign 
		  Branch=0;
	      //assign 
	      jump=0;
	      //assign 
	      Mem2R=0;
	      //assign 
	      MemW=1'b1;
	      //assign 
	      MemR=1'b0;
	      //assign 
	      Alusrc=1;
	      //assign 
	      ExtOp=`EXT_SIGNED;
	      //assign 
	      RegDst=1;
	      //assign 
	      RegW=1'b0;
		  //assign
		  Aluctrl =`ALUOp_ADDU;
		   //assign 
		  jal = 0;
		  jr = 0;
		end

		`INSTR_LW_OP:		//lw
		begin
		  //assign 
		  Branch=0;
	      //assign 
	      jump=0;
	      //assign 
	      Mem2R=1;
	      //assign 
	      MemW=1'b0;
	      //assign 
	      MemR=1'b1;
	      //assign 
	      Alusrc=1;
	      //assign 
	      ExtOp=`EXT_SIGNED;
	      //assign 
	      RegDst=1;
	      //assign 
	      RegW=1'b1;
		  //assign 
		  Aluctrl =`ALUOp_ADDU;
		   //assign 
		  jal = 0;
		  jr = 0;
		end

		`INSTR_BEQ_OP:		//beq
		begin        
		  //assign 
		  Branch=1;
	      //assign 
	      jump=0;
	      //assign 
	      Mem2R=0;
	      //assign 
	      MemW=1'b0;
	      //assign 
	      MemR=1'b0;
	      //assign 
	      Alusrc=0;
	      //assign 
	      ExtOp=`EXT_SIGNED;
	      //assign 
	      RegDst=0;
	      //assign 
	      RegW=1'b0;
		  //assign 
		  AluctrlB =1;
		   //assign 
		  jal = 0;
		  jr = 0;
		end
		
		`INSTR_J_OP:		//j
		begin        
		  //assign 
		  Branch=0;
	      //assign 
	      jump=1;
	      //assign 
	      Mem2R=0;
	      //assign 
	      MemW=1'b0;
	      //assign 
	      MemR=1'b0;
	      //assign 
	      Alusrc=0;
	      //assign 
	      ExtOp=`EXT_ZERO;
	      //assign 
	      RegDst=0;
	      //assign 
	      RegW=1'b0;
		  //assign 
		  Aluctrl =`ALUOp_NOP;
		   //assign 
		  jal = 0;
		  jr = 0;
		end 

    `INSTR_BNE_OP:			//bne
	     begin
	       //assign 
	       Branch = 1;
	       // assign 
	       jump = 0;
	       //assign 
	       Mem2R = 0;
	       //assign 
	       MemW = 1'b0;
	       //assign 
	       MemR = 1'b0;
	       //assign 
	       Alusrc = 0;
	       //assign 
	       ExtOp = `EXT_SIGNED;
	       //assign 
	       RegDst = 0;
	       //assign 
	       RegW = 1'b0;
	       //assign 
	       AluctrlB =0;
		    //assign 
		  jal = 0;
		  jr = 0;
	     end
    
    `INSTR_ADDI_OP:			//addi
	     begin
	       //assign 
	       Branch = 0;
	       //assign 
	       jump = 0;
	       //assign 
	       Mem2R = 0;
	       //assign 
	       MemW = 1'b0;
	       //assign 
	       MemR = 1'b0;
	       //assign 
	       Alusrc = 1;
	       // assign 
	       ExtOp = `EXT_SIGNED;
	       // assign 
	       RegDst = 1;
	       // assign 
	       RegW = 1'b1;
	       //assign 
	       Aluctrl = `ALUOp_ADDU;
		    //assign 
		  jal = 0;
		  jr = 0;
       end
	   
	`INSTR_SLTI_OP:			//slti
	     begin
	       //assign 
	       Branch = 0;
	       //assign 
	       jump = 0;
	       //assign 
	       Mem2R = 0;
	       //assign 
	       MemW = 1'b0;
	       //assign 
	       MemR = 1'b0;
	       //assign 
	       Alusrc = 1;
	       // assign 
	       ExtOp = `EXT_ZERO;
	       // assign 
	       RegDst = 1;
	       // assign 
	       RegW = 1'b1;
	       //assign 
	       Aluctrl = `ALUOp_SLT;
		    //assign 
		  jal = 0;
		  jr = 0;
        end
		
	`INSTR_JAL_OP:			//jal
	     begin
	       //assign 
	       Branch = 0;
	       //assign 
	       jump = 1;
	       //assign 
	       Mem2R = 0;
	       //assign 
	       MemW = 1'b0;
	       //assign 
	       MemR = 1'b0;
	       //assign 
	       Alusrc = 0;
	       // assign 
	       ExtOp = `EXT_ZERO;
	       // assign 
	       RegDst = 0;
	       // assign 
	       RegW = 1'b0;
	       //assign 
	       Aluctrl = `ALUOp_NOP;	//x
		    //assign 
		   jal = 1;
		   jr = 0;
        end
		
	  endcase
	end      
endmodule