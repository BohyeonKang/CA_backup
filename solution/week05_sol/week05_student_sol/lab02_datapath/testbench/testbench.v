`timescale 1ns/1ps

module testbench();

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
  //TO DO  1
  datapath dut(
    .clk    (clk),
    .rst_n  (rst_n),
 
    .start  (start_tb),
    .sel    (sel_tb),
    .a      (a_tb),
    .b      (b_tb),
    .c      (c_tb),
    .d      (d_tb),
    .ready  (ready_tb),
    .result (result_tb)
  );  

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
                  start_tb = 1'b0; a_tb = 8'h0;  b_tb = 8'h0;  c_tb = 4'h0; d_tb = 4'h0; sel_tb = 2'b00;
     #5
     wait(rst_n == 1'b1);

     //Example test-vector in lab PDF
     @(negedge clk)   start_tb = 1'b1; a_tb = 8'h0;  b_tb = 8'hFF;  c_tb = 4'h0; d_tb = 4'b1010; sel_tb = 2'b11;

     //Set your test-vector
     //TO DO 2
     @(negedge clk)   start_tb = 1'b0; a_tb = 8'h0;  b_tb = 8'h00;  c_tb = 4'h0; d_tb = 4'b0000; sel_tb = 2'b00;
     @(negedge clk)   start_tb = 1'b0; a_tb = 8'h0;  b_tb = 8'h00;  c_tb = 4'h0; d_tb = 4'b0000; sel_tb = 2'b00;
     #10;
  end

  initial
  begin
      $display("datapath test!!");
	    #100;
      $stop;
  end

endmodule
