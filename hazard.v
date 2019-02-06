module hazard(input [4:0]src1, input [4:0]src2, input [4:0]exe_dest, input [4:0]mem_dest,
               input exe_wb_en, input mem_wb_en, is_im,check,input is_forward/*new*/,mem_r_en/*new in az marhale mem miad)*/
               ,output hazarddetection);
  reg hazard;

  always@*begin
	
    	if(!is_forward)begin
	     if(is_im)begin
          if(check==0)begin
             if(src1==mem_dest&&mem_wb_en==1)
                hazard=1;
              else if(src1==exe_dest&&exe_wb_en==1)
                hazard=1;
					else
						hazard=0;
          
          end
          else if(check==1)begin
            if((src1==mem_dest&&mem_wb_en==1)||(src1==exe_dest&&exe_wb_en==1))
              hazard=1;
            else if((src2==mem_dest&&mem_wb_en==1)||(src2==exe_dest&&exe_wb_en==1))
              hazard=1;
				  else
						hazard=0;
          end
			 else
						hazard=0;
       end else begin
          if(src1==mem_dest&&mem_wb_en==1)
            hazard=1;
          else if(src1==exe_dest&&exe_wb_en==1)
            hazard=1;
  	       else if(src2==mem_dest&&mem_wb_en==1)
            hazard=1;
        	 else if(src2==exe_dest&&exe_wb_en==1)
           hazard=1;
			  else
						hazard=0;
        end
      end
   	else begin
    		if(mem_r_en==1 && exe_dest==src1)
			   hazard=1;
    		else if(mem_r_en==1 && exe_dest==src2)
		    	hazard=1;
				else
						hazard=0;
		end
	end

  assign hazarddetection = hazard;
endmodule
