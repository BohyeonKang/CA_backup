`timescale 1ns/1ps

module testbench();
		parameter DWIDTH  = 32;
		parameter AWIDTH  = 12;
    parameter MIF_HEX = "code.hex";

		reg clk;
		reg [11:0]  fetch_addr;
		reg [11:0]  data_addr;

		reg [31:0]  write_data;
		reg         data_we;
		wire [31:0] imem_inst;
		wire [31:0] read_data;

    ASYNC_RAM_DP #(
      .DWIDTH (DWIDTH),
      .AWIDTH (AWIDTH),
      .MIF_HEX(MIF_HEX)
  	) imem (
    	.clk      (clk),

    	.addr0    (fetch_addr),       //PC
    	.we0      (1'b0),             //IM - read only
    	.d0       (32'd0),
    	.q0       (imem_inst),        //inst

    	.addr1    (data_addr),
    	.we1      (data_we),          //MemWrite
    	.d1       (write_data),
    	.q1       (read_data)
  	);

		initial clk = 0;
		always #(5) clk = ~clk;

    initial
    begin
				//Instruction Memory
        fetch_addr  = 12'd0; 					
				//Data Memory
				data_addr   = 12'd0; 					
				write_data  = 32'd0; 					
				data_we     = 1'd0; 					
    end

    initial
    begin
				//READ instruction from IM
        @(negedge clk) fetch_addr = 12'h0; 					
        @(negedge clk) fetch_addr = 12'h1; 			 		
        @(negedge clk) fetch_addr = 12'h2; 			 		
        @(negedge clk) fetch_addr = 12'h3; 			 		
        @(negedge clk) fetch_addr = 12'h6; 			 		

				//WRITE data from DM  - example case of SW instruction
				@(negedge clk)  data_addr = 12'h100;  write_data = 32'hFFFFFFFF; data_we = 1'b1;    //data_we = 1 means write
				@(negedge clk)  data_addr = 12'h101;  write_data = 32'hFFFFcafe; data_we = 1'b1;

        //READ data from DM   - example case of LW instruction
			  @(negedge clk)  data_addr = 12'h100; data_we = 1'b0;  //data_we = 0 means read
			  @(negedge clk)  data_addr = 12'h101; data_we = 1'b0;
			  @(negedge clk)  data_addr = 12'h102; data_we = 1'b0;  //read nothing

        @(negedge clk);
        @(negedge clk);
        $finish;
    end

endmodule
