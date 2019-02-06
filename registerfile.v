
module RegisterFile(input clk, input rst, input [4:0]src1, src2, dest, 
                            input [31:0]Write_Val, input Write_En, 
                            output [31:0]reg1, output [31:0]reg2);
    reg [31:0]regfile[31:0];
    integer i;

    always@(negedge clk)begin
        if(rst)
               regfile[0]<=0;
        if(Write_En)
        begin if (dest!=0)begin
            regfile[dest]<=Write_Val;
            end
            end

    end
    assign reg1=regfile[src1];
    assign reg2=regfile[src2];
endmodule



