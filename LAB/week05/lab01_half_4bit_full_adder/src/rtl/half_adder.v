module half_adder(
	input       i_a,
	input		i_b,
	output	o_sum,
	output	o_carry_out
);

	//define o_sum, o_carry_out
	//TO DO 
	assign o_sum = i_a^i_b;
	assign o_carry_out = i_a&i_b;

endmodule
