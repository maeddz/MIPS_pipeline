module mapping_address(input[31:0] address,output[31:0] mapped_address);
    assign mapped_address=address-32'd1024;
endmodule
    
module MEM(input[31:0] write_data,input[31:0] address,input clk,rst,MemRead,MemWrite,output[31:0] read_data
  ,inout[15:0] SRAM_DQ,output ready,output SRAM_UB_N, SRAM_LB_N,SRAM_WB_N,SRAM_CE_N,SRAM_OE_N,sram_freeze,
  output[17:0] SRAM_ADDR
);
    wire [31:0]mapped_address;
    mapping_address n2(.address(address),.mapped_address(mapped_address));
    
      sram_controller _sram(.clk(clk), .rst(rst), .wr_en(MemWrite), .rd_en(MemRead), 
                      .address(mapped_address) , .writeData(write_data), .sram_dq(SRAM_DQ), 
                        .readData(read_data), .ready(ready),.sram_ub_n(SRAM_UB_N), .sram_lb_n(SRAM_LB_N),.sram_wb_n(SRAM_WB_N),
                       .sram_ce_n(SRAM_CE_N), .sram_oe_n(SRAM_OE_N), .sram_addr(SRAM_ADDR) , .isfreeze(sram_freeze));
    
    //memory n1(.write_data(write_data), .address(mapped_address),.clk(clk),.rst(rst)
      //          ,.MemRead(MemRead),.MemWrite(MemWrite),.read_data(read_data));
endmodule
