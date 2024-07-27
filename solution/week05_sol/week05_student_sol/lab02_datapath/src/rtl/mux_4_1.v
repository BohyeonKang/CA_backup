`timescale 1ns/1ps

module multiplexer(
  input [1:0] sel,
  input [7:0] a,
  input [7:0] b,
  input [7:0] c,
  input [7:0] d,
  output reg [7:0] result
);

  always @(*)
  begin
    case (sel)
      2'b00: result = a;
      2'b01: result = b;
      2'b10: result = c;
      2'b11: result = d;
      default: result = 4'b0000;
    endcase
  end

endmodule
