`timescale 1ns / 1ps

module tb_write_back_address;
    reg RegDst;
    reg [31:0] instr;
    wire [4:0] WriteReg;

    write_back_address dut(.RegDst(RegDst),.instr(instr),.WriteReg(WriteReg));
    
    initial begin
        RegDst = 1'b0;
        instr = 32'h0295_4020;
        
        #80 $finish;      
    end
    always #40 RegDst = RegDst + 1;
    
endmodule
