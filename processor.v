module processor(input clk,rst, is_forward,
inout[15:0] SRAM_DQ,output ready,output SRAM_UB_N, SRAM_LB_N,SRAM_WB_N,SRAM_CE_N,SRAM_OE_N,

  output[17:0] SRAM_ADDR);
    wire[31:0] pcadderout,romout,
                ifpcout,ifromout,idpcout,idromout,
                exepcout,exeromout,mempcout,memromout,
                Reg2,Val2,Reg1,
                idReg2,idVal2,idReg1 ;
    wire IF_flush,Br_taken,MEM_R_EN, MEM_W_EN, WB_EN_out, ID_flush,idBr_taken,idMEM_R_EN, idMEM_W_EN, idwB_EN_out;
    wire[3:0] EXE_CMD, idEXECMD;
    wire[4:0] Dest, idDest;
    wire[1:0]BR_type;
    wire [31:0] aluresult,ALU_result_exe,SRC2_val_exe, BR_address;
    wire WB_EN_exe, MEM_READ_exe, MEM_WRITE_exe;
    wire [4:0] DST_exe;
    wire [1:0]idBr_type;
    wire [31:0]aluout, memReadData, memoryOutMEM;
    wire [4:0]desout;
    wire wbout, mem_read_out;
    wire [31:0]wb_out;
	  wire hazarddetection;
	  wire sram_freeze;
  /*IF*/
    wire tmpfreeze;
    assign tmpfreeze = hazarddetection | sram_freeze;
    IF _if(.clk(clk),.rst(rst),.freeze(tmpfreeze), .branch_taken(Br_taken), 
    .branchaddress(BR_address),.pcadderout(pcadderout),.romout(romout));
    
    registerIF _reg_if(.clk(clk), .rst(rst),.freeze(tmpfreeze),.flush(Br_taken), .pcadderout(pcadderout)
    ,.romout(romout),.ifpcout(ifpcout),.ifromout(ifromout));
    /*ID*/
    wire is_st_br, is_st_br_id;
    wire [4:0]tmp,tmp1,src1,src2;//new
    ID_stage _id_stage(.clk(clk),.rst(rst),.MEM_WB_EN(WB_EN_exe), .EXE_WB_EN(idwB_EN_out),.EXE_Dest(idDest), .MEM_Dest(DST_exe),.Instruction(ifromout), .Res_WB(wb_out),.WB_EN(wbout),.WB_Dest(desout),
                .MEM_R_EN(MEM_R_EN), .MEM_W_EN(MEM_W_EN), .WB_EN_out(WB_EN_out),
                .EXE_CMD(EXE_CMD),.is_st_br(is_st_br) ,.Dest(Dest),.src1out(tmp),.src2out(tmp1), .Reg2(Reg2),.Val2(Val2),.Reg1(Reg1), .BR_type(BR_type), .hazarddetection(hazarddetection),
                .mem__en(idMEM_R_EN), .is_forward(is_forward));//new
                     
    //signal is_st_br_id and is_st_br set for check st for forward unit function
    registerID _reg_id( .clk(clk), .is_st_br(is_st_br),.is_st_br_id(is_st_br_id),.rst(rst),
                       .Flush(Br_taken),.Br_type_in(BR_type),.MEM_R_EN_in(MEM_R_EN), .MEM_W_in(MEM_W_EN), .WB_EN_in(WB_EN_out),
                        .Dest_in(Dest),.ifpcout(ifpcout), .ifromout(ifromout), .Reg2_in(Reg2), .Reg1_in(Reg1), .Val2_in(Val2),
                    .EXE_CMD_in(EXE_CMD) ,  .idpcout(idpcout),.Reg2(idReg2),.Val2(idVal2),.Reg1(idReg1),//new
                    .src1(tmp),.src2(tmp1),.src1out(src1),.src2out(src2),
                    .Dest(idDest),  .Br_type(idBr_type), .MEM_R_EN(idMEM_R_EN), .MEM_W_EN(idMEM_W_EN),
                    .WB_in(idwB_EN_out), .EXE_CMD(idEXECMD),.freeze(sram_freeze));
    /*EXE*/
    wire [1:0] sel1,sel2,sel3;
    wire [31:0] bufreg2;
     EXE _exe(.Reg1(idReg1), .Reg2(idReg2), .Val2(idVal2), .PC(idpcout),.EXE_CMD(idEXECMD),
                    .BR_type(idBr_type),.ALU_result(aluresult), 
                     .BR_taken(Br_taken), .BR_address(BR_address)
                     /*new*/,.MemValue(ALU_result_exe),.WbValue(wb_out),.sel1(sel1),.sel2(sel2),.sel3(sel3),
                     .reg2out(bufreg2));
    //memory to exe:aluresult
    
    registerEXE _regexe(.clk(clk), .rst(rst),.WB_EN(idwB_EN_out) ,.MEM_READ(idMEM_R_EN),.MEM_WRITE(idMEM_W_EN), 
                             .ALU_result(aluresult),.SRC2_val(bufreg2), .DST(idDest),.WB_EN_exe(WB_EN_exe)
                             ,.MEM_READ_exe(MEM_READ_exe),.MEM_WRITE_exe(MEM_WRITE_exe),
                             .ALU_result_exe(ALU_result_exe),.SRC2_val_exe(SRC2_val_exe),.DST_exe(DST_exe)
                             ,.freeze(sram_freeze));
    /*MEM*/              
    
    MEM _memory( .write_data(SRC2_val_exe),.address(ALU_result_exe),
                .clk(clk),.rst(rst),.MemRead(MEM_READ_exe),.MemWrite(MEM_WRITE_exe),.read_data(memReadData),
                .SRAM_DQ(SRAM_DQ), 
                         .ready(ready),.SRAM_UB_N(SRAM_UB_N), .SRAM_LB_N(SRAM_LB_N),.SRAM_WB_N(SRAM_WB_N),
                       .SRAM_CE_N(SRAM_CE_N), .SRAM_OE_N(SRAM_OE_N), .SRAM_ADDR(SRAM_ADDR) , .sram_freeze(sram_freeze));
    
    
    registerMEM _reg_mem(.clk(clk), .rst(rst),.WB_in(WB_EN_exe),.mem_readin(MEM_READ_exe),.dest(DST_exe),
                        .alu(ALU_result_exe),.memoryin(memReadData),
                        .aluout(aluout),.memoryout(memoryOutMEM),.mem_readout(mem_read_out)
                        ,.WB_out(wbout),.desout(desout),.freeze(sram_freeze) );
                        
    
    MUX_32_1 _mux_wb(.mux0(aluout),.mux1(memoryOutMEM), .sel(mem_read_out),.muxout(wb_out));
    //new 
    
    forwardunit _forwardunit(.src1(src1),.src2(src2),.Dest_exe(idDest),.Dest_mem(DST_exe),
                .Dest_wb(desout),.wb_mem(WB_EN_exe),.wb_wb(wbout),.is_st_br(is_st_br_id),
                .sel1(sel1),.sel2(sel2),.sel3(sel3));
    
    
endmodule





module mapping(input [3:0]p, output reg[6:0]hex);
    always@(*)begin
        case (p)
            4'b0:hex=7'b1000000;
            4'b0001:hex=7'b1111001;
            4'b0010:hex=7'b0100100;
            4'b0011:hex=7'b0110000;
            4'b0100:hex=7'b0011001;
            4'b0101:hex=7'b0010010;
            4'b0110:hex=7'b0000010;
            4'b0111:hex=7'b1111000;
            4'b1000:hex=7'b0000000;
            4'b1001:hex=7'b0010000;
        default begin
            hex=7'b0111111;
        end
        endcase
    end
endmodule



