`timescale 1ns/1ps

module full_adder_4bit(
	input [3:0]		i_a,
	input [3:0]		i_b,
  input         i_c_in,
	output [3:0]	o_sum,
	output				o_cout
);

  wire [2:0] c_tmp;

  full_adder f0(.i_a(i_a[0]), .i_b(i_b[0]), .i_c_in(i_c_in),	 .o_sum(o_sum[0]),   .o_cout(c_tmp[0]));	
  full_adder f1(.i_a(i_a[1]), .i_b(i_b[1]), .i_c_in(c_tmp[0]), .o_sum(o_sum[1]),   .o_cout(c_tmp[1]));	
  full_adder f2(.i_a(i_a[2]), .i_b(i_b[2]), .i_c_in(c_tmp[1]), .o_sum(o_sum[2]),   .o_cout(c_tmp[2]));	
  full_adder f3(.i_a(i_a[3]), .i_b(i_b[3]), .i_c_in(c_tmp[2]), .o_sum(o_sum[3]),   .o_cout(o_cout));	

endmodule
