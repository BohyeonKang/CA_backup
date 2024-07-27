`timescale 1ns/1ps

module multiplexer (
  input [3:0] a,
  input [3:0] b,
  input [3:0] c,
  input [3:0] d,
  input [1:0] sel,
  //output reg [3:0] out
  output [3:0] out
);

  //--------------------------------------------------
  //if-else
  //--------------------------------------------------
/*
  always @(*)
  //always @(a, b, c, d, sel)
  begin
    if(sel == 2'b00)
      out = a;
    else if(sel == 2'b01)
      out = b;
    else if(sel == 2'b10)
      out = c;
    else if(sel == 2'b11)
      out = d;
    else
      out = 4'b0000;
  end
*/

  //--------------------------------------------------
  //case
  //--------------------------------------------------
/*
  //always @(a, b, c, d, sel)
  always@(*) 
  begin
    case (sel)
	    2'b00:  out = a;
	    2'b01:	out = b;
	    2'b10:	out = c;
	    2'b11:	out = d;
	  default:  out = 4'b0000;
    endcase
  end
*/
  //--------------------------------------------------
  //conditional 
  //--------------------------------------------------
  assign out =  (sel == 2'b00) ? a:
                (sel == 2'b01) ? b:
                (sel == 2'b10) ? c:
                (sel == 2'b11) ? d: 4'b0000;

endmodule
