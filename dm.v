
module dm_4k(dout,addr,din,DMWr,DMemR);
	input [4:0]  addr;		//DataAdr;
	input [31:0] din;		//DataIn;
	input 		 DMemR;
	input 		 DMWr;		//DMemW;
	//input      clk;
	
	output[31:0] dout;		//DataOut
	
	reg [31:0]   DMem[1023:0];
	
	integer i;	//数据存储器初始化
    initial 
	begin
       for (i=0; i<1024; i=i+1)
          DMem[i] = 0;
	end
	
	always@(*)
	begin
		if(DMWr)
			DMem[addr] <= din;
			   $display("addr=%8X",addr);   //addr to DM
         $display("din=%8X",din);   //din to DM
         $display("Mem[00-07]=%8X, %8X, %8X, %8X, %8X, %8X, %8X, %8X",DMem[0],DMem[1],DMem[2],DMem[3],DMem[4],DMem[5],DMem[6],DMem[7]);
		
	end
	
	assign dout = DMem[addr];
endmodule