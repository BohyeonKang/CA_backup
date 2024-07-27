`timescale 1ns / 1ps
module tb_sign_extension;
    
    reg [15:0] imm_tb;
    wire [31:0] signimm_tb;
    
    sign_extension dut(.imm(imm_tb),.signimm(signimm_tb));
    
    initial begin
            imm_tb = 16'hffff;
        #10 imm_tb = 16'hf000;
        #10 imm_tb = 16'h0000;
        #10 imm_tb = 16'h000f;
        #10 $finish;
    end
endmodule