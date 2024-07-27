`timescale 1ns/1ps

module tb_datapath;

    reg clk;
    reg rst_n;
    reg start_tb;
    reg  [1:0]  sel_tb;
    reg  [7:0]  a_tb;
    reg  [7:0]  b_tb;
    reg  [3:0]  c_tb;
    reg  [3:0]  d_tb;
    wire        ready_tb;
    wire [7:0]  result_tb;

  //instance top module
  datapath dut(.clk(clk),.rst_n(rst_n),.start(start_tb),.a(a_tb),.b(b_tb),.c(c_tb),.d(d_tb),.sel(sel_tb),.ready(ready_tb),.result_tb(result_tb));

  initial
  begin
    rst_n = 1'b1;
    #3 
    rst_n = 1'b0;
    @(negedge clk);
    rst_n = 1'b1;
  end

  initial
  begin
    clk <= 1'b0;
    forever begin
      #5 clk <= ~clk;
    end
  end

  initial
  begin
         start_tb = 1'b1; a_tb = 8'h0;  b_tb = 8'h0;  c_tb = 4'h0; d_tb = 4'h0; sel_tb = 2'b00;
     //Set your test-vector
     //TO DO 2
     #20  start_tb = 1'b1; a_tb = 8'b10100101;  b_tb = 8'b01100001;  c_tb = 4'b1010; d_tb = 4'b0110; sel_tb = 2'b00;
     #10 start_tb = 1'b1; a_tb = 8'b10100101;  b_tb = 8'b01100001;  c_tb = 4'b1010; d_tb = 4'b0110; sel_tb = 2'b01;
     #10 start_tb = 1'b1; a_tb = 8'b10100101;  b_tb = 8'b01100001;  c_tb = 4'b1010; d_tb = 4'b0110; sel_tb = 2'b10;
     #10 start_tb = 1'b1; a_tb = 8'b10100101;  b_tb = 8'b01100001;  c_tb = 4'b1010; d_tb = 4'b0110; sel_tb = 2'b11;
  end

  initial
  begin
      $display("datapath test!!");
	    #50;
      $stop;
  end

endmodule
