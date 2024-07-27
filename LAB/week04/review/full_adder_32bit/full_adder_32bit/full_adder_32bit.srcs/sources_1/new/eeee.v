module full_adder(
    input a, b, cin,
    output sum, cout
);

    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (a & cin) | (b & cin);

endmodule

module ripple_carry_adder(
    input [31:0] operand1,
    input [31:0] operand2,
    input cin,
    output [31:0] sum,
    output cout
);

    wire [31:0] carry;
    
    full_adder fa0(.a(operand1[0]),.b(operand2[0]),.cin(cin),.sum(sum[0]),.cout(carry[0]));
    
    genvar i;
    generate
        for(i=1;i<32;i=i+1) begin
            full_adder fa(.a(operand1[i]),.b(operand2[i]),.cin(carry[i-1]),.sum(sum[i]),.cout(carry[i]));
        end
    endgenerate    


    assign cout = carry[31];

endmodule
