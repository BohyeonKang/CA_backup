module tb_ripple_carry_adder;

    reg [31:0] operand1;
    reg [31:0] operand2;
    reg cin;
    wire [31:0] sum;
    wire cout;

    ripple_carry_adder dut(
        .operand1(operand1),
        .operand2(operand2),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );

    initial begin
        operand1 = 32'b10001010101010000010001010000000;
        operand2 = 32'b01010101010101010101010101010101;
        cin = 1'b0;

        $display("Input operand1 = %b", operand1);
        $display("Input operand2 = %b", operand2);
        $display("Input cin = %b", cin);

        #100; 


        $display("Output sum = %b", sum);
        $display("Output cout = %b", cout);

        $finish;
    end
endmodule