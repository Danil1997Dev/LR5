`timescale 1ns / 1ps

module LR5_MATRIX_DISP_V10
#(
parameter
CLK_REF = 48_000_000,
CLK_CE = 1_000_000,
CLK_RELATE = CLK_REF/CLK_CE,
CLK_RELATE_8 = CLK_RELATE/8,
WIDTH_CR_8 = $clog2(CLK_RELATE_8)
)
(
	input CLK,
	input RST,
	input CE, 
	input [63:0] DAT_I,
	output reg [7:0] STR,
	output reg [7:0] CLM
);
  reg [6:0] addr;
  reg [3:0] buffer;
  reg [WIDTH_CR_8:0] cnt_8;
  reg [2:0] cnt;
  wire [7:0] out;
  reg ceo,ceo_cnt;

  reg [63:0] data;
  reg [7:0] data_0,data_1,data_2,data_3,data_4,data_5,data_6,data_7; 
 
//cnt colomns 

 /* always @(posedge CLK or posedge RST)
    if (RST)
      begin
        cnt_8 <= 0;  
        ceo <= 0;
      end
    else
      begin
        if (CE) 
          begin  
	  cnt_8 <= 0; 
                 ceo <= 0; 
          end
        else 
          begin
             if (cnt_8 == CLK_RELATE_8)
               begin
	  cnt_8 <= 0; 
                 ceo <= 1;
               end
             else
               begin
	  cnt_8 <= cnt_8+1; 
                 ceo <= 0;
               end 
          end
       end
*/
  always @(posedge CLK or posedge RST)
    if (RST)
      begin
        cnt <= 0;  
        //ceo <= 0;
      end
    else
      begin
        if (CE) 
          begin  
	  cnt <= cnt+1; 
                 //ceo <= 0;
          end
        else 
          begin
	  cnt <= cnt; 
                 //ceo <= 1; 
          end 
      end
 
//columns decoder
  always @(posedge CLK or posedge RST)
    if (RST)
      begin
        CLM <= 0;
      end
    else
      begin
        if (cnt > 7) 
          begin 
             CLM <= 2**0;
          end
        else 
          begin 
            CLM <= 2**(cnt);
          end
      end

//strings decoder
  always @(*)
    if (RST)
      begin 
        STR <= 8'h00;
      end
    else
      begin
        if (CE) 
          begin  
             STR <= {data_0[cnt],data_1[cnt],data_2[cnt],data_3[cnt],data_4[cnt],data_5[cnt],data_6[cnt],data_7[cnt]};
          end
        else 
          begin          
            STR <= 8'h00;
          end
      end
//buffer registr 

  always @(*) 
      begin
        if (CE) 
          begin 
             data = DAT_I; 
          end
        else 
          begin 
            data = data;  
          end 
      end 
  always @(*)
   begin
    data_0 = data[7:0];
    data_1 = data[15:8];
    data_2 = data[23:16];
    data_3 = data[31:24];
    data_4 = data[39:32];
    data_5 = data[47:40];
    data_6 = data[55:48];
    data_7 = data[63:56];
   end
endmodule