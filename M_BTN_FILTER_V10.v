`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:30:17 13/04/2022
// Design Name: 
// Module Name:    button_filter 
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
module M_BTN_FILTER_V10(
   input CLK,
	input RST,
	input CE,  //Синхросигнал с делителя частоты
	input BTN_I,
	output reg BTN_O, //Вывод значения сигнала с кнопки после заполнения счетчика
	output reg BTN_CEO //Вывод значения сигнала с кнопки после заполнения счетчика в момент синхросигнала с делителя частоты							
	 );					 //Нужен для того, чтобы учесть момент, когда пользователь будет отпускать кнопку и автомат отреагировал
							//только один раз
	reg [1:0] BTN_I_SYNC;

	always @(posedge CLK, posedge RST)
		if (RST) BTN_I_SYNC <= 2'b00;
		else BTN_I_SYNC <= {BTN_I_SYNC[0], BTN_I}; //Фиксация значения со входа BTN_I в момент синхросигнала
		
	reg [3:0] CNT;	//Счетчик сигналов 1

	always @(posedge CLK, posedge RST)
		if (RST) CNT <= 4'h0;
		else if (BTN_I_SYNC[1] ~^ BTN_O) CNT <= 4'h0; //Если последовательность единиц превалась, то счетчик сбрасывается в 0
		else if (CE) CNT <= CNT + 1;

	always @(posedge CLK, posedge RST)
		if (RST) BTN_O <= 1'b0;
		else if (&(CNT) & CE) BTN_O <= BTN_I_SYNC[1];    //& проверяет все 1, счетчик заполнился
		
	always @(posedge CLK, posedge RST)
		if (RST) BTN_CEO <= 1'b0;
		else BTN_CEO <= &(CNT) & CE & BTN_I_SYNC[1];


endmodule