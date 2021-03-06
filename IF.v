module pc(input clk, rst,freeze,input [31:0]p, output reg[31:0]pcout);
    always@(posedge clk, posedge rst) begin
    if(rst)
        pcout<=0;
    else if(freeze==0)begin
        pcout<=p;
    end
  end

endmodule

module pcadder( input [31:0]pcout, output [31:0]pcadderout);
        assign pcadderout=pcout+4;
endmodule

module Rom(input [31:0]pcout, output [31:0]romout);
    reg [31:0]instmem[1023:0];//avali arz ;dovomi tol
    assign romout=instmem[{2'b0,pcout[31:2]}];
    initial begin
    instmem[0]=32'b100000_00000_00001_00000_11000001010;//-- Addi r1 ,r0 ,1546
    instmem[1]=32'b000001_00000_00001_00010_00000000000;//-- Add  r2 ,r0 ,r1
    instmem[2]=32'b000011_00000_00001_00011_00000000000;//-- sub r3 ,r0 ,r1
    instmem[3]=32'b000101_00010_00011_00100_00000000000;//-- And r4 ,r2 ,r3
    instmem[4]=32'b100001_00011_00101_00011_01000110100;//-- Subi r5 ,r3 ,6708
    instmem[5]=32'b000110_00011_00100_00101_00000000000;//-- or r5 ,r3 ,r4
    instmem[6]=32'b000111_00101_00000_00110_00000000000;//-- nor  r6 ,r5 ,r0
    instmem[7]=32'b000111_00100_00000_01011_00000000000;//-- nor  r11 ,r4 ,r0 9.
    instmem[8]=32'b000011_00101_00101_00101_00000000000;//-- sub r5 ,r5 ,r5  10.
    instmem[9]=32'b100000_00000_00001_00000_10000000000;//-- Addi  r1 ,r0 ,1024     11.
    instmem[10]=32'b100101_00001_00010_00000_00000000000;//-- st r2 ,r1 ,0        12.
    instmem[11]=32'b100100_00001_00101_00000_00000000000;//-- ld r5 ,r1 ,0       13.
    instmem[12]=32'b101000_00101_00000_00000_00000000001;//-- Bez r5 ,1            14.
    instmem[13]=32'b001000_00101_00001_00111_00000000000;//-- xor r7 ,r5 ,r1 15.
    instmem[14]=32'b001000_00101_00001_00000_00000000000;//-- xor r0 ,r5 ,r1 16.
    instmem[15]=32'b001001_00011_01011_00111_00000000000;//-- sla r7 ,r3 ,r11 17.
    instmem[16]=32'b001010_00011_01011_01000_00000000000;//-- sll r8 ,r3 ,r11 18
    instmem[17]= 32'b001011_00011_00100_01001_00000000000;//-- sra r9 ,r3 ,r4 19.
    instmem[18]=32'b001100_00011_00100_01010_00000000000;//-- srl r10 ,r3 ,r4 20.
    instmem[19]=32'b100101_00001_00011_00000_00000000100;//-- st r3 ,r1 ,4        21.
    instmem[20]=32'b100101_00001_00100_00000_00000001000;//-- st r4 ,r1 ,8        22.
    instmem[21]=32'b100101_00001_00101_00000_00000001100;//-- st r5 ,r1 ,12       23.
    instmem[22]=32'b100101_00001_00110_00000_00000010000;//-- st r6 ,r1 ,16       24.
    instmem[23]=32'b100100_00001_01011_00000_00000000100;//-- ld r11 ,r1 ,4       25.
    instmem[24]=32'b100101_00001_00111_00000_00000010100;//-- st r7 ,r1 ,20      26.
    instmem[25]=32'b100101_00001_01000_00000_00000011000;//-- st r8 ,r1 ,24      27.
    instmem[26]=32'b100101_00001_01001_00000_00000011100;//-- st r9 ,r1 ,28      28.
    instmem[27]=32'b100101_00001_01010_00000_00000100000;//-- st r10 ,r1 ,32      29.
    instmem[28]=32'b100101_00001_01011_00000_00000100100;//-- st r11 ,r1 ,36      30.
    instmem[29]=32'b100000_00000_00001_00000_00000000011;//-- Addi  r1 ,r0 ,3       31.
    instmem[30]=32'b100000_00000_00100_00000_10000000000;//-- Addi r4 ,r0 ,1024    32.
    instmem[31]=32'b100000_00000_00010_00000_00000000000;//-- Addi  r2 ,r0 ,0       33.
    instmem[32]=32'b100000_00000_00011_00000_00000000001;//-- Addi  r3 ,r0 ,1       34.
    instmem[33]=32'b100000_00000_01001_00000_00000000010;//-- Addi  r9 ,r0 ,2       35.
    instmem[34]=32'b001010_00011_01001_01000_00000000000;//-- sll r8 ,r3 ,r9  36.
    instmem[35]=32'b000001_00100_01000_01000_00000000000;//-- Add  r8 ,r4 ,r8  37.
    instmem[36]=32'b100100_01000_00101_00000_00000000000;//-- ld r5 ,r8 ,0        38.
    instmem[37]=32'b100100_01000_00110_11111_11111111100;//-- ld r6 ,r8 ,-4       39.
    instmem[38]=32'b000011_00101_00110_01001_00000000000;//-- sub  r9 ,r5 ,r6
    instmem[39]=32'b100000_00000_01010_10000_00000000000;//-- Addi  r10 ,r0 ,0x8000  41.
    instmem[40]=32'b100000_00000_01011_00000_00000010000;//-- Addi r11 ,r0 ,16      42.
    instmem[41]=32'b001010_01010_01011_01010_00000000000;//-- sll r10 ,r1 ,r11 43.
    instmem[42]=32'b000101_01001_01010_01001_00000000000;//-- And  r9 ,r9 ,r10  44.
    instmem[43]=32'b101000_01001_00000_00000_00000000010;//-- Bez r9 ,2            45.
    instmem[44]=32'b100101_01000_00101_11111_11111111100;//-- st r5 ,r8 ,-4      46.
    instmem[45]=32'b100101_01000_00110_00000_00000000000;//-- st r6 ,r8 ,0       47.
    instmem[46]=32'b100000_00011_00011_00000_00000000001;//-- Addi  r3 ,r3 ,1       48.
    instmem[47]=32'b101001_00001_00011_11111_11111110001;//-- BNE r1 ,r3 ,-15     49.
    instmem[48]=32'b100000_00010_00010_00000_00000000001;//-- Addi  r2 ,r2 ,1       50.
    instmem[49]=32'b101001_00001_00010_11111_11111101110;//-- BNE r1 ,r2 ,-18     51.
    instmem[50]=32'b100000_00000_00001_00000_10000000000;//-- Addi  r1 ,r0 ,1024    52.
    instmem[51]=32'b100100_00001_00010_00000_00000000000;//-- ld ,r2 ,r1 ,0
    instmem[52]=32'b100100_00001_00011_00000_00000000100;//-- ld ,r3 ,r1 ,4
    instmem[53]=32'b100100_00001_00100_00000_00000001000;//-- ld ,r4 ,r1 ,8 55.
    instmem[54]=32'b100100_00001_00100_00000_01000001000;//-- ld ,r4 ,r1 ,520  56.
    instmem[55]=32'b100100_00001_00100_00000_10000001000;//-- ld ,r4 ,r1 ,1023 57.
    instmem[56]=32'b100100_00001_00101_00000_00000001100;//-- ld ,r5 ,r1 ,12      58.
    instmem[57]=32'b100100_00001_00110_00000_00000010000;//-- ld ,r6 ,r1 ,16      59.
    instmem[58]=32'b100100_00001_00111_00000_00000010100;//-- ld ,r7 ,r1 ,20      60
    instmem[59]=32'b100100_00001_01000_00000_00000011000;//-- ld ,r8 ,r1 ,24      61.
    instmem[60]=32'b100100_00001_01001_00000_00000011100;//-- ld ,r9 ,r1 ,28      62.
    instmem[61]=32'b100100_00001_01010_00000_00000100000;//-- ld ,r10,r1 ,32      63.
    instmem[62]=32'b100100_00001_01011_00000_00000100100;//-- ld ,r11,r1 ,36      64.
   // instmem[63]=32'b101010_00000_00000_11111_11111111111;//-- JMP  -1

      /*

    instmem[1]=0;
    instmem[2]=0;
    instmem[3]=32'b000001_00000_00001_00010_00000000000;//-- Add  r2 ,r0 ,r1
    instmem[4]=32'b000011_00000_00001_00011_00000000000; //sub     r3,r0,r1
    instmem[5]=0;
    instmem[6]=0;
    instmem[7]=32'b000101_00010_00011_00100_00000000000;    //and r4 r2 r3
    instmem[8]=32'b100001_00011_00101_00011_01000110100;    //subi r5r3 6708
    instmem[9]=0;
    instmem[10]=0;
    instmem[11]=32'b000110_00011_00100_00101_00000000000;//-- or r5 ,r3 ,r4;
    instmem[12]=0;
    instmem[13]=0;
    instmem[14]=32'b000111_00101_00000_00110_00000000000;//-- nor  r6 ,r5 ,r0
    instmem[15]=0;
    instmem[16]=0;
    instmem[17]=32'b000111_00100_00000_01011_00000000000;//-- nor  r11 ,r4 ,r0
    instmem[18]=32'b000011_00101_00101_00101_00000000000;//-- sub r5 ,r5 ,r5
    instmem[19]=32'b100000_00000_00001_00000_10000000000;//-- Addi  r1 ,r0 ,1024
    instmem[20]=0;
    instmem[21]=0;
    instmem[22]=32'b100101_00001_00010_00000_00000000000;//-- st r2 ,r1 ,0
    instmem[23]=32'b100100_00001_00101_00000_00000000000;//-- ld r5 ,r1 ,0
    instmem[24]=32'b100100_00001_00101_00000_00000000000;//-- ld r5 ,r1 ,0
    instmem[25]=0;
    instmem[26]=0;
    instmem[27]=32'b101000_00000_00101_00000_00000000001;//-- Bez r5 ,1
    instmem[28]=0;
    instmem[29]=0;
    instmem[30]=32'b001000_00101_00001_00111_00000000000;//-- xor r7 ,r5 ,r1
    instmem[31]=32'b001000_00101_00001_00000_00000000000;//-- xor r0 ,r5 ,r1 ----green
    instmem[32]=0;
    instmem[33]=0;
    instmem[34]=32'b001001_00011_01011_00111_00000000000;//-- sla r7 ,r3 ,r11 ----red
    instmem[35]=32'b001010_00011_01011_01000_00000000000;//-- sll r8 ,r3 ,r11
    instmem[36]=32'b001011_00011_00100_01001_00000000000;//-- sra r9 ,r3 ,r4
    instmem[37]=32'b001100_00011_00100_01010_00000000000;//-- srl r10 ,r3 ,r4
    instmem[38]=32'b100101_00001_00011_00000_00000000100;//-- st r3 ,r1 ,4
    instmem[39]=32'b100101_00001_00100_00000_00000001000;//-- st r4 ,r1 ,8
    instmem[40]=32'b100101_00001_00101_00000_00000001100;//-- st r5 ,r1 ,12
    instmem[41]=32'b100101_00001_00110_00000_00000010000;//-- st r6 ,r1 ,16
    instmem[42]=32'b100100_00001_01011_00000_00000000100;//-- ld r11 ,r1 ,4
    instmem[43]=32'b100101_00001_00111_00000_00000010100;//-- st r7 ,r1 ,20
    instmem[44]=32'b100101_00001_01000_00000_00000011000;//-- st r8 ,r1 ,24
    instmem[45]=32'b100101_00001_01001_00000_00000011100;//-- st r9 ,r1 ,28
    instmem[46]=32'b100101_00001_01010_00000_00000100000;//-- st r10 ,r1 ,32
    instmem[47]=32'b100101_00001_01011_00000_00000100100;//-- st r11 ,r1 ,36
    instmem[48]=32'b100000_00000_00001_00000_00000000011;//-- Addi  r1 ,r0 ,3
    instmem[49]=32'b100000_00000_00100_00000_10000000000;//-- Addi r4 ,r0 ,1024
    instmem[50]=32'b100000_00000_00010_00000_00000000000;//-- Addi  r2 ,r0 ,0
    instmem[51]=32'b100000_00000_00011_00000_00000000001;//-- Addi  r3 ,r0 ,1    ---green
    instmem[52]=32'b100000_00000_01001_00000_00000000010;//-- Addi  r9 ,r0 ,2  ---red
    instmem[53]=0;
    instmem[54]=0;
    instmem[55]=32'b001010_00011_01001_01000_00000000000;//-- sll r8 ,r3 ,r9
    instmem[56]=0;
    instmem[57]=0;
    instmem[58]=32'b000001_00100_01000_01000_00000000000;//-- Add  r8 ,r4 ,r8
    instmem[59]=0;
    instmem[60]=0;
    instmem[61]=32'b100100_01000_00101_00000_00000000000;//-- ld r5 ,r8 ,0
    instmem[62]=32'b100100_01000_00110_11111_11111111100;//-- ld r6 ,r8 ,-4
    instmem[63]=0;
    instmem[64]=0;
    instmem[65]=32'b000011_00101_00110_01001_00000000000;//-- sub  r9 ,r5 ,r6
    instmem[66]=32'b100000_00000_01010_10000_00000000000;//-- Addi  r10 ,r0 ,0x8000
    instmem[67]=32'b100000_00000_01011_00000_00000010000;//-- Addi r11 ,r0 ,16
    instmem[68]=0;
    instmem[69]=0;
    instmem[70]=32'b001010_01010_01011_01010_00000000000;//-- sll r10 ,r1 ,r11
    instmem[71]=32'b000101_01001_01010_01001_00000000000;//-- And  r9 ,r9 ,r10
    instmem[72]=0;
    instmem[73]=0;
    instmem[74]=32'b101000_01001_00000_00000_00000000010;//-- Bez r9 ,2
    instmem[75]=32'b100101_01000_00101_11111_11111111100;//-- st r5 ,r8 ,-4
    instmem[76]=32'b100101_01000_00110_00000_00000000000;//-- st r6 ,r8 ,0
    instmem[77]=32'b100000_00011_00011_00000_00000000001;//-- Addi  r3 ,r3 ,1
    instmem[78]=0;
    instmem[79]=0;

    instmem[80]=32'b101001_00001_00011_11111_11111100011;//-- BNE r1 ,r3 ,-15         ----red   -15->-29
    instmem[81]=32'b100000_00010_00010_00000_00000000001;//-- Addi  r2 ,r2 ,1
    instmem[82]=0;
    instmem[83]=0;
    instmem[84]=32'b101001_00001_00010_11111_11111011110;//-- BNE r1 ,r2 ,-18        ----green  -18->-34
    instmem[85]=32'b100000_00000_00001_00000_10000000000;//-- Addi  r1 ,r0 ,1024
    instmem[86]=0;
    instmem[87]=0;
    instmem[88]=32'b100100_00001_00010_00000_00000000000;//-- ld ,r2 ,r1 ,0
    instmem[89]=32'b100100_00001_00011_00000_00000000100;//-- ld ,r3 ,r1 ,4
    instmem[90]=32'b100100_00001_00100_00000_00000001000;//-- ld ,r4 ,r1 ,8
    instmem[91]=32'b100100_00001_00100_00000_01000001000;//-- ld ,r4 ,r1 ,520
    instmem[92]=32'b100100_00001_00100_00000_10000001000;//-- ld ,r4 ,r1 ,1023
    instmem[93]=32'b100100_00001_00101_00000_00000001100;//-- ld ,r5 ,r1 ,12
    instmem[94]=32'b100100_00001_00110_00000_00000010000;//-- ld ,r6 ,r1 ,16
    instmem[95]=32'b100100_00001_00111_00000_00000010100;//-- ld ,r7 ,r1 ,20
    instmem[96]=32'b100100_00001_01000_00000_00000011000;//-- ld ,r8 ,r1 ,24
    instmem[97]=32'b100100_00001_01001_00000_00000011100;//-- ld ,r9 ,r1 ,28
    instmem[98]=32'b100100_00001_01010_00000_00000100000;//-- ld ,r10,r1 ,32
    instmem[99]=32'b100100_00001_01011_00000_00000100100;//-- ld ,r11,r1 ,36
    //instmem[100]=32'b101010_00000_00000_11111_11111111111;//-- JMP  -1
*/
    end

endmodule



module IF(input clk,rst, freeze, branch_taken, input [31:0]branchaddress,output [31:0] pcadderout,romout );
    wire [31:0] pcout, temp, muxout;
    MUX_32_1 n32(.mux0(temp),.mux1(branchaddress), .sel(branch_taken), .muxout(muxout));
    pc n1(clk, rst,freeze,muxout,pcout);
    pcadder n2(pcout, temp);
    Rom n3(pcout, romout);
    always@*begin
      $display("%b",romout);
    end
    assign pcadderout=temp;
endmodule





