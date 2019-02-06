module memory(input[31:0] write_data,input[31:0] address,input clk,rst,MemRead,MemWrite,output[31:0] read_data);
	reg [31:0] Memory[63:0];
	assign read_data=(MemRead)?Memory[{2'b0,address[31:2]}]:32'b0;
	always@(posedge clk)begin
		if(MemWrite)
			Memory[{2'b0,address[31:2]}]<=write_data;
	end
endmodule


