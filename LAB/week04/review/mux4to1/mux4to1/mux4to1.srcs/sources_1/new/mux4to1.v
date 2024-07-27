module mux4to1_conditional(
    input [3:0] a,b,c,d,
    input [1:0] sel,
    output [3:0] y
    );
    
    assign y = (sel==0) ?   a:
               (sel==1) ?   b:
               (sel==2) ?   c:
               (sel==3) ?   d:
               4'bx;    
endmodule

module mux4to1_if(
    input [3:0] a,b,c,d,
    input [1:0] sel,
    output reg [3:0] y
    );
    
    always @(*) begin
        if(sel==0)      y = a;
        else if(sel==1) y = b;
        else if(sel==2) y = c;
        else if(sel==3) y = d;
        else            y = 4'bx;
    end
endmodule

module mux4to1_case(
    input [3:0] a,b,c,d,
    input [1:0] sel,
    output reg [3:0] y
    );
    
    always @(*) begin
        case(sel)
            0: y = a;
            1: y = b;
            2: y = c;
            3: y = d;
            default: y = 4'bx;
        endcase
    end    
endmodule