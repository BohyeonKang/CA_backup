`timescale 1ns/1ps

module testbench();

  reg [3:0]   a_in;
  reg [3:0]   b_in;
  reg         c_in;
  wire [3:0]  sum_tb;
  wire        c_out_tb;

  full_adder_4bit dut (
    .i_a    (a_in),
    .i_b    (b_in),
    .i_c_in (c_in),
    .o_sum  (sum_tb),
    .o_cout (c_out_tb)
  );

  initial
    begin
     
          a_in = 4'd7;  b_in = 4'd7;  c_in = 1'd0; 	  
      #10 a_in = 4'd7;  b_in = 4'd7;  c_in = 1'd1; 	  
      #10 a_in = 4'd7;  b_in = 4'd7;  c_in = 1'd0; 	  

      #10 a_in = 4'd0;  b_in = 4'd0; 	  c_in = 1'd1; 	  

      #10 a_in = 4'd0;  b_in = 4'b1111;	c_in = 1'b0; 	  
      #10 a_in = 4'd1;  b_in = 4'd15;	  c_in = 1'b0; 	  
      #10 a_in = 4'd2;  b_in = 4'hf;	  c_in = 1'b0; 	  

      #10 a_in = 4'hf;  b_in = 4'hf; 	  c_in = 1'd0; 	  

      #10 a_in = 4'd0;  b_in = 4'b1111;	c_in = 1'b0; 	  
      #10 a_in = 4'd1;  b_in = 4'd15;	  c_in = 1'b0; 	  
      #10 a_in = 4'd2;  b_in = 4'hf;	  c_in = 1'b0; 	  


      #20;
   end

  initial
    begin
					$display("               full adder 4-bit Test!!");
      #5  $display("[Binary]  %t ns: a: %b  b: %b c_in: %b  sum: %b c_out: %b", $time, a_in, b_in,c_in, sum_tb, c_out_tb);
      #10 $display("[Decimal] %t ns: a: %d  b: %d c_in: %d  sum: %d c_out: %d", $time, a_in, b_in,c_in, sum_tb, c_out_tb);
      #10 $display("[Hexa]    %t ns: a: %h  b: %h c_in: %h  sum: %h c_out: %h", $time, a_in, b_in,c_in, sum_tb, c_out_tb);

      #10 $display("%t ns: a: %d  b: %d c_in: %d  sum: %d c_out: %d", $time, a_in, b_in,c_in, sum_tb, c_out_tb);

      #10 $display("%t ns: a: %d  b: %d c_in: %d  sum: %d c_out: %d", $time, a_in, b_in,c_in, sum_tb, c_out_tb);
      #10 $display("%t ns: a: %d  b: %d c_in: %d  sum: %d c_out: %d", $time, a_in, b_in,c_in, sum_tb, c_out_tb);
      #10 $display("%t ns: a: %d  b: %d c_in: %d  sum: %d c_out: %d", $time, a_in, b_in,c_in, sum_tb, c_out_tb);

      #10 $display("%t ns: a: %d  b: %d c_in: %d  sum: %d c_out: %d", $time, a_in, b_in,c_in, sum_tb, c_out_tb);

      #10 $display("%t ns: a: %d  b: %d c_in: %d  sum: %d c_out: %d", $time, a_in, b_in,c_in, sum_tb, c_out_tb);
      #10 $display("%t ns: a: %d  b: %d c_in: %d  sum: %d c_out: %d", $time, a_in, b_in,c_in, sum_tb, c_out_tb);
      #10 $display("%t ns: a: %d  b: %d c_in: %d  sum: %d c_out: %d", $time, a_in, b_in,c_in, sum_tb, c_out_tb);

      #10
      #10
      $finish;
    end

endmodule


