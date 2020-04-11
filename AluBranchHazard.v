module AluBranchHazard(RegW_EX,RegW_WB,EX_rfWeSel,rfReSel1
,rfReSel2,WB_rfWeSel,ForwardA1,ForwardB1,Clk,Branch);
  input Clk;
  input Branch;
  input RegW_EX;
  input RegW_WB;
  input [4:0] EX_rfWeSel;
  input [4:0] rfReSel1;
  input [4:0] rfReSel2;
  input [4:0] WB_rfWeSel;
  
  output reg [1:0] ForwardA1;
  output reg [1:0] ForwardB1;
  
  
  always@(*)
  begin     
    
  if(Branch&&(RegW_WB)&&(WB_rfWeSel != 0)&&(WB_rfWeSel==rfReSel1))
    ForwardA1=2'b01;
  else
    ForwardA1=2'b00;
  if(Branch&&(RegW_WB)&&(WB_rfWeSel != 0)&&(WB_rfWeSel==rfReSel2))
    ForwardB1=2'b01;
  else
    ForwardB1=2'b00;
    
    
  if(Branch&&(RegW_EX)&&(EX_rfWeSel != 0)&&(EX_rfWeSel==rfReSel1))
    ForwardA1=2'b10;
  if(Branch&&(RegW_EX)&&(EX_rfWeSel != 0)&&(EX_rfWeSel==rfReSel2))
    ForwardB1=2'b10;


  

  end    
  
  
endmodule