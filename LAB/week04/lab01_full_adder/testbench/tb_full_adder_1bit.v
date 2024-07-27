`timescale 1ns / 1ps
module tb_full_adder_1bit;
    reg a,b,c_in;
    wire sum, c_out;
    full_adder_1bit_optimized dut(.a(a),.b(b),.c_in(c_in),.sum(sum),.c_out(c_out));
    
    initial begin
        a=0; b=0; c_in=0;
        #160 $finish;
    end
    
    always #20 {a,b,c_in} = {a,b,c_in} + 1;
    
endmodule