`timescale 1ns / 1ps

module testbench();
    
  reg clk;
  reg rst_n;
	reg [3:0] sws;
  reg [3:0] btns;
  wire [3:0] leds;

  led_on_value dut(
    .clk    (clk),
    .rst_n  (rst_n),
		.SW		  (sws),
		.BTN	  (btns),
		.LED	  (leds)
	);

  initial
  begin
    rst_n = 1'b1;
    #3 
    rst_n = 1'b0;
    #6
    rst_n = 1'b1;
  end

  initial
  begin
    clk <= 1'b0;
    forever begin
      #5 clk <= ~clk;
    end
  end



	initial
  begin
				            //btns = 4'b0000; sws = 4'b0000;  
    #5 wait(rst_n == 1'b1);
		@(negedge clk)	btns = 4'b0001; sws = 4'b0010;	
		@(negedge clk)  btns = 4'b0010; sws = 4'b0010;	
		@(negedge clk)  btns = 4'b0100; sws = 4'b0010;	
		@(negedge clk)  btns = 4'b1000; sws = 4'b0010;	

		#10;
    end

	initial
  begin
	  #70;
    $stop;
  end


     
endmodule
