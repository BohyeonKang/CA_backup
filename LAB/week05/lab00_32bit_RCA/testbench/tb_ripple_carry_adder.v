`timescale 1ns/1ps

module tb_ripple_carry_adder();
  reg [31:0]  a_in;
  reg [31:0]  b_in;
  reg         carry_in;
  wire [31:0] sum_out;
  wire        carry_out;

  ripple_carry_adder dut (
    .a     (a_in),
    .b     (b_in),
    .cin 	 (carry_in),
    .sum   (sum_out),
    .cout	 (carry_out)
  );

  initial
    begin
          a_in = 32'd0; 		    b_in = 32'd0; 		carry_in = 1'b0;	//expected sum : 32'd0
      #10 a_in = 32'd1; 		    b_in = 32'd1; 		carry_in = 1'b0;	//32'd2
      #10 a_in = 32'd2; 		    b_in = 32'd5;		 	carry_in = 1'b1;	//32'd8
      #10 a_in = 32'd25; 	      b_in = 32'd30; 		carry_in = 1'b0;	//32'd55
      #10 a_in = 32'd100;       b_in = 32'd200; 	carry_in = 1'b1;	//32'd301
      #10 a_in = 32'd15520;     b_in = 32'd35000; carry_in = 1'b0;	//32'd50,520
      #10 a_in = 32'd10;        b_in = 32'b1010;  carry_in = 1'b0;	//32'd20
      #10 a_in = 32'd10;        b_in = 32'ha;     carry_in = 1'b1;	//32'd21
      #10 a_in = 32'hFFFFFFFF;  b_in = 32'd1; 		carry_in = 1'b0;	//32'h0000_0000 , cout = 1
      #10 a_in = 32'hFFFFFFFF;  b_in = 32'd5;     carry_in = 1'b0;	//32'd4 , cout = 1
      
      #10 a_in = 32'h0;         b_in = 32'd10;    carry_in = 1'b0;	//32'd10 , cout = 1
      #10 a_in = 32'h0;         b_in = 32'd100;   carry_in = 1'b0;	//32'd100 , cout = 1
    end

    initial
    begin
            $display("               32-bit Ripple Carry Adder");
        #5  $display("%t ns: %d + %d + %d / sum: %d c_out: %d", $time, a_in, b_in, carry_in, sum_out, carry_out);
        #10 $display("%t ns: %d + %d + %d / sum: %d c_out: %d", $time, a_in, b_in, carry_in, sum_out, carry_out);
        #10 $display("%t ns: %d + %d + %d / sum: %d c_out: %d", $time, a_in, b_in, carry_in, sum_out, carry_out);
        #10 $display("%t ns: %d + %d + %d / sum: %d c_out: %d", $time, a_in, b_in, carry_in, sum_out, carry_out);
        #10 $display("%t ns: %d + %d + %d / sum: %d c_out: %d", $time, a_in, b_in, carry_in, sum_out, carry_out);
	      #10 $display("%t ns: %d + %d + %d / sum: %d c_out: %d", $time, a_in, b_in, carry_in, sum_out, carry_out);
        #10 $display("%t ns: %d + %d + %d / sum: %d c_out: %d", $time, a_in, b_in, carry_in, sum_out, carry_out);
        #10 $display("%t ns: %d + %d + %d / sum: %d c_out: %d", $time, a_in, b_in, carry_in, sum_out, carry_out);
        #10 $display("%t ns: %h + %d + %d / sum: %d c_out: %d", $time, a_in, b_in, carry_in, sum_out, carry_out);
        #10 $display("%t ns: %d + %d + %d / sum: %d c_out: %d", $time, a_in, b_in, carry_in, sum_out, carry_out);
        
        #10 $display("%t ns: %d + %d + %d / sum: %d c_out: %d", $time, a_in, b_in, carry_in, sum_out, carry_out);
        #10 $display("%t ns: %d + %d + %d / sum: %d c_out: %d", $time, a_in, b_in, carry_in, sum_out, carry_out);        
        
        #10
        #10
        $finish;
    end


endmodule
