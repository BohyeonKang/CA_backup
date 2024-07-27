module EXE_MEM_pipe_reg(
    input clk,
    input rst_n,

    //control signal
    input i_MemtoReg,
    input i_MemWrite,
    input i_Branch,
    input i_RegWrite,
    
    output reg o_MemtoReg,
    output reg o_MemWrite,
    output reg o_Branch,
    output reg o_RegWrite,
    
    //datapath signal
    input [31:0]    i_inst,
    input           i_Zero,
    input [31:0]    i_ALUOut,
    input [31:0]    i_WriteData,
    input [4:0]     i_WriteReg,
    input [31:0]    i_PCBranch,
    
    output reg [31:0]   o_inst,
    output reg          o_Zero,
    output reg [31:0]   o_ALUOut,
    output reg [31:0]   o_WriteData,
    output reg [4:0]    o_WriteReg,
    output reg [31:0]   o_PCBranch    
    );
    
    always @(posedge clk, negedge rst_n)
    begin
        if(!rst_n)
        begin
        //control signal
        o_MemtoReg <= 1'b0;
        o_MemWrite <= 1'b0;
        o_Branch <= 1'b0;
        o_RegWrite <= 1'b0;
        
        //datapath signal
        o_inst <= 32'h0;
        o_Zero <= 1'b0;
        o_ALUOut <= 32'h0;
        o_WriteData <= 32'h0;
        o_WriteReg <= 5'h0;
        o_PCBranch <= 32'h0;
        end
        else
        begin
        //control signal
        o_MemtoReg <= i_MemtoReg;
        o_MemWrite <= i_MemWrite;
        o_Branch <= i_Branch;
        o_RegWrite <= i_RegWrite;
        
        //datapath signal
        o_inst <= i_inst;
        o_Zero <= i_Zero;
        o_ALUOut <= i_ALUOut;
        o_WriteData <= i_WriteData;
        o_WriteReg <= i_WriteReg;
        o_PCBranch <= i_PCBranch;
        end
    end
endmodule
