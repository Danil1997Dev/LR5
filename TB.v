`timescale 1ns / 1ps

module TB#(
parameter
CLK_REF = 48_000_000,
CLK_CE = 1_000_000,
CLK_RELATE = CLK_REF/CLK_CE,
CLK_RELATE_8 = CLK_RELATE/8,
WIDTH_CR_8 = $clog2(CLK_RELATE_8),
PERIOD_CLK = 20.8,// 20.8ns
DUTY_CYCLE_CLK = 0.4 
)();

    // Inputs
    reg CLK;
    reg RST;
    reg SHIFT_4B_R,SHIFT_4B_L; 
    reg RE;   
    wire [7:0] STRING,COLUMN;
    wire [15:0] LED;
 

    // Instantiate the Unit Under Test (UUT)
    LR5_Top_V10 uut (
	.clk(CLK), 
	.btnCpuReset(RST),
	.SHIFT_4B_R(SHIFT_4B_R),
	.SHIFT_4B_L(SHIFT_4B_L),
	.RE(RE), 
	.STRING(STRING),
	.COLUMN(COLUMN),
	.LED(LED)
    );

    initial begin
        // Initialize Inputs
        SHIFT_4B_L = 0;
        SHIFT_4B_R= 0; 
		  RST = 0;  
		  #40;
		  RST = 1; 
        SHIFT_4B_L = 0;
        SHIFT_4B_R= 0; 
        RE = 0; 
        repeat (100*CLK_RELATE) @(posedge CLK); 
        SHIFT_4B_L = 0;
        SHIFT_4B_R= 1; 
        RE = 0; 
        repeat (100*CLK_RELATE) @(posedge CLK); 
        SHIFT_4B_L = 0;
        SHIFT_4B_R= 0; 
        RE = 0; 
        repeat (100*CLK_RELATE) @(posedge CLK); 
        SHIFT_4B_L = 1;
        SHIFT_4B_R= 0; 
        RE = 0; 
        repeat (50*CLK_RELATE) @(posedge CLK); 
        SHIFT_4B_L = 0;
        SHIFT_4B_R= 1; 
        RE = 1; 
 
        #100000 $stop;
    end
 
 initial
 forever
 begin
 CLK = 1'b0;
 #(PERIOD_CLK-(PERIOD_CLK*DUTY_CYCLE_CLK)) CLK = 1'b1;
 #(PERIOD_CLK*DUTY_CYCLE_CLK);
 end

endmodule

