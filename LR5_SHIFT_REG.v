`timescale 1ns / 1ps

module LR5_SHIFT_REG(
	input CLK,
	input RST,
	input SHIFT_4B_R,
	input SHIFT_4B_L,
	output wire [63:0] OUT_SEQ
    );
	 
reg [63:0] SEQ;
reg [3:0] BUF;

wire [3:0] seq0t;
wire [3:0] seq1t;
wire [3:0] seq2t;
wire [3:0] seq3t;
wire [3:0] seq4t;
wire [3:0] seq5t;
wire [3:0] seq6t;
wire [3:0] seq7t;
wire [3:0] seq8t;
wire [3:0] seq9t;
wire [3:0] seq10t;
wire [3:0] seq11t;
wire [3:0] seq12t;
wire [3:0] seq13t;
wire [3:0] seq14t;
wire [3:0] seq15t;

 

always @(posedge CLK or posedge RST)
	begin
	if (RST == 1'b1)
		SEQ <= {4'h4,4'h1,4'h2,4'h1,4'h7,4'hC,4'hF,4'h9,4'hD,4'hA,4'hB,4'h3,4'h0,4'h8,4'h3,4'h2}; 
	else if (SHIFT_4B_R == 1'b1)
		begin 
			SEQ <= {SEQ[3:0],SEQ[63:4]}; 
		end
	else if (SHIFT_4B_L == 1'b1)
		begin
			SEQ <= {SEQ[59:0],SEQ[63:60]}; 
		end
	else
		begin 
			SEQ <= SEQ; 
		end
	
	end

assign OUT_SEQ = SEQ;

assign seq0t = OUT_SEQ[3:0];
assign seq1t = OUT_SEQ[7:4];
assign seq2t = OUT_SEQ[11:8];
assign seq3t = OUT_SEQ[15:12];
assign seq4t = OUT_SEQ[19:16];
assign seq5t = OUT_SEQ[23:20];
assign seq6t = OUT_SEQ[27:24];
assign seq7t = OUT_SEQ[31:28];
assign seq8t = OUT_SEQ[35:32];
assign seq9t = OUT_SEQ[39:36];
assign seq10t = OUT_SEQ[43:40];
assign seq11t = OUT_SEQ[47:44];
assign seq12t = OUT_SEQ[51:48];
assign seq13t = OUT_SEQ[55:52];
assign seq14t = OUT_SEQ[59:56];
assign seq15t = OUT_SEQ[63:60];
endmodule
