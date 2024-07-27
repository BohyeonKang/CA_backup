module mux4to1_if_else(
    input [1:0] sel,
    input [3:0] a, input [3:0] b, input [3:0] c, input [3:0] d,
    output reg [3:0] out
    );
    always @(*) begin
        if(sel==0) out = a;
        else if(sel==1) out = b;
        else if(sel==2) out = c;
        else if(sel==4) out = d;
        else out = 4'bx;
    end   
endmodule

module mux4to1_case(
    input [1:0] sel,
    input [3:0] a, input [3:0] b, input [3:0] c, input [3:0] d,
    output reg [3:0] out
    );
    always @(*) begin
        case(sel)
            0: out = a;
            1: out = b;
            2: out = c;
            3: out = d;
            default: out = 4'bx;
        endcase
    end   
endmodule

module mux4to1_conditional(
    input [1:0] sel,
    input [3:0] a, input [3:0] b, input [3:0] c, input [3:0] d,
    output [3:0] out
    );
    
    assign out =    (sel==0) ? a:
                    (sel==1) ? b:
                    (sel==2) ? c:
                    (sel==3) ? d:
                    4'bx;
endmodule