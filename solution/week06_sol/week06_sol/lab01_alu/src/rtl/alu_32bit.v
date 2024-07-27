//`timescale 1ns/1ps

module alu_32bit(
  input               clk,
  input               rst_n,
	input				[2:0] 	ALUControl,
	input				[31:0] 	A,
	input				[31:0] 	B,
	output reg 	[31:0] 	Result_reg,
	output reg					N_reg,
	output reg					Z_reg,
	output reg					C_reg,
	output reg					V_reg
);

	wire [31:0] B_bar;
	wire [31:0] sum;
  wire cout;

  //----------------------------------
  //set B_bar as (B or ~B) using mux
  //----------------------------------
	assign B_bar = (ALUControl[0] == 1'b1) ? ~B : B;

  //----------------------------------
  //Instance ripple_carry_adder
  //----------------------------------
	ripple_carry_adder u_rippple_carry_adder(
		.a    (A),
		.b    (B_bar),
		.cin  (ALUControl[0]),
		.sum  (sum),	
		.cout (cout)
	);

  //----------------------------------
  //Flag
  //----------------------------------
  wire N, Z, C, V;
  reg [31:0] result;

  //Negative
  assign  N = (result[31] == 1'b1);

  //Zero
  assign  Z = (sum == 32'h0);
 
  //Carry
  assign  C = (cout & (!ALUControl[1]));

  //oVerflow
  wire V_tmp1;
  wire V_tmp2;

  assign  V_tmp1 = (!(ALUControl[0] ^ A[31] ^ B[31]));
  assign  V_tmp2 = (A[31] ^ sum[31]);
  assign  V = (V_tmp1 & V_tmp2 & (!ALUControl[1]));  


  //----------------------------------
  //SLT
  //----------------------------------
  wire slt;
	assign slt = sum[31] ^ V;
  

  //----------------------------------
	//Result select MUX
  //----------------------------------
	always@(*)
	begin
		case(ALUControl[2:0])
			3'b000:   result = sum;              //Add
      3'b001:   result = sum;              //Sub 
      3'b010:   result = A & B;            //AND 
      3'b011:   result = A | B;            //OR
      3'b100:   result = A ^ B;            //XOR
      3'b101:   result = {31'h0, slt};     //Set less than
      3'b110:   result = {A[30:0], 1'b0};  //A rotate left by 1
      3'b111:   result = {1'b0, A[31:1]};  //A rotate right by 1
      default:  result = 32'h0;
 		endcase
	end



  //----------------------------------
	//Register
  //----------------------------------
  always @(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      begin
        Result_reg  <= 32'h0; 
        N_reg       <= 1'b0;
        Z_reg       <= 1'b0;
        C_reg       <= 1'b0;
        V_reg       <= 1'b0;
      end
    else
      begin
        Result_reg  <= result; 
        N_reg       <= N;
        Z_reg       <= Z;
        C_reg       <= C;
        V_reg       <= V;
      end
  end

endmodule
