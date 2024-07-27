/*
bitwise operation
- and : &   - or : |
- not : ~   - xor : ^
*/

module half_adder_1bit(
    input a,b,
    output s,c
    );
    
    assign s = a^b;
    assign c = a&b;

endmodule