// List of MIPS opcodes and funct codes.
// Use `include "opcode.vh" to use these in the decoder

`ifndef OPCODE
`define OPCODE

// ***** Opcodes *****

// Arithmetic instructions
`define OPC_ARI_RTYPE   6'b000000


// Special immediate instructions
`define OPC_ADDI        6'b001000
`define OPC_BEQ         6'b000100
`define OPC_LW          6'b100011
`define OPC_SW          6'b101011

// Jump instructions
`define OPC_JAL         6'b000011


// ***** Function codes *****

// Arithmetic R-type and I-type functions codes
`define FNC_ADD         6'b100000
`define FNC_SUB         6'b100010
`define FNC_AND         6'b100100
`define FNC_OR          6'b100101
`define FNC_SLT         6'b101010

// ADD and SUB use the same opcode + function code
// SRA and SRL also use the same opcode + function code
// For these operations, we also need to look at bit 30 of the instruction
`define FNC2_ADD        1'b0
`define FNC2_SUB        1'b1
`define FNC2_SRL        1'b0
`define FNC2_SRA        1'b1

`define FNC7_0  7'b0000000 // ADD, SRL
`define FNC7_1  7'b0100000 // SUB, SRA
`endif //OPCODE
