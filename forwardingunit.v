//new
module forwardunit(input[4:0] src1,src2,Dest_exe,Dest_mem,Dest_wb,input wb_mem,wb_wb,is_st_br,output reg[1:0] sel1,sel2,sel3);
  always@* begin
    sel1=0;sel2=0;sel3=0;
    if(wb_mem==1&&Dest_mem==Dest_exe&&is_st_br==1)
      sel3<=1;
    else if (wb_wb==1&&Dest_exe==Dest_wb&&is_st_br==1)
      sel3<=2;
    if (wb_mem==1&&src1==Dest_mem)
      sel1<=1;
    else if(wb_wb==1&&src1==Dest_wb)
      sel1<=2;
    if (wb_mem==1&&src2==Dest_mem)
      sel2<=1;
    else if(wb_wb==1&&src2==Dest_wb)
      sel2<=2;
    
	 
    /*sel1=0;sel2=0;sel3=0;
    if (src1==Dest_mem && src1==Dest_wb && wb_wb==1'b1 && wb_mem==1'b1)
      sel1=2'd1;
    else if (src2==Dest_mem && src2==Dest_wb && wb_wb==1'b1 && wb_mem==1'b1)
      sel2=2'd1;
    else if (src2==Dest_mem && wb_mem==1'b1)
      sel2=2'd1;
    else if (src1==Dest_mem && wb_mem==1'b1)
      sel1=1'd1;
    else if (src1==Dest_wb && wb_wb==1'b1)
      sel1=2'd2;
    else if (src2==Dest_wb && wb_wb==1'b1)
      sel2=2'd2;
    else if (Dest_exe==Dest_mem && wb_mem==1'b1)
      sel3=2'd1;
    else if (Dest_exe==Dest_wb && wb_wb==1'b1)
      sel3=2'd2;*/
  end
endmodule
  