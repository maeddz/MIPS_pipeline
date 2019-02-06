
module ControlUnit(input[5:0] Op_code, input hazard,output reg[3:0] _EXE_CMD,
                   output reg _mem_read,_mem_write,_WB_EN,is_immediate, checkbnest,
                   output reg[1:0] _BR_type);
  reg mem_read, mem_write, WB_EN;
  reg [1:0]BR_type;
  reg [3:0]EXE_CMD;
  always@(Op_code)begin
    WB_EN=0;is_immediate=0;
    mem_read=0;mem_write=0;checkbnest=0;
    BR_type=0;
    case(Op_code)
      0:begin EXE_CMD=4'bxxxx; end 
      1:begin EXE_CMD=4'b0; WB_EN=1'b1;end
      3:begin EXE_CMD=4'b0010;WB_EN=1'b1;end
      5:begin EXE_CMD=4'b0100;WB_EN=1'b1;end
      6:begin EXE_CMD=4'b0101;WB_EN=1'b1;end
      7:begin EXE_CMD=4'b0110;WB_EN=1'b1;end
      8:begin EXE_CMD=4'b0111;WB_EN=1'b1;end
      9:begin EXE_CMD=4'b1000;WB_EN=1'b1;end
      10:begin EXE_CMD=4'b1000;WB_EN=1'b1;end
      11:begin EXE_CMD=4'b1001;WB_EN=1'b1;end
      12:begin EXE_CMD=4'b1010;WB_EN=1'b1;end
      32:begin EXE_CMD=4'b0000;WB_EN=1'b1; is_immediate=1'b1;end
      33:begin EXE_CMD=4'b0010;WB_EN=1'b1; is_immediate=1'b1;end
      36:begin EXE_CMD=4'b0000;WB_EN=1'b1; mem_read=1'b1;is_immediate=1'b1;end
      37:begin EXE_CMD=4'b0000; mem_write=1'b1; is_immediate=1'b1;checkbnest=1; end
      40:begin EXE_CMD=4'bxxxx; BR_type=2'b01;is_immediate=1'b1;end
      41:begin EXE_CMD=4'bxxxx; BR_type=2'b10;is_immediate=1'b1;checkbnest=1;$display("dds");end
      42:begin EXE_CMD=4'bxxxx; BR_type=2'b11;is_immediate=1'b1;end
    endcase
    $display("%b op_code %b hazard", Op_code, hazard);
    
  end
  always@*begin
    if(hazard==1)begin
        _mem_read=0; _mem_write=0; _WB_EN=0;
        _BR_type=0;_EXE_CMD=0;
    end      
    else begin
        _mem_read=mem_read;_mem_write= mem_write;_WB_EN= WB_EN;
        _BR_type=BR_type;_EXE_CMD=EXE_CMD;
    end
    end
endmodule
    

