`timescale 1ns / 1ps

module tb_alu_32bit();
    reg ALUSrc;
    reg [2:0] ALUControl;
    reg [31:0] signimm;
    reg [31:0] RD1;
    reg [31:0] RD2;
    wire [31:0] result;
    wire Z;

    //Instance top module as dut
    alu_32bit dut(
        .ALUSrc(ALUSrc),
        .ALUControl(ALUControl),
        .signimm(signimm),
        .RD1(RD1),
        .RD2(RD2),
        .result(result),
        .Z(Z)
    );

    initial
    begin
      		ALUSrc = 0; ALUControl = 3'b000; signimm = 32'h00007fff; RD1 = 32'd0; RD2 = 32'd0; 				
        #10 ALUSrc = 0; ALUControl = 3'b000; signimm = 32'h00007fff; RD1 = 32'd2; RD2 = 32'd5; //add : 2 + 5 = 7	
        #10 ALUSrc = 0; ALUControl = 3'b001; signimm = 32'h00007fff; RD1 = 32'd5; RD2 = 32'd2; //sub : 5 - 2  = 3
        #10 ALUSrc = 0; ALUControl = 3'b001; signimm = 32'h00007fff; RD1 = 32'd5; RD2 = 32'd5; //sub : 5 - 5  = 0 (Z = 1)
        #10 ALUSrc = 0; ALUControl = 3'b010; signimm = 32'h00007fff; RD1 = 32'd2; RD2 = 32'd5;	//and : 0010 & 0101 = 0000 
        #10 ALUSrc = 0; ALUControl = 3'b011; signimm = 32'h00007fff; RD1 = 32'd2; RD2 = 32'd5; //or  : 0010 | 0101 = 0111    
        #10 ALUSrc = 0; ALUControl = 3'b101; signimm = 32'h00007fff; RD1 = 32'd2; RD2 = 32'd5; //SLT : (2 < 5) = 1
        #10 ALUSrc = 1; ALUControl = 3'b000; signimm = 32'h00007fff; RD1 = 32'd1; RD2 = 32'dx; //lw, sw -> base-register address(addition) : 1 + 0x00007fff = 0x0010000
        #10 $finish;
    end
endmodule