`timescale 1ns / 1ps

module tb_not_gate_dff;
    reg clk;
    reg rst_n;
    reg in;
    wire out;
    
    not_gate_dff dut(
    .clk(clk),
    .rst_n(rst_n),
    .in(in),
    .out(out)
    );
    
    initial begin
        rst_n = 1'b1;
        #3
        rst_n = 1'b0;
        @(negedge clk);
        rst_n = 1'b1;
    end
    
    initial begin
        clk <= 1'b0;
        forever begin
            #5 clk <= ~clk;
        end
    end
    
    initial begin
        in = 0;
        #10 in = 1;
        #10 in = 0;
        #10 in = 1;
    end
    
    initial begin
            //$display();
        #10; //$display();
        #10; //$display();
        #10; //$display();
        #10; $stop;
    end
endmodule
