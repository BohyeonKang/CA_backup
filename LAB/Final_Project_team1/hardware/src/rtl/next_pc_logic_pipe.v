module next_pc_logic_pipe(
    input clk,
    input rst_n,
    input en,
    
    input [31:0] SignImmD,
    input [31:0] PCPlus4D,
    input [31:0] PCBranchD,
    input PCSrcD,
    output [31:0] PCPlus4F,
    output reg [31:0] pcF
    );
    
    parameter RESET_PC = 32'h0001_0000;
    
    wire [31:0] PCNext;
    wire [31:0] signimm_shift;
    assign signimm_shift = SignImmD << 2;
    
    ripple_carry_adder u_pc_plus_4(
        .a(pcF),
        .b(32'd4),
        .c_in(1'b0),
        .sum(PCPlus4F),
        .c_out()
    );
    
    //Instance
    //Single cycle : IF stage
    //Pipeline : ID or EXE... depending on the pipeline branch stage
    
    ripple_carry_adder u_pc_target(
        .a(PCPlus4D),
        .b(signimm_shift),
        .c_in(1'b0),
        .sum(PCBranchD),
        .c_out()
    );
    
    //PCNext signal
    //Single cycle : IF stage
    //Pipeline : ID or EXE... depending on the pipeline branch stage
    
    assign PCNext = (PCSrcD) ? PCBranchD : PCPlus4F;
    
    always @(posedge clk, negedge rst_n)
    begin
        if(!rst_n)
            pcF <= RESET_PC;
        else if(en)
            pcF <= PCNext;
    end
endmodule
