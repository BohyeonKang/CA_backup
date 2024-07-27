module not_gate_dff(
    clk,
    rst_n,
    in,
    out
);

    input clk;
    input rst_n;
    input in;
    output out;
    
    reg sig1;
    wire sig2;
    reg sig3;
    
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)
            sig1 <= 1'b0;
        else
            sig1 <= in;
    end
    
    assign sig2 = ~sig1;
    
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)
            sig3 <= 1'b0;
        else
            sig3 <= sig2;
    end
    
    assign out = sig3;
    
endmodule