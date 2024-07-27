module nonBlocking(
    input clk,
    input a,
    output reg y
    );
    
    reg b;
    
    always @(posedge clk) begin
        b <= a;
        y <= b;
    end
endmodule