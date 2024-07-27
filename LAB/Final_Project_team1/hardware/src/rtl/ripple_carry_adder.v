module ripple_carry_adder(
    input [31:0] a,b,
    input c_in,
    output [31:0] sum,
    output c_out
    );
    wire [31:0] c;
    
    full_adder FA(.a(a[0]),.b(b[0]),.c_in(c_in),.sum(sum[0]),.c_out(c[0]));
    
    genvar i;
    generate
        for(i=1;i<32;i=i+1) begin
            full_adder FA(.a(a[i]),.b(b[i]),.c_in(c[i-1]),.sum(sum[i]),.c_out(c[i]));
        end    
    endgenerate
    assign c_out = c[31];    
endmodule