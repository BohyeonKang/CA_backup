module write_back_data(
    input [31:0] ALUResult, ReadData,
    input MemtoReg,
    output [31:0] Result
    );
    assign Result = (MemtoReg==1'b0) ? ALUResult:
                    (MemtoReg==1'b1) ? ReadData :
                                       32'bx;                  
endmodule