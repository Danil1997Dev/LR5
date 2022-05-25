`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:42:25 13/04/2022
// Design Name: 
// Module Name:    LR3_GEN_CE 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module M_CLOCK_DIVIDER
#(parameter
	CLK_REF = 48_000_000,
	CLK_CE = 1_000_000, 
	RELATE_CLK = CLK_REF/CLK_CE,
	WIDTH_C_D = $clog2(RELATE_CLK)
    )
(
	input CLK,
	input RST,
	output reg CEO
    );
 

reg [WIDTH_C_D-1:0] CNT_DIV = 0;
always @ (posedge CLK or posedge RST)
	if(RST)
		begin
			CNT_DIV <= 0;
		end
	else
		begin
			if(CNT_DIV > RELATE_CLK) // CLK/DIGITAL
				begin
					CNT_DIV <= 0;
					CEO <= 1'b1;
				end
			else
				begin
					CNT_DIV <= CNT_DIV + 1;
					CEO <= 1'b0;
				end
		end




/*	 
	reg [16:0] CNT;
	
	always @(posedge CLK, posedge RST)
		if (RST)
			begin
				CNT <= 17'd0;
				CEO <= 1'b0;
			end
		else
			if (CNT == 17'd99999)
				begin
					CNT <= 17'd0;
					CEO <= 1'b1;
				end
			else
				begin
					CNT <= CNT + 1;
					CEO <= 1'b0;
				end
	*/			
endmodule