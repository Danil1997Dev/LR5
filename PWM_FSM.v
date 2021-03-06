module PWM_FSM #(
 parameter UDW = 4)
 (
 // System inputs:
 input CLK, 
 input RST,
 // Synchronous Reset:
 input RE,
 // Clock Enable:
 input CE,
 // PWM Code input:
 input [UDW-1:0] PWM_IN,
 // PWM signal outputs:
 output reg PWM_P, // Active-High
 output reg PWM_N // Active-Low
 );

// Internal signals declaration:
reg [UDW-1:0] PWM_REG, FSM_STATE;
reg [14:0] PWM_SEQ;


always @ (posedge CLK, posedge RST)
 if(RST)
 begin
  PWM_REG <= 0;
  FSM_STATE <= 0;
  PWM_P <= 0;
  PWM_N <= 0;
  PWM_SEQ <=  0;
 end

 else if(RE)
 begin
  FSM_STATE <= 0;  
  PWM_REG <= PWM_REG;
  PWM_SEQ <= 2**PWM_REG-1;
  PWM_P <= 0;
  PWM_N <= 1;
 end

 else if(CE)
 begin
 if(FSM_STATE == {UDW{1'b1}}-1'b1)
  begin
  PWM_REG <= PWM_IN; 
  end
 else
  begin
  PWM_REG <= PWM_REG;
  end
 case(FSM_STATE)
 0 :
 begin
  FSM_STATE <= FSM_STATE + 1'b1;
  PWM_SEQ <= PWM_SEQ >> 1'b1;
 end
 {UDW{1'b1}} :
 begin
  FSM_STATE <= 0;
  PWM_SEQ <= 2**PWM_REG-1;
 end
 default :
 begin
  FSM_STATE <= FSM_STATE + 1'b1;
  PWM_SEQ <= PWM_SEQ >> 1'b1;
 end
 endcase
  PWM_P <= PWM_SEQ[0];
  PWM_N <= ~PWM_SEQ[0];
 end 
endmodule 
