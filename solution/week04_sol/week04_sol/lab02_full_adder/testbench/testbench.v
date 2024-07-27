`timescale 1ns/1ps

module testbench();

  reg a_in;
  reg b_in;
  reg c_in;
  wire sum_tb;
  wire c_out_tb;

  full_adder dut (
    .a(a_in),
    .b(b_in),
    .c_in(c_in),
    .sum(sum_tb),
    .c_out(c_out_tb)
  );

  initial
    begin
          a_in = 1'b0;  b_in = 1'b0; 	c_in = 1'b0; 	  
      #10 a_in = 1'b0;  b_in = 1'b0; 	c_in = 1'b1; 	  
      #10 a_in = 1'b0;  b_in = 1'b1; 	c_in = 1'b0; 	  
      #10 a_in = 1'b0;  b_in = 1'b1; 	c_in = 1'b1; 	  
      #10 a_in = 1'b1;  b_in = 1'b0; 	c_in = 1'b0; 	  
      #10 a_in = 1'b1;  b_in = 1'b0; 	c_in = 1'b1; 	  
      #10 a_in = 1'b1;  b_in = 1'b1; 	c_in = 1'b0; 	  
      #10 a_in = 1'b1;  b_in = 1'b1; 	c_in = 1'b1; 	  
      #20;
   end

  initial
    begin
         $display("               a: %b b: %b c_in: %b  sum: %b c_out: %b", a_in, b_in, c_in, sum_tb, c_out_tb);
      #1  $display("%t ns: a: %b  b: %b c_in: %b  sum: %b c_out: %b", $time, a_in, b_in,c_in, sum_tb, c_out_tb);
      #10 $display("%t ns: a: %b  b: %b c_in: %b  sum: %b c_out: %b", $time, a_in, b_in,c_in, sum_tb, c_out_tb);
      #10 $display("%t ns: a: %b  b: %b c_in: %b  sum: %b c_out: %b", $time, a_in, b_in,c_in, sum_tb, c_out_tb);
      #10 $display("%t ns: a: %b  b: %b c_in: %b  sum: %b c_out: %b", $time, a_in, b_in,c_in, sum_tb, c_out_tb);
      #10 $display("%t ns: a: %b  b: %b c_in: %b  sum: %b c_out: %b", $time, a_in, b_in,c_in, sum_tb, c_out_tb);
      #10 $display("%t ns: a: %b  b: %b c_in: %b  sum: %b c_out: %b", $time, a_in, b_in,c_in, sum_tb, c_out_tb);
      #10 $display("%t ns: a: %b  b: %b c_in: %b  sum: %b c_out: %b", $time, a_in, b_in,c_in, sum_tb, c_out_tb);
      #10
      #10
      $finish;
    end

endmodule
