module AluBranch(extDataOut,PC_IDIF,DataInA1,DataInB1,PC_ID,Zero1,AluctrlB);
  input [31:0] extDataOut;
  input [31:0] PC_IDIF;
  input [31:0] DataInA1;
  input [31:0] DataInB1;
  
  input AluctrlB;
  
  output  reg [31:0]  PC_ID;
  output  reg Zero1;
  
  reg  [31:0] AluBranchOut;
  reg  [31:0] extDataOut1;
  always@(*)
    begin
		//分支寻址
		extDataOut1=extDataOut<<2;
		PC_ID=PC_IDIF+extDataOut1;
			
		case(AluctrlB)
		  1:  AluBranchOut=DataInA1-DataInB1;
		  0:  AluBranchOut=!(DataInA1-DataInB1);
		default:   ;
		endcase
			  
		if(AluBranchOut == 0)
			Zero1 = 1;
		else
			Zero1 = 0;
    end
  
endmodule
      
