module datapath(
    input       clk, 
    input       rst_n, 
    input start,
    input [7:0] a,b,
    input [3:0] c,d,
    input [1:0] sel,
    output ready,
    output [7:0] result
);

	//define a_not, a_b_and, c_zero_ext, d_sign_ext
	wire [7:0] a_not;
    wire [7:0] a_b_and;
    wire [7:0] c_zero_ext;
    wire [7:0] d_sign_ext;
    
    assign a_not = ~a;
    assign a_b_and = a&b;
    assign c_zero_ext = {4'b0000,c};
    assign d_sign_ext = {{4{d[3]}},d};
  
    //multiplexer instance
    wire [7:0] mux_result;
    multiplexer u_mux(.sel(sel),.a(a_not),.b(a_b_and),.c(c_zero_ext),.d(d_sign_ext),.result(mux_result));
    
    //define register
    reg start_1d; 
    always @(posedge clk, negedge rst_n)
    begin
        if(!rst_n)  start_1d <= 0;
        else        start_1d <= start;
    end
  
    reg [7:0] reg_result;
    always @(posedge clk, negedge rst_n)
    begin
        if(!rst_n)  reg_result <= 0;
        else        reg_result <= mux_result;
    end
 
	//4bit full adder instance
	wire [3:0] fa_reg_result;
	full_adder_4bit u_full_adder_4bit(.i_a(reg_result[3:0]),.i_b(reg_result[7:4]),.i_c_in(1'b0),.o_sum(fa_reg_result),.o_cout());

	//low 4bit zero
    wire [7:0] result_zero;
    assign result_zero = {fa_reg_result,4'b0000};

    //output port 
    assign ready  = start_1d; 
    assign result = result_zero;

endmodule
