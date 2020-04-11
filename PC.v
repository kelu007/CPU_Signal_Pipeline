
module PC(PC,rst,PcSel,PC_ID,Clk,jumpstr,jump,Nop,PC_IDIF,jalPC,jrPC,jr);

	input  		 rst;		//PcReSet;	
	input   	 PcSel;
	input[31:0]  PC_ID;	
	input  		 Clk;
	input   	 jump;
	input   	 Nop;
	input[25:0]  jumpstr;
	input[31:0]  PC_IDIF;
	input [31:0] jrPC;				//jrPC跳转的地址
	input 	     jr;
	
	output reg[31:0] PC;
	output reg[31:0] jalPC;   		//jalPC跳转的地址
	
	
	reg [31:0] temp;
	
	always@(posedge Clk or posedge rst or posedge Nop)
	begin
		if(rst == 1)
			PC <= 32'h0000_3000;
		if(Nop==1)
			PC=PC+0;
		else
			begin
				PC = PC+4;
				if(PcSel == 1)
					PC=PC_ID+4;   	
				if(jump==1)
					PC={{4{PC[31:28]}},{26{jumpstr[25:0]}},2'b0};		
			end
		if(jr == 1)
			PC = jrPC;
			
		assign jalPC = PC ;
		
	end
endmodule
	
	