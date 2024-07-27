`timescale 1ns/1ps

module testbench();
	reg  clk;
	reg  rst_n;
  reg  we;       
  reg  [4:0]  ra1;     
  reg  [4:0]  ra2;     
  reg  [4:0]  wa;     
  reg  [31:0] wd;     
  wire [31:0] rd1;     
  wire [31:0] rd2;     

  reg_file_async dut (
  	.clk      (clk),
    .rst_n    (rst_n),
    .we       (we),   //write enable  (WB stage)
    .ra1      (ra1),  //rs1           (ID stage)
    .ra2      (ra2),  //rs2           (ID stage)
    .wa       (wa),   //write address (WB stage)
    .wd       (wd),   //write data    (WB stage)
    .rd1      (rd1),  //read data     (ID stage)
    .rd2      (rd2)   //read data     (ID stage)
 );
  
  initial
  begin
    clk <= 1'b0;
    forever begin
      #5 clk <= ~clk;
    end
  end
  

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
                    we = 1'h0;  ra1 = 5'h0;   ra2 = 5'h0;   wa = 5'h0;  wd = 32'h0;  
    #5 wait(rst_n == 1'b1);

    //-------------------------------------------
    //read x0, x1 register
    @(posedge clk)  we = 1'h0;  ra1 = 5'h0;   ra2 = 5'h1;   wa = 5'h0;  wd = 32'h0;  
 
    //read x5, x6 register
    @(posedge clk)  we = 1'h0;  ra1 = 5'h5;   ra2 = 5'h6;   wa = 5'h0;  wd = 32'h0;  

    //write x5 <= 100 (wirte X - we = 0)
    @(posedge clk)  we = 1'h0;  ra1 = 5'h0;   ra2 = 5'h0;   wa = 5'h5;  wd = 32'd100;  

    //read x5, x5 register - check write O/X  - WRITE X is right 
    @(posedge clk)  we = 1'h0;  ra1 = 5'h5;   ra2 = 5'h5;   wa = 5'h0;  wd = 32'h0;  

    //write x5 <= 100 (write O - we = 1)
    @(posedge clk)  we = 1'h1;  ra1 = 5'h0;   ra2 = 5'h0;   wa = 5'h5;  wd = 32'd100;  

    //read x5, x5 register - check write O/X  - WRITE O is right
    @(posedge clk)  we = 1'h0;  ra1 = 5'h5;   ra2 = 5'h5;   wa = 5'h0;  wd = 32'h0;  

 
 
    //write x6 <= 200
    @(posedge clk)  we = 1'h1;  ra1 = 5'h0;   ra2 = 5'h0;   wa = 5'h6;  wd = 32'd200;  

    //read x5, x6 register
    @(posedge clk)  we = 1'h0;  ra1 = 5'h5;   ra2 = 5'h6;   wa = 5'h0;  wd = 32'h0;  

    //-------------------------------------------
    //read, write Both
    @(posedge clk)  we = 1'h1;  ra1 = 5'h5;   ra2 = 5'h7;   wa = 5'h8;  wd = 32'd300;  

    //read x8 register to check 
    @(posedge clk)  we = 1'h0;  ra1 = 5'h8;   ra2 = 5'h6;   wa = 5'h0;  wd = 32'h0;  


    @(negedge clk);
    @(negedge clk);
    $finish; 
  end

endmodule
