`timescale 1ns/1ps

module led_on(
	input		[3:0] SW,
  input		[3:0] BTN,
  output	[3:0] LED
);
    
  assign LED[0] = SW[0] & BTN[0];
  assign LED[1] = SW[1] & BTN[1];
  assign LED[2] = SW[2] & BTN[2];
  assign LED[3] = SW[3] & BTN[3];
     
endmodule
	
