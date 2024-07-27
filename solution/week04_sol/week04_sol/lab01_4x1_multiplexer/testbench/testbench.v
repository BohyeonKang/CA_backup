`timescale 1ns/1ps

module testbench();

  reg [3:0] a_in;
  reg [3:0] b_in;
  reg [3:0] c_in;
  reg [3:0] d_in;
  reg [1:0] sel_in;
  wire [3:0] out_tb;

  multiplexer dut (
    .a(a_in),
    .b(b_in),
    .c(c_in),
    .d(d_in),
    .sel(sel_in),
    .out(out_tb)
  );

  initial
    begin
          sel_in = 2'b00;	a_in = 4'd2;  b_in = 4'd4; 	c_in = 4'd8; 	d_in = 4'd10;  
      #10 sel_in = 2'b01;	a_in = 4'd2;  b_in = 4'd4; 	c_in = 4'd8; 	d_in = 4'd10;  
      #10 sel_in = 2'b10;	a_in = 4'd2;  b_in = 4'd4; 	c_in = 4'd8; 	d_in = 4'd10;  
      #10 sel_in = 2'b11;	a_in = 4'd2;  b_in = 4'd4; 	c_in = 4'd8; 	d_in = 4'd10;  
      #20;
   end

  initial
    begin
          $display("               a: %d   b: %d   c: %d   d: %d ", a_in, b_in, c_in, d_in);
      #1  $display("%t ns: sel: %b / out: %d ", $time, sel_in, out_tb);
      #10 $display("%t ns: sel: %b / out: %d ", $time, sel_in, out_tb);
      #10 $display("%t ns: sel: %b / out: %d ", $time, sel_in, out_tb);
      #10 $display("%t ns: sel: %b / out: %d ", $time, sel_in, out_tb);
      #10
      #10
      $finish;
    end

endmodule
