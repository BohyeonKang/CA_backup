`timescale 1ns / 1ps
module tb_control_unit;
    reg [31:0] inst_tb;
    
    wire MemtoReg_tb;
    wire MemWrite_tb;
    wire Branch_tb;
    wire [2:0] ALUControl_tb;
    wire ALUSrc_tb;
    wire RegDst_tb;
    wire RegWrite_tb;
    
    control_unit dut(
        .opcode(inst_tb[31:26]),
        .funct(inst_tb[5:0]),
        
        .MemtoReg(MemtoReg_tb),
        .MemWrite(MemWrite_tb),
        .Branch(Branch_tb),
        .ALUControl(ALUControl_tb),
        .ALUSrc(ALUSrc_tb),
        .RegDst(RegDst_tb),
        .RegWrite(RegWrite_tb)
    );
    
    initial begin
            inst_tb = 32'h0295_4020;    //add $t0, $s4, $s5 (pdf #14)
        #10 inst_tb = 32'h0295_4022;    //sub $t0, $s4, $s5
        #10 inst_tb = 32'h0295_4024;    //and $t0, $s4, $s5
        #10 inst_tb = 32'h0295_4025;    //or $t0, $s4, $s5
        #10 inst_tb = 32'h0295_402A;    //slt $t0, $s4, $s5
        
        #10 inst_tb = 32'h2230_0005;    //addi $s0, $s1, 5 (pdf #15)
        #10 inst_tb = 32'h8E93_FFE8;    //lw $s3, -24($s4) (pdf #18)
        #10 inst_tb = 32'hAE93_FFE8;    //sw $s3, -24($s4)
        #10 inst_tb = 32'h1100_0003;    //beq $t0, $0, else (pdf #22)
        
        #10 $finish;
    end
endmodule
