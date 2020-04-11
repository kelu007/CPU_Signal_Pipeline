module Bubble(MemR_ID,EX_rfReSel2,rfReSel1,rfReSel2,Nop,rfWeSel,Branch,pcSel);
  input MemR_ID;
  input [4:0] EX_rfReSel2;
  input [4:0] rfReSel1;
  input [4:0] rfReSel2;
  
  input [4:0] rfWeSel;

  input Branch;
  input pcSel;
  
  output reg Nop;
  
  
  always@(*)
  begin     
    
  if((MemR_ID&&((EX_rfReSel2==rfReSel1)||(EX_rfReSel2==rfReSel2)))||
      ((!pcSel)&&Branch&&((rfReSel1==rfWeSel)||(rfReSel2==rfWeSel))))
    Nop=1;
  else
    Nop=0;
    
        
  end    
  
  
endmodule