module led_on_value(
    input clk,
    input rst_n,
    input [3:0] SW,
    input [3:0] BTN,
    output reg [3:0] LED
);

    always @(posedge clk, negedge rst_n)
    begin
        if(!rst_n)
            LED <= 4'b1111;
        else
        begin
            case(BTN)
                4'b0001:    LED <= 4'b0101;
                4'b0010:    LED <= SW;
                4'b0100:    LED <= ~SW;
                4'b1000:    LED <= 4'b1010;
            endcase
        end
    end
     
endmodule
	
