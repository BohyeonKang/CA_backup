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

    //set B_bar as (B or ~B) using mux
	wire [31:0] mux_output;
	assign mux_output = (ALUControl[0]==0) ? B:
	                    (ALUControl[0]==1) ? ~B:
	                    32'bx;

    //Instance ripple_carry_adder
    //----------------------------------
    //TO DO 2
    //Use B_bar 
    wire [31:0] sum;
    wire c_out;
    ripple_carry_adder_32bit u_rca(.a(A),.b(mux_output),.c_in(ALUControl[0]),.sum(sum),.c_out(c_out));
    
    //----------------------------------
    //Flag
    wire N, Z, C, V;
  
    //Negative
    reg [31:0] result;
    assign  N = result[31]; 
  
    //Zero
    assign  Z = (result == 32'b0) ? 1 : 0; 
  
    //Carry
    assign  C = c_out & (~ALUControl[1]); 
  
    //oVerflow
    wire V_tmp1;
    wire V_tmp2;
    assign  V_tmp1 = ~(ALUControl[0]^A[31]^B[31]);
    assign  V_tmp2 = A[31]^sum[31];
    assign  V = (V_tmp1 & V_tmp2 & (~ALUControl[1]));  

    //----------------------------------
    //SLT
    //----------------------------------
    //TO DO 4
    wire [31:0] slt;
    assign slt = {31'b0 , sum[31]^V};
  
    //----------------------------------
	//Result select MUX
    //----------------------------------
    //TO DO 5
    always @(*)
    begin
        case(ALUControl)
            3'b000: result = sum;
            3'b001: result = sum;
            3'b010: result = A & B;
            3'b011: result = A | B;
            3'b100: result = A ^ B;
            3'b101: result = slt;
            3'b110: result = A << 1;
            3'b111: result = A >> 1;
            default:    result = 32'bx;
        endcase
    end
  
    //----------------------------------
	//Register
    //----------------------------------
    //TO DO 6 

    always @(posedge clk or negedge rst_n)
    begin
        if(!rst_n)
        begin
            Result_reg <= 0;
            N_reg <= 0;
            Z_reg <= 0;
            V_reg <= 0;
            C_reg <= 0;
        end
        else
        begin
            Result_reg <= result;
            N_reg <= N;
            Z_reg <= Z;
            V_reg <= V;
            C_reg <= C;
        end
    end
endmodule