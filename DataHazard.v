module DataHazard(RegW_EX,RegW_WB,EX_rfWeSel,EX_rfReSel1
,EX_rfReSel2,WB_rfWeSel,ForwardA,ForwardB,Clk,Alusrc_ID);
  input Clk;
  input Alusrc_ID;
  input RegW_EX;
  input RegW_WB;
  input [4:0] EX_rfWeSel;
  input [4:0] EX_rfReSel1;
  input [4:0] EX_rfReSel2;
  input [4:0] WB_rfWeSel;
  
  output reg [1:0] ForwardA;
  output reg [1:0] ForwardB;
  
  
  always@(*)
  begin     
    
  if((RegW_WB)&&(WB_rfWeSel != 0)&&(WB_rfWeSel==EX_rfReSel1))
    ForwardA=2'b01;
  else
    ForwardA=2'b00;
  if((RegW_WB)&&(WB_rfWeSel != 0)&&(WB_rfWeSel==EX_rfReSel2))
    ForwardB=2'b01;
  else
    ForwardB=2'b00;
    
    
  if((RegW_EX)&&(EX_rfWeSel != 0)&&(EX_rfWeSel==EX_rfReSel1))
    ForwardA=2'b10;
  if((RegW_EX)&&(EX_rfWeSel != 0)&&(EX_rfWeSel==EX_rfReSel2))
              ForwardB=2'b10;


  

  end    
  
  
endmodule