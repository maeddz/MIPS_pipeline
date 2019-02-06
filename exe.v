module EXE(input [31:0]Reg1, Reg2, Val2, PC,input [3:0]EXE_CMD,input [1:0]BR_type,
 input [1:0]sel1,sel2,sel3,//new
 input[31:0] MemValue,WbValue,//new
 output[31:0]ALU_result, output BR_taken, output [31:0]BR_address, output [31:0]reg2out);
 wire[31:0] val1mux,val2mux, reg2mux;
		//new
     MUX_32_2 m1(.mux0(Reg1),.mux1(MemValue),.mux2(WbValue),.sel(sel1),.muxout(val1mux));
     //new
     MUX_32_2 m2(.mux0(Val2),.mux1(MemValue),.mux2(WbValue),.sel(sel2),.muxout(val2mux));
	  MUX_32_2 m3(.mux0(Reg2),.mux1(MemValue),.mux2(WbValue),.sel(sel3),.muxout(reg2mux));
     ALU aa(.val1(val1mux),.val2(val2mux),.EXE_CMD(EXE_CMD),.ALU_result(ALU_result));
     condcheck cc( .val1(val1mux),.src2_val(reg2mux),.BR_type(BR_type), .B_taken(BR_taken));
     adderexe ae(.Val2(val2mux), .PC(PC), .adderout(BR_address));
	  assign reg2out=reg2mux;
     
endmodule


module adderexe(input [31:0]Val2, PC, output [31:0]adderout);
    assign adderout=(Val2*4)+ PC;
endmodule




