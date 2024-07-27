`timescale 1ns/1ps

module datapath(
  input       clk, 
  input       rst_n, 
  input       start,
  input [1:0] sel,
  input [7:0] a,
  input [7:0] b,
  input [3:0] c,
  input [3:0] d,

  output ready,
  output [7:0] result
);

  //wire, reg..
  wire [7:0] a_not;
  wire [7:0] a_b_and;
  wire [7:0] c_zero_ext;
  wire [7:0] d_sign_ext;



  assign a_not      = ~a;
  assign a_b_and    = a & b;
  assign c_zero_ext = {{4{1'b0}}, c};
  assign d_sign_ext = {{4{d[3]}}, d};

  wire [7:0] mux_result;

  //mux instance
  multiplexer u_multiplexer(
    .sel(sel),
    .a(a_not),
    .b(a_b_and),
    .c(c_zero_ext),
    .d(d_sign_ext),
    .result(mux_result)
  );
 
  reg start_1d; 
  reg [7:0] reg_result;

  always @(posedge clk or negedge rst_n)
  begin
    if(!rst_n)  
    begin
      start_1d   <= 1'b0;
      reg_result <= 8'h0;
    end
    else
    begin
      start_1d   <= start;
      reg_result <= mux_result;
    end
  end
   
  wire [3:0] fa_reg_result;

  full_adder_4bit u_full_adder_4bit(
    .i_a      (reg_result[3:0]),
    .i_b      (reg_result[7:4]),
    .i_c_in   (1'b0),
    .o_sum    (fa_reg_result),
    .o_cout   ()
  );

  wire [7:0] result_zero;
  assign result_zero = {fa_reg_result, 4'b0000};


  //output port 
  assign ready  = start_1d; 
  assign result = result_zero;

endmodule
