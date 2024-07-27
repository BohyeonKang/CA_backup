`timescale 1ns / 1ps

module tb_mux4to1;
    reg [3:0] a,b,c,d;
    reg [1:0] sel;
    wire [3:0] out;
        
    mux4to1_case dut(.sel(sel),.a(a),.b(b),.c(c),.d(d),.out(out));
    
    initial begin
        sel = 2'b00;
        a = 4'b0001; b = 4'b0010;
        c = 4'b0100; d = 4'b1000;
        
        #80 $finish;      
    end
    always #20 sel = sel+1;
    
endmodule
