`include "ctrl_encode_def.v"
module EXT(Imm32,Imm16,ExtOp);

	input [15:0] 	 Imm16;			//DataIn;
	input [1:0] 	 ExtOp;
	output reg[31:0] Imm32;			//ExtOut;
	
	integer i;					//逻辑计数
	
	always@(Imm16 or ExtOp)
	begin
		 case (ExtOp)
			`EXT_ZERO:    Imm32 = {16'd0, Imm16};
			`EXT_SIGNED:  Imm32 = {{16{Imm16[15]}}, Imm16};
			`EXT_HIGHPOS: Imm32 = {Imm16, 16'd0};
			default: ;
		 endcase
	end
	
endmodule