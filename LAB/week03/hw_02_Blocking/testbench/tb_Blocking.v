`timescale 1ns / 1ps

module tb_Blocking;
    reg clk;
    reg a;
    wire y;
    
    Blocking dut(
    .clk(clk),
    .a(a),
    .y(y)
    );
    
    initial begin
        clk <= 1'b0;
        forever begin
            #5 clk <= ~clk;
        end
    end
    
    initial begin
            a = 0;
        #10 a = 1;
        #10 a = 0;
        #10 a = 1;
    end
    
    initial begin
        #10;
        #10;
        #10;
        #10; $stop;
    end
endmodule
