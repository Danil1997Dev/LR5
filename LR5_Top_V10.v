`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:30:09 13/04/2022
// Design Name: 
// Module Name:    LR5_TOP 
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
module LR5_Top_V10#
( 
)
(
   input clk, 
	input btnCpuReset, //Сигнал сброса
	input SHIFT_4B_R,
	input SHIFT_4B_L,
	input RE, 
              output [7:0] STRING,
              output [7:0] COLUMN,
              output [15:0] LED
    );
	             
	reg [1:0] RST_SYNC;
	wire RST_I; //Шина с синхронизированным сигналом сброса
	wire CE;
	wire ceo_r;
	wire ceo_l;
	wire [63:0] seq;
	
	always @(posedge clk, negedge btnCpuReset) //Синхронизация сброса
		if (~btnCpuReset) RST_SYNC <= 2'b11;
		else RST_SYNC <= {RST_SYNC[0], 1'b0};
	
	assign RST_I = RST_SYNC[1];
	
	M_CLOCK_DIVIDER gce(.CLK(clk), .RST(RST_I), .CEO(CE));
	M_BTN_FILTER_V10 btnf_r(.CLK(clk), .RST(RST_I), .CE(CE), .BTN_I(SHIFT_4B_R), .BTN_O(), .BTN_CEO(ceo_r));
	M_BTN_FILTER_V10 btnf_l(.CLK(clk), .RST(RST_I), .CE(CE), .BTN_I(SHIFT_4B_L), .BTN_O(), .BTN_CEO(ceo_l));
	M_BTN_FILTER_V10 btnf_re(.CLK(clk), .RST(RST_I), .CE(CE), .BTN_I(RE), .BTN_O(), .BTN_CEO(ceo_re));
	LR5_SHIFT_REG shr(.CLK(clk), .RST(RST_I), .SHIFT_4B_R(ceo_r), .SHIFT_4B_L(ceo_l), .OUT_SEQ(seq));

	LR5_MATRIX_DISP_V10 main(.CLK(clk), .RST(RST_I), .CE(CE), .DAT_I(seq),  .STR(STRING),.CLM(COLUMN));

	PWM_FSM pwm0 (.CLK(clk), .RST(RST_I), .CE(CE), .RE(ceo_re), .PWM_IN(seq[3:0]),  .PWM_P(LED[0]),.PWM_N( )); 
	PWM_FSM pwm1 (.CLK(clk), .RST(RST_I), .CE(CE), .RE(ceo_re), .PWM_IN(seq[7:4]),  .PWM_P(LED[1]),.PWM_N( ));
	PWM_FSM pwm2 (.CLK(clk), .RST(RST_I), .CE(CE), .RE(ceo_re), .PWM_IN(seq[11:8]),  .PWM_P(LED[2]),.PWM_N( ));
	PWM_FSM pwm3 (.CLK(clk), .RST(RST_I), .CE(CE), .RE(ceo_re), .PWM_IN(seq[15:12]),  .PWM_P(LED[3]),.PWM_N( ));
	PWM_FSM pwm4 (.CLK(clk), .RST(RST_I), .CE(CE), .RE(ceo_re), .PWM_IN(seq[19:16]),  .PWM_P(LED[4]),.PWM_N( ));
	PWM_FSM pwm5 (.CLK(clk), .RST(RST_I), .CE(CE), .RE(ceo_re), .PWM_IN(seq[23:20]),  .PWM_P(LED[5]),.PWM_N( ));
	PWM_FSM pwm6 (.CLK(clk), .RST(RST_I), .CE(CE), .RE(ceo_re), .PWM_IN(seq[27:24]),  .PWM_P(LED[6]),.PWM_N( ));
	PWM_FSM pwm7 (.CLK(clk), .RST(RST_I), .CE(CE), .RE(ceo_re), .PWM_IN(seq[31:28]),  .PWM_P(LED[7]),.PWM_N( ));
	PWM_FSM pwm8 (.CLK(clk), .RST(RST_I), .CE(CE), .RE(ceo_re), .PWM_IN(seq[35:32]),  .PWM_P(LED[8]),.PWM_N( ));
	PWM_FSM pwm9 (.CLK(clk), .RST(RST_I), .CE(CE), .RE(ceo_re), .PWM_IN(seq[39:36]),  .PWM_P(LED[9]),.PWM_N( ));
	PWM_FSM pwm10 (.CLK(clk), .RST(RST_I), .CE(CE), .RE(ceo_re), .PWM_IN(seq[43:40]),  .PWM_P(LED[10]),.PWM_N( ));
	PWM_FSM pwm11 (.CLK(clk), .RST(RST_I), .CE(CE), .RE(ceo_re), .PWM_IN(seq[47:44]),  .PWM_P(LED[11]),.PWM_N( ));
	PWM_FSM pwm12 (.CLK(clk), .RST(RST_I), .CE(CE), .RE(ceo_re), .PWM_IN(seq[51:48]),  .PWM_P(LED[12]),.PWM_N( ));
	PWM_FSM pwm13 (.CLK(clk), .RST(RST_I), .CE(CE), .RE(ceo_re), .PWM_IN(seq[55:52]),  .PWM_P(LED[13]),.PWM_N( ));
	PWM_FSM pwm14 (.CLK(clk), .RST(RST_I), .CE(CE), .RE(ceo_re), .PWM_IN(seq[59:56]),  .PWM_P(LED[14]),.PWM_N( ));
	PWM_FSM pwm15 (.CLK(clk), .RST(RST_I), .CE(CE), .RE(ceo_re), .PWM_IN(seq[63:60]),  .PWM_P(LED[15]),.PWM_N( ));


endmodule