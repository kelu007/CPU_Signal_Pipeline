module AluBranchHazardImp(ForwardA1,ForwardB1,rfDataOut1,aluDataOut_EX
,rfDataIn,rfDataOut2,DataInA1,DataInB1);
  input [1:0] ForwardA1;
  input [1:0] ForwardB1;


  input [31:0] rfDataOut1;
  input [31:0] aluDataOut_EX;
  input [31:0] rfDataIn;
  input [31:0] rfDataOut2;
  
  output reg [31:0] DataInA1;
  output reg [31:0] DataInB1;
  
    
  always@(*)
  begin
  case(ForwardA1)
    2'b00: DataInA1=rfDataOut1;
    2'b10: DataInA1=aluDataOut_EX;
    2'b01: DataInA1=rfDataIn;
    default:   ;
  endcase
  
  case(ForwardB1)
    2'b00: DataInB1=rfDataOut2;
    2'b10: DataInB1=aluDataOut_EX;
    2'b01: DataInB1=rfDataIn;
    default:   ;
  endcase
  end
    
  
endmodule