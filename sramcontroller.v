/*

module sram_controller(input clk, rst, wr_en, rd_en, 
                      input[31:0]address , writeData, inout[15:0]sram_dq, 
                        output [31:0]readData, output ready,output sram_ub_n, sram_lb_n, sram_wb_n,
                       sram_ce_n, sram_oe_n, output reg[17:0]sram_addr , output isfreeze);
  reg[15:0] _sram_dq;
  reg [31:0] dataRegister=0;
  reg [3:0]counter =0;
  assign sram_oe_n = 0;
  assign sram_ub_n = 0;
  assign sram_lb_n = 0;
  assign sram_ce_n = 0;
  assign sram_we_n = (rd_en && counter==0)?1:
                      (wr_en && counter==0)? 0:
                      1;
  assign isfreeze = (rd_en||wr_en)?
                    (counter!=6)?1
                    :0
                    :0;
  assign ready = ((wr_en || rd_en) && (counter <= 3) ) ? 0:
                   1;

  always@(posedge clk)begin
    if(rd_en&&counter==0)begin
      dataRegister <= {dataRegister[31:16], sram_dq};
    end else if(rd_en && counter==1)begin
      dataRegister <= {sram_dq , dataRegister[15:0]};
    end
    if(wr_en||rd_en)begin
      counter<=counter+1;
      if (counter==5)begin
        counter<=0;
      end
    end
    //else counter<=0;?????
  end
  

  
  assign sram_dq = (wr_en && counter==0)?
                    writeData[15:0]:
                    (wr_en&&counter==1)?
                    writeData[31:16]:
                    16'bzzzzzzzzzzzzzzzz;
  always@*begin
    if(counter==0)begin
      sram_addr = {address[18:2],1'b0};
    end else
      sram_addr = {address[18:2],1'b1};
  end
  
  assign readData = dataRegister;
endmodule*/
/*
module sram_controller(input clk, rst, wr_en, rd_en, 
                      input[31:0]address , writeData, inout[15:0]sram_dq, 
                        output [31:0]readData, output ready,output sram_ub_n, sram_lb_n, sram_wb_n,
                       sram_ce_n, sram_oe_n, output reg[17:0]sram_addr , output isfreeze);
  reg[15:0] _sram_dq;
  reg [31:0] dataRegister=0;
  reg [3:0]counter =0;
  assign sram_oe_n = 0;
  assign sram_ub_n = 0;
  assign sram_lb_n = 0;
  assign sram_ce_n = 0;
  assign sram_we_n = (rd_en )?1:
                      (wr_en )? 0:
                      1;
  assign isfreeze = (rd_en||wr_en)?
                    (counter!=6)?1
                    :0
                    :0;
  assign ready = ((wr_en || rd_en) && (counter <= 6) ) ? 0:
                   1;

  always@(posedge clk)begin
    if(rd_en&&counter==0)begin
      dataRegister <= {dataRegister[31:16], sram_dq};
    end else if(rd_en && counter==1)begin
      dataRegister <= {sram_dq , dataRegister[15:0]};
    end
    if(wr_en||rd_en)begin
      counter<=counter+1;
      if (counter==5)begin
        counter<=0;
      end
    end
    //else counter<=0;?????
  end
  

  
  assign sram_dq = (wr_en && counter==0)?
                    writeData[15:0]:
                    (wr_en&&counter==1)?
                    writeData[31:16]:
                    16'bzzzzzzzzzzzzzzzz;
  always@*begin
    if(counter==0)begin
      sram_addr = {address[18:2],1'b0};
    end else
      sram_addr = {address[18:2],1'b1};
  end
  
  assign readData = dataRegister;
endmodule*/

module sram_controller(input clk, rst, wr_en, rd_en, 
                      input[31:0]address , writeData, inout[15:0]sram_dq, 
                        output [31:0]readData, output ready,output sram_ub_n, sram_lb_n, sram_wb_n,
                       sram_ce_n, sram_oe_n, output reg[17:0]sram_addr , output isfreeze);
  reg[15:0] _sram_dq;
  reg [31:0] dataRegister=0;
  reg [3:0]counter =0;
  assign sram_oe_n = 0;
  assign sram_ub_n = 0;
  assign sram_lb_n = 0;
  assign sram_ce_n = 0;
  assign sram_wb_n =  (wr_en )? 0:1;
                     
  assign isfreeze = ((rd_en||wr_en)&&(counter!=4))?1:0;
                    
 // assign ready = ((wr_en || rd_en) && (counter <= 3) ) ? 0:
   //                1;

	always@(posedge clk)begin
		if(rst)begin
			counter<=0;
		end
		else begin
			if(rd_en&&counter==0)begin
				dataRegister[15:0] <=  sram_dq;
			end else if(rd_en && counter==1)begin
				dataRegister[31:16] <= sram_dq;
			end
			if(wr_en||rd_en)begin
				counter<= counter+1;
				if (counter==5)begin
					counter<=0;
				end
			end
		end
	end
  
/*counter in another always*/
  
  assign sram_dq = (wr_en && counter==0)?
                    writeData[15:0]:
                    (wr_en&&counter==1)?
                    writeData[31:16]:
                    16'bzzzzzzzzzzzzzzzz;
  always@*begin
    if(counter==0)begin
      sram_addr = {address[18:2],1'b0};
   end else
      sram_addr = {address[18:2],1'b1};
  end
  
  assign readData = dataRegister;
endmodule
