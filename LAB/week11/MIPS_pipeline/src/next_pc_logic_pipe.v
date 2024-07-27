module next_pc_logic_pipe(
    input clk,
    input rst_n,
    input [31:0] SignImmE,
    input [31:0] PCPlus4E,
    input [31:0] PCBranchM,
    input PCSrcM,
    
    output [31:0] PCPlus4F,
    output reg [31:0] pcF,
    output [31:0] PCBranchE
    );
    
    parameter RESET_PC = 32'h0001_0000;
    
    wire [31:0] PCNext;
    
    wire [31:0] signimm_shift;
    assign signimm_shift = SignImmE << 2;
    
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
        .a(PCPlus4E),
        .b(signimm_shift),
        .c_in(1'b0),
        .sum(PCBranchE),
        .c_out()
    );
    
    //PCNext signal
    //Single cycle : IF stage
    //Pipeline : ID or EXE... depending on the pipeline branch stage
    
    assign PCNext = (PCSrcM) ? PCBranchM : PCPlus4F;
    
    always @(posedge clk, negedge rst_n)
    begin
        if(!rst_n)
            pcF <= RESET_PC;
        else
            pcF <= PCNext;
    end
endmodule
