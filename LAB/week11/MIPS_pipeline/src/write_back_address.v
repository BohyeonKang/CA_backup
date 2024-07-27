module write_back_address(
    input RegDst,
    input [31:0] instr,
    output [4:0] WriteReg
    );
    
    wire [4:0] tmp1, tmp2;
    assign tmp1 = instr[20:16];
    assign tmp2 = instr[15:11];
    
    assign WriteReg = (RegDst == 1'b0) ? tmp1:
                      (RegDst == 1'b1) ? tmp2:
                      32'bx;

endmodule
