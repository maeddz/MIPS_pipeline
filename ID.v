
module ID_stage(input clk,rst, MEM_WB_EN,EXE_WB_EN,input [4:0] EXE_Dest, MEM_Dest ,input[31:0] Instruction, Res_WB,input WB_EN, input [4:0]WB_Dest,
                  input is_forward,/*new*/mem__en,
                output  MEM_R_EN, MEM_W_EN, WB_EN_out,
                output[3:0] EXE_CMD, output[4:0] Dest,/*new*/src1out,src2out/*new*/,output[31:0] Reg2,Val2,Reg1, output[1:0]BR_type,
                 output hazarddetection, output is_st_br);
    wire is_immediate, checkbnest, haz;
    wire[31:0] extend_out;
    assign src1out=Instruction[25:21];
    assign src2out = (is_immediate)?0:Instruction [20:16];
    hazard hzrd(.src1(Instruction[25:21]), .src2(Instruction[20:16]), .exe_dest(EXE_Dest),.mem_dest(MEM_Dest)
               ,.exe_wb_en(EXE_WB_EN) , .mem_wb_en(MEM_WB_EN),.mem_r_en(mem__en), .is_im(is_immediate),.check(checkbnest),
               .hazarddetection(hazarddetection),.is_forward(is_forward));
    
    MUX_32_1 n1(.mux0(Reg2),.mux1(extend_out), .sel(is_immediate), .muxout(Val2));

    MUX_5_1 n2(.mux0(Instruction[15:11]),.mux1(Instruction[20:16]),.sel(is_immediate), .muxout(Dest));
    ControlUnit n3(.Op_code(Instruction[31:26]),.hazard(hazarddetection), ._EXE_CMD(EXE_CMD),
                    ._mem_read(MEM_R_EN),._mem_write(MEM_W_EN),._WB_EN(WB_EN_out),.is_immediate(is_immediate),
                    .checkbnest(checkbnest),
                    ._BR_type(BR_type));
                         
    RegisterFile n4(.clk(clk), .rst(rst), .src1(Instruction[25:21]), .src2(Instruction[20:16]), .dest(WB_Dest), 
                            .Write_Val(Res_WB)/*abi*/, .Write_En(WB_EN)/*abi*/, 
                            .reg1(Reg1), .reg2(Reg2));
                            
    signextend n5(.extend_in(Instruction[15:0]),.extend_out(extend_out));


    assign is_st_br = checkbnest;
endmodule


module signextend(input [15:0] extend_in,output [31:0] extend_out);
  assign extend_out=extend_in[15]?
                                  {16'b1111111111111111,extend_in}:
                                  {16'b0,extend_in};
endmodule


                                  

