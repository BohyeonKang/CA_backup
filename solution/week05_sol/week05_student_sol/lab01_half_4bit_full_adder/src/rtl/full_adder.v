`timescale 1ns/1ps

module full_adder(
	input	i_a,
	input i_b,
	input i_c_in,
	output o_sum,
	output o_cout
);

	wire o_sum_tmp1;
	wire o_cout_tmp1;

	wire o_sum_tmp2;
	wire o_cout_tmp2;


	half_adder u1_half_adder(
		.i_a					(i_a),
		.i_b					(i_b),
		.o_sum				(o_sum_tmp1),
		.o_carry_out	(o_cout_tmp1)
	);

	half_adder u2_half_adder(
		.i_a					(i_c_in),
		.i_b					(o_sum_tmp1),
		.o_sum				(o_sum_tmp2),
		.o_carry_out	(o_cout_tmp2)
	);

	assign o_sum = o_sum_tmp2;
	assign o_cout = o_cout_tmp1 | o_cout_tmp2;

endmodule
