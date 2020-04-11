module DataHazardImp(ForwardA,ForwardB,DataIn1,aluDataOut_EX
,rfDataIn,aluDataIn2,DataInA,DataInB,Alusrc_ID,DataInC);
  input [1:0] ForwardA;
  input [1:0] ForwardB;
  input Alusrc_ID;

  input [31:0] DataIn1;
  input [31:0] aluDataOut_EX;
  input [31:0] rfDataIn;
  input [31:0] aluDataIn2;
  
  output reg [31:0] DataInA;
  output reg [31:0] DataInB;
  
  output reg [31:0] DataInC;
    
  always@(*)
  begin
  case(ForwardA)
    2'b00: DataInA=DataIn1;
    2'b10: DataInA=aluDataOut_EX;
    2'b01: DataInA=rfDataIn;
    default:   ;
  endcase
  
  if((Alusrc_ID==1)&&(ForwardB!=0))
    begin
    DataInB=aluDataIn2;
    case(ForwardB)
    2'b10: DataInC=aluDataOut_EX;
    2'b01: DataInC=rfDataIn;
    default: ;
    endcase
    end 
  else
  begin
  case(ForwardB)
    2'b00: DataInB=aluDataIn2;
    2'b10: DataInB=aluDataOut_EX;
    2'b01: DataInB=rfDataIn;
    default:   ;
  endcase
  end
  end
    
  
endmodule