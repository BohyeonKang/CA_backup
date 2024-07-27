`timescale 1ns / 1ps

module testbench();
    
	reg [3:0]   sws;
  reg [3:0]   btns;
  wire [3:0]  leds;

  led_on dut(
		.SW		(sws),
		.BTN	(btns),
		.LED	(leds)
	);
 

	initial
  begin

				sws = 4'b0000;	btns = 4'b0000;
		#10	sws = 4'b0001;	btns = 4'b0000;
		#10 sws = 4'b0010;	btns = 4'b0000;
		#10 sws = 4'b0100;	btns = 4'b0000;
		#10 sws = 4'b1000;	btns = 4'b0000;

    //right case
		#10	sws = 4'b0001;	btns = 4'b0001;
		#10 sws = 4'b0010;	btns = 4'b0010;
		#10 sws = 4'b0100;	btns = 4'b0100;
		#10 sws = 4'b1000;	btns = 4'b1000;

    //wrong case
		#10	sws = 4'b0001;	btns = 4'b0010;
		#10	sws = 4'b0010;	btns = 4'b1000;
		#10	sws = 4'b1000;	btns = 4'b0100;
		#10	sws = 4'b0100;	btns = 4'b0010;
		#10;
    end

	initial
  begin
	  #150;
    $stop;
  end


     
endmodule
