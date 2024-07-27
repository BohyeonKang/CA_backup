module full_adder_1bit_HA(
    input a,b,c_in,
    output s,c_out
    );
    
    wire sum1, carry1, carry2;
    
    half_adder_1bit U1(.a(a),.b(b),.s(sum1),.c(carry1));
    half_adder_1bit U2(.a(c_in),.b(sum1),.s(s),.c(carry2));
    assign c_out = carry1|carry2;
    
endmodule