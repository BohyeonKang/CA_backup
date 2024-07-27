`timescale 1ns / 1ps

module testbench();
    
	reg        clk;
	reg        rst_n;
  wire [3:0] digit;
  wire [7:0] hex;

  segment dut(
		.clk	      (clk),
    .rst_n      (rst_n),
		.HEX	  (hex),
		.HEX_DIGIT	(digit)
	);

	initial
     begin
        rst_n = 1'b1;
        #3
        rst_n = 1'b0;
        @(negedge clk);
        rst_n = 1'b1;
      end

    initial
    begin
      clk <= 1'b0;
      #5
      forever begin
        #5 clk <= ~clk;
      end
    end


	initial
  begin
  	  #10;
    end

	initial
  begin
	  #100000000;
    $stop;
  end


     
endmodule
