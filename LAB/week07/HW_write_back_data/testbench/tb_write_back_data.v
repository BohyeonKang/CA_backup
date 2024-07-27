`timescale 1ns / 1ps
module tb_write_back_data;
    reg [31:0] ALUResult, ReadData;
    reg MemtoReg;
    wire [31:0] Result;
    write_back_data dut(.ALUResult(ALUResult), .ReadData(ReadData), .MemtoReg(MemtoReg), .Result(Result));
    
    initial begin
        ALUResult = 32'hffffffff;
        ReadData = 32'h00000000;
        MemtoReg = 1'b0;
        #80 $finish;
    end
    
    always #40 MemtoReg = MemtoReg + 1;
endmodule
