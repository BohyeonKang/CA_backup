`timescale 1ns/1ps

module testbench();
  reg         clk;
  reg         rst_n;
  reg  [2:0]  ALUControl;
  reg  [31:0] A_tb;
  reg  [31:0] B_tb;
  wire [31:0] Result_tb;
  wire N_tb,Z_tb,C_tb,V_tb;


  //Instance top module as dut
  //TO DO 1
  alu_32bit dut (
    .clk        (clk),
    .rst_n      (rst_n),
	  .ALUControl (ALUControl),
    .A          (A_tb),
    .B          (B_tb),
		.Result_reg (Result_tb),
		.N_reg      (N_tb),
		.Z_reg      (Z_tb),
		.C_reg      (C_tb),
		.V_reg      (V_tb)	
  );

  initial
  begin
    rst_n = 1'b1;
    #3 
    rst_n = 1'b0;
    #6
    //@(negedge clk);
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
      		           ALUControl = 3'b000; A_tb = 32'd0; B_tb = 32'd0; 				
      #5 wait(rst_n == 1'b1);
      
      //Example test-vector in lab PDF                                        //expected result
      @(negedge clk) ALUControl = 3'b000; A_tb = 32'd2; B_tb = 32'd5;         //add : 7	
      @(negedge clk) ALUControl = 3'b001; A_tb = 32'd2; B_tb = 32'd5; 				//sub : -3	    //N=1
      @(negedge clk) ALUControl = 3'b010; A_tb = 32'd2; B_tb = 32'd5;		 	  	//and : 0000 	  //0010, 0101 
      @(negedge clk) ALUControl = 3'b011; A_tb = 32'd2; B_tb = 32'd5; 				//or  : 0111    
      @(negedge clk) ALUControl = 3'b100; A_tb = 32'd2; B_tb = 32'd5; 				//xor : 0111
      @(negedge clk) ALUControl = 3'b101; A_tb = 32'd2;	B_tb = 32'd5; 				//SLT : 1       //sum[31]=1 
      @(negedge clk) ALUControl = 3'b110; A_tb = 32'd2;	B_tb = 32'd5; 				//rotate left : 0100(4)
      @(negedge clk) ALUControl = 3'b111; A_tb = 32'd2;	B_tb = 32'd5; 				//rotate right: 0001(1) 

      @(negedge clk) ALUControl = 3'b000; A_tb = 32'd3;           B_tb = 32'hFFFFFFFE;  //add : 3 + (-2) = 1	  //C=1	
      @(negedge clk) ALUControl = 3'b000; A_tb = 32'h7FFFFFFF;    B_tb = 32'h7FFFFFFF;  //add : (+) + (+) = (-) //V=1, N=1

      @(negedge clk) ALUControl = 3'b001; A_tb = 32'd3; 	        B_tb = 32'd3; 				//sub :	3 - (3) = 0		    //Z=1, C=1
      @(negedge clk) ALUControl = 3'b010; A_tb = 32'd3; 	        B_tb = 32'hFFFFFFFB;	//and	: 0011(32'd3)		    //0011, 1011  
      @(negedge clk) ALUControl = 3'b011; A_tb = 32'd3; 	        B_tb = 32'hFFFFFFFE; 	//or	: 1111(32'd-1)(N=1)	//0011, 1110
      @(negedge clk) ALUControl = 3'b100; A_tb = 32'd3;           B_tb = 32'hFFFFFFFE;  //xor : FFFF_FFF_1101(0xFFFF_FFFD)  //N=1, C=1(never mind)

      //Set your test-vector 
      //at least 1 ALUControl 1 case
      //TO DO 2
      @(negedge clk) ALUControl = 3'b000; A_tb = 32'd0; B_tb = 32'd0;         	


      @(negedge clk) $finish;
		end

  initial
  begin
      $display("32-bit ALU test!!");
	      #500;
      $stop;
  end


endmodule
