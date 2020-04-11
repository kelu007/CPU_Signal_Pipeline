
`include "ctrl_encode_def.v"
module Alu(C,Zero,PC_EX,A,B,ALUOp,shamt_ID,PC_IDEX,EX_extDataOut);

	input  [31:0] 		A;			//DataIn1;  运算数据1
	input  [31:0]		B;			//DataIn2;	运算数据2
	input  [4:0]		ALUOp;		//ALUCtrl;	运算器控制信号
	input  [4:0]   	    shamt_ID;	//偏移量
	input  [31:0]	    PC_IDEX;
	input  [31:0] 	    EX_extDataOut;

	
	output reg[31:0]	C;			//AluResult; 运算器输出结果
	output reg			Zero;		//结果是否为零
	output reg[31:0] 	PC_EX;
	
	reg [31:0] temp;
	reg [31:0] EX_extDataOut1;
	
	initial							//初始化数据
	begin
		Zero = 0;
		C = 0;
	end	
	
	integer i;	
	integer j;  
	
	always@(A or B or ALUOp)
		begin
		
			case ( ALUOp )
				`ALUOp_ADDU: C = A + B;
				`ALUOp_SUBU: C = A - B;
				`ALUOp_OR: C = A | B;
				`ALUOp_SLT: 
	            begin
					if(A[31] == 1 && B[31] == 0)
	                    C = 1;
	                else if(A[31] == 0 && B[31] == 1)
	                    C = 0;
	                else if(A[31] == 1 && B[31] == 1)
	                    C = (A > B)?1:0;
	                else C = (A < B)?1:0;
	            end
				`ALUOp_SLL: C = B << shamt_ID;
				`ALUOp_SRL: C = B >> shamt_ID;
				`ALUOp_BNE: C = !(A-B);
				`ALUOp_AND: C = A & B;
				`ALUOp_SRA:	
				begin
					temp = B >> shamt_ID;
					for(i=0; i<(32-shamt_ID); i=i+1)	//移位	
						C[i] = temp[i];
					for(j=0; j<shamt_ID; j=j+1)  //用符号位填充剩余位
					begin
					i = 32 - shamt_ID;
					C[i+j] = B[31]; 
					end
				end
				default:   ;
			endcase
     
			if(C == 0)
				Zero = 1;
			else
				Zero = 0;

			EX_extDataOut1 = EX_extDataOut << 2;
			PC_EX = PC_IDEX + EX_extDataOut1;
			
		end	
endmodule