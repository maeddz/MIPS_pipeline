module condcheck(input[31:0] val1,src2_val,input[1:0] BR_type, output B_taken);
    reg tmp=0;
    assign B_taken=tmp;
    always@(*)begin
        tmp=0;
        case (BR_type)
                2'b00: tmp=1'b0;
                2'b01: tmp=((val1-src2_val)==32'b0)?1'b1:1'b0;
                2'b10: tmp=((val1-src2_val)==32'b0)?0:1;
                2'b11: tmp=1'b1;
        endcase
    end
endmodule

