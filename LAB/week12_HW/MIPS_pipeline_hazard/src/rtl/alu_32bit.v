module alu_32bit(
    input ALUSrc,
    input [2:0] ALUControl,
    input [31:0] signimm,
    input [31:0] RD1,
    input [31:0] RD2,
    output reg [31:0] result,
    output Z
    );
    
    //-------------------------------
    //SrcA, SrcB
    //-------------------------------
    wire [31:0] SrcA;
    assign SrcA = RD1;
    
    wire [31:0] SrcB;
    assign SrcB = (ALUSrc) ? signimm : RD2;
    
    //-------------------------------
    //set B_bar as (B or ~B) using mux
    //-------------------------------
    
    wire [31:0] B_bar;
    
    assign B_bar = (ALUControl[0] == 1'b1) ? ~SrcB : SrcB;
    
    //-------------------------------
    //Instance ripple_carry_adder
    //-------------------------------
    wire [31:0] sum;
    
    ripple_carry_adder u_adder_32bit(
        .a(SrcA),
        .b(B_bar),
        .c_in(ALUControl[0]),
        .sum(sum),
        .c_out()
    );
    
    //-------------------------------
    //Flag
    //-------------------------------
    
    //Zero
    assign Z = (sum == 32'b0);
    
    //oVerflow
    wire V_tmp1;
    wire V_tmp2;
    wire V;
    
    assign V_tmp1 = (!(ALUControl[0] ^ SrcA[31] ^ SrcB[31])); //same sign addition or different sign subtraction
    assign V_tmp2 = (SrcA[31] ^ sum[31]); // Sign bit change after operation
    assign V = (V_tmp1 & V_tmp2 & (!ALUControl[1]));
    
    //SLT
    wire slt;
    assign slt = sum[31] ^ V;
    
    //-------------------------------
    //Result select MUX
    //-------------------------------
    always @(*)
    begin
        case(ALUControl[2:0])
            3'b000: result = sum; //Add
            3'b001: result = sum; //Sub
            3'b010: result = SrcA & SrcB; //And
            3'b011: result = SrcA | SrcB; //Or
            3'b101: result = {31'b0,slt}; //Slt
            default: result = 32'b0;
        endcase
    end    
endmodule