module MUX_32_1(input[31:0] mux0,mux1, input sel, output[31:0] muxout);
  assign muxout=(sel==1'b1) ? mux1:mux0;
endmodule

module MUX_5_1(input[4:0] mux0,mux1, input sel, output[4:0] muxout);
  assign muxout=sel ? mux1:mux0;
endmodule
//new
module MUX_32_2(input[31:0] mux0,mux1,mux2,input[1:0] sel,output[31:0]  muxout);
  assign muxout=(sel==2'b00) ? mux0:
                (sel==2'b01)?mux1:
                            mux2;
endmodule
