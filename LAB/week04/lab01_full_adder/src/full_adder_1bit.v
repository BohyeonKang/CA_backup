module full_adder_1bit_case(
    input a,b,c_in,
    output reg sum, reg c_out
    );
    always @(*) begin
        case({a,b,c_in})
            3'b000: {sum,c_out} = 2'b00;
            3'b001: {sum,c_out} = 2'b10;
            3'b010: {sum,c_out} = 2'b10;
            3'b011: {sum,c_out} = 2'b01;
            3'b100: {sum,c_out} = 2'b10;
            3'b101: {sum,c_out} = 2'b01;
            3'b110: {sum,c_out} = 2'b01;
            3'b111: {sum,c_out} = 2'b11;
            default: {sum,c_out} = 2'bx;
        endcase
    end
endmodule

module full_adder_1bit_twohalfadder(
    input a,b,c_in,
    output sum, c_out
    );
    wire sum1, c_tmp1, c_tmp2;
    assign sum1 = a^b;
    assign c_tmp1 = a&b;
    assign c_tmp2 = c_in&sum1;
    assign sum = c_in^sum1;
    assign c_out = c_tmp1 + c_tmp2;
endmodule

module full_adder_1bit_optimized(
    input a,b,c_in,
    output sum, c_out
    );
    wire xor1, and1, and2;
    assign xor1 = a^b;
    assign sum = xor1^c_in;
    assign and1 = xor1&c_in;
    assign and2 = a&b;
    assign c_out = and1 + and2;    
endmodule