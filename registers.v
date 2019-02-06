module registerIF(input clk, rst,freeze, flush, input [31:0]pcadderout, romout, output reg [31:0]ifpcout, ifromout);
    always@(posedge clk, posedge rst)begin
        if(rst)begin
            ifpcout<=0;
            ifromout<=0;
        end
        else if(flush)begin
            ifpcout<=0;
            ifromout<=0;
            end
        else if(freeze==0)begin
            ifpcout<=pcadderout;
            ifromout<=romout;
        end
    end
endmodule

module registerID(input clk, rst, Flush,MEM_R_EN_in, MEM_W_in, WB_EN_in,/*new*/is_st_br,
                        input[4:0]Dest_in, input [31:0]ifpcout, ifromout, Reg2_in, Reg1_in, Val2_in,
                        input[3:0]EXE_CMD_in ,input[1:0]Br_type_in, output reg[31:0] idpcout,Reg2,Val2,Reg1,//new
                        input[4:0]src1,src2
                        ,output reg[4:0]Dest, output reg  MEM_R_EN, MEM_W_EN, WB_in,
                        //new 
                        is_st_br_id,
                        output reg[1:0]Br_type, output reg[3:0]EXE_CMD,
                        //new
                        output reg[4:0]src1out,src2out,input freeze
                        );
    always@(posedge clk, posedge rst)begin
        if(rst)begin
            idpcout<=0;
        end
        else if(Flush)begin
            Dest<=0;
            idpcout<=0;
            is_st_br_id<=0;
            Reg2<=0;
            Val2<=0;
            Reg1<=0;
            Br_type<=0;
            MEM_R_EN<=0;
            MEM_W_EN<=0;
            WB_in<=0;
            EXE_CMD<=0;
            src1out<=0;
            src2out<=0;
        end
        else if(freeze==0)begin
            idpcout<=ifpcout;
            Br_type<=Br_type_in;
            MEM_R_EN<= MEM_R_EN_in;
            MEM_W_EN <=MEM_W_in;
            Dest <= Dest_in;
            WB_in <=  WB_EN_in;
            EXE_CMD <= EXE_CMD_in;
            Reg2<= Reg2_in;
            Val2 <= Val2_in;
            Reg1 <= Reg1_in;
            is_st_br_id<=is_st_br;
            src1out<=src1;
            src2out<=src2;
        end
    end
endmodule



module registerEXE(input clk, rst,WB_EN ,MEM_READ,MEM_WRITE, input [31:0] ALU_result,SRC2_val,input[4:0] DST
                  ,output reg WB_EN_exe,MEM_READ_exe,MEM_WRITE_exe,output reg[31:0] ALU_result_exe,SRC2_val_exe,
                  output reg[4:0] DST_exe,input freeze);
    always@(posedge clk, posedge rst)begin
        if(rst)begin
            WB_EN_exe<=1'b0;
            MEM_READ_exe<=1'b0;
            MEM_WRITE_exe<=1'b0;
            ALU_result_exe<=32'b0;
            SRC2_val_exe<=32'b0;
            DST_exe<=4'b0;
        end
        else if(freeze==0)begin
            WB_EN_exe<=WB_EN;
            MEM_READ_exe<=MEM_READ;
            MEM_WRITE_exe<=MEM_WRITE;
            ALU_result_exe<=ALU_result;
            SRC2_val_exe<=SRC2_val;
            DST_exe<=DST;
        end
    end
endmodule

module registerMEM(input clk, rst,WB_in,mem_readin,input[4:0] dest, input [31:0] alu, memoryin,
            						output reg[31:0]  aluout, memoryout,output reg mem_readout,WB_out, output reg[4:0]desout,input freeze );

    always@(posedge clk, posedge rst)begin
        if(rst)begin
				aluout<=0;
				WB_out<=0;
				desout<=0;
				mem_readout<=0;
				memoryout<=0;
		end
        else if(freeze==0)begin
            aluout<=alu;
				WB_out<=WB_in;
				desout<=dest;
				mem_readout<=mem_readin;
				memoryout<=memoryin;
        end
    end
endmodule

            
