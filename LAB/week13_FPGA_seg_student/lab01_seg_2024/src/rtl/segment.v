`timescale 1ns/1ps

module segment(
	input		clk,
  input   rst_n,
	output  [3:0] HEX_DIGIT,
  output  [7:0] HEX
);

	wire [3:0] i_HEX0; 
	wire [3:0] i_HEX1;
	wire [3:0] i_HEX2;
	wire [3:0] i_HEX3;
	wire [7:0] o_HEX0;
	wire [7:0] o_HEX1;
	wire [7:0] o_HEX2;
	wire [7:0] o_HEX3;
	
	assign i_HEX0 = 4'h2;
	assign i_HEX1 = 4'h0;
	assign i_HEX2 = 4'h2;
	assign i_HEX3 = 4'h4;

   //------LUT ---------------------
   SEG7_LUT u0_SEG7_LUT(
     .idata (i_HEX0),
     .oSEG  (o_HEX0)
   );

   SEG7_LUT u1_SEG7_LUT(
     .idata (i_HEX1),
     .oSEG  (o_HEX1)
   );

   SEG7_LUT u2_SEG7_LUT(
     .idata (i_HEX2),
     .oSEG  (o_HEX2)
   );

   SEG7_LUT u3_SEG7_LUT(
     .idata (i_HEX3),
     .oSEG  (o_HEX3)
   );

  //------clock divider --------
  wire clk_out;             

  clock_divider u_clock_divider (
    .clk_100MHz (clk),
    .rst_n      (rst_n),
    .clk_out    (clk_out)
  );
  
//------driver --------
	wire [3:0] digit;
	wire [7:0] segment;
	
	seg7driver driver(
		.clk		    (clk_out),    //1000Hz  //use this
		//.clk		    (clk),      //100MHz  
		.dataseg3	    (o_HEX3),
		.dataseg2	    (o_HEX2),
		.dataseg1       (o_HEX1),
		.dataseg0       (o_HEX0),
		.AN			    (digit),
		.segment	    (segment)
	);

	assign HEX_DIGIT = digit;
	assign HEX = segment;
     
endmodule
	
