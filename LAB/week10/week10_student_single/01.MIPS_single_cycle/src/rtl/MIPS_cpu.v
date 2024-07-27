module MIPS_cpu(
  input           clk,
  input           rst_n,
  output  [31:0]  pc,           //program counter for instruction fetch
  input   [31:0]  inst,         //incoming instruction

  output          MemWrite,     //control signal, 'memory write'
  output  [31:0]  MemAddr,      //memory access address
  output  [31:0]  MemWData,     //memory wirte data
  input   [31:0]  MemRData      //memory read data
);

  parameter RESET_PC = 32'h0001_0000;

  //control unit signal
  wire          MemtoReg;
  wire          Branch;
  wire [2:0]    ALUControl;
  wire          ALUSrc;
  wire          RegDst;
  wire          RegWrite;

  //add signal
  wire [31:0]   signimm;
  wire          zero;
  wire [31:0]   PCPlus4;
  wire [4:0]    WriteReg;
  wire [31:0]   ALUResult, ReadData, Result; //signal for write_back_data.v
  wire          PCSrc;
  wire [31:0] RD1, RD2;

  //instance control_unit
  control_unit u_control_unit(
    .opcode     (inst[31:26]),
    .funct      (inst[5:0]),

    .MemtoReg   (MemtoReg),
    .MemWrite   (MemWrite),
    .Branch     (Branch),
    .ALUControl (ALUControl),
    .ALUSrc     (ALUSrc),
    .RegDst     (RegDst),
    .RegWrite   (RegWrite)
  );

  //instance next_pc_logic
	next_pc_logic #(
    .RESET_PC    (RESET_PC)
  ) u_next_pc_logic(
		.clk        (clk),
    .rst_n      (rst_n),
    .signimm    (signimm),
		.PCSrc      (PCSrc),		
		.PCPlus4F   (PCPlus4),
		.pcF        (pc)
	);

  //instance reg_file_async
	reg_file_async rf(
		.clk        (clk),
    .rst_n      (rst_n),
    .we         (RegWrite),
    .ra1        (inst[25:21]), 
    .ra2        (inst[20:16]),
    .wa         (WriteReg),
    .wd         (Result),
    .rd1        (RD1), 
    .rd2        (RD2)
	);

  //instance sign_extension
  sign_extension u_extension(
	  .imm        (inst[15:0]),
	  .signimm    (signimm)
  );


  //instance alu_32bit
  alu_32bit u_alu(
    .ALUSrc     (ALUSrc),
    .ALUControl (ALUControl),
    .signimm    (signimm),
    .RD1        (RD1),
    .RD2        (RD2),
    .result     (ALUResult),
    .Z          (zero)
  );

  //connect to memory 
  assign MemAddr  = ALUResult;
  assign MemWData = RD2;

  //Set PCSrc 
  assign PCSrc = Branch & zero;

  //instance write_back_data
	write_back_data u_write_back_data(
		.MemtoReg   (MemtoReg),  
		.ALUResult  (ALUResult),
		.ReadData   (MemRData),
		.Result     (Result)
	);
  
  //instance write_back_address
  write_back_address u_write_back_address(
	  .RegDst     (RegDst), 	
    .instr      (inst),
    .WriteReg   (WriteReg)
  ); 

endmodule