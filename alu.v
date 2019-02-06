module ALU(input[31:0] val1,val2,input[3:0] EXE_CMD,output reg[31:0] ALU_result);
    always@(*)begin
        case(EXE_CMD)
            4'b0000:ALU_result=val1+val2;
            4'b0010:ALU_result=val1-val2;
            4'b0100:ALU_result=val1&val2;
            4'b0101:ALU_result=val1|val2;
            4'b0110:ALU_result=~(val1|val2);
            4'b0111:ALU_result=val1^val2;
            4'b1000:ALU_result=val1<<val2;
            4'b1001:ALU_result=val1>>>val2;
            4'b1010:ALU_result=val1>>val2;
        endcase
    end
endmodule