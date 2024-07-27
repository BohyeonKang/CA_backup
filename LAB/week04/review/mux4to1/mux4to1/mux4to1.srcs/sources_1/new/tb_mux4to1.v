`timescale 1ns / 1ps

module tb_mux4to1;
    reg [3:0] a,b,c,d;
    reg [1:0] sel;
    wire [3:0] y;

    mux4to1_case dut(.a(a),.b(b),.c(c),.d(d),.sel(sel),.y(y));
    
    initial begin
        a = 4'b0001; b = 4'b0010;
        c = 4'b0100; d = 4'b1000;
        sel = 0;
        
        #80 $finish;
    end
    
    always #20 sel = sel + 1;

endmodule
