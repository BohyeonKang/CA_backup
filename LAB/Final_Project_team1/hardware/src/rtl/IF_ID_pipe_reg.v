module IF_ID_pipe_reg(
    input clk,
    input rst_n,
    input clr,
    input en,
    input [31:0] i_inst,
    input [31:0] i_PCPlus4,
    output reg [31:0] o_inst,
    output reg [31:0] o_PCPlus4
    );
    
    always @(posedge clk, negedge rst_n)
    begin
        if(!rst_n|clr)
        begin
            o_inst <= 32'h0;
            o_PCPlus4 <= 32'h0;
        end
        else if(en)
        begin
            o_inst <= i_inst;
            o_PCPlus4 <= i_PCPlus4;
        end
    end    
endmodule