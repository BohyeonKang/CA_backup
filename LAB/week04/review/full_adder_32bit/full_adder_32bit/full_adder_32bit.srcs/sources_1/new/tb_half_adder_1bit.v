`timescale 1ns / 1ps

module tb_half_adder_1bit;
    reg a,b;
    wire s,c;
    
    half_adder_1bit dut(.a(a),.b(b),.s(s),.c(c));
    
    initial begin
        a = 0; b = 0;
        #80 $finish;
    end
    
    always #20 {a,b} = {a,b} + 1;
    
endmodule
