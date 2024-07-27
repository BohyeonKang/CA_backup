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
    wire RegWriteD;
    wire MemtoRegD;
    wire MemWriteD;
    wire BranchD;
    wire [2:0] ALUControlD;
    wire ALUSrcD;
    wire RegDstD;
    wire [31:0] PCBranchD;
    
    wire RegWriteE;
    wire MemtoRegE;
    wire MemWriteE;
    wire BranchE;
    wire [2:0] ALUControlE;
    wire ALUSrcE;
    wire RegDstE;
    
    wire RegWriteM;
    wire MemtoRegM;
    wire MemWriteM;
    wire BranchM;
    wire PCSrcM;
    
    wire RegWriteW;
    wire MemtoRegW;

    //hazard unit signal
    wire StallF, StallD;
    wire ForwardAD, ForwardBD;
    wire [1:0] ForwardAE, ForwardBE;
    wire FlushE;

    //datapath signal
    wire [31:0] pcF;
    wire [31:0] PCPlus4F;
    wire [31:0] instF;
    
    wire [31:0] PCPlus4D;
    wire [31:0] instD;
    wire [31:0] RD1D;
    wire [31:0] RD2D;
    wire [31:0] SignImmD;
    
    wire [31:0] instE;
    wire [31:0] RD1E;
    wire [31:0] RD2E; 
    wire        ZeroE;
    wire [31:0] ALUOutE;
    wire [31:0] WriteDataE;
    wire [4:0] WriteRegE;
    wire [31:0] SignImmE;
    wire [31:0] PCPlus4E;
    wire [31:0] PCBranchE;
    
    wire [31:0] instM;
    wire        ZeroM;
    wire [31:0] ALUOutM;
    wire [31:0] WriteDataM;
    wire [4:0] WriteRegM;
    wire [31:0] PCBranchM;
    wire [31:0] ReadDataM;
    
    wire [31:0] instW;
    wire [31:0] ALUOutW;
    wire [31:0] ReadDataW;
    wire [4:0] WriteRegW;
    wire [31:0] ResultW;
    
    
    //instance IF_ID register
    IF_ID_pipe_reg u_IF_ID_pipe_reg(
        .clk(clk),
        .rst_n(rst_n),
        .clr(PCSrcD),
        .en(~StallD),
        
        .i_inst(instF),
        .i_PCPlus4(PCPlus4F),
        .o_inst(instD),
        .o_PCPlus4(PCPlus4D)
    );
    //instance ID_EXE register
    ID_EXE_pipe_reg u_ID_EXE_pipe_reg(
        .clk(clk),
        .rst_n(rst_n),
        .clr(FlushE),
        
        .i_RegWrite(RegWriteD),
        .i_MemtoReg(MemtoRegD),
        .i_MemWrite(MemWriteD),
        .i_ALUControl(ALUControlD),
        .i_ALUSrc(ALUSrcD),
        .i_RegDst(RegDstD),
        .o_RegWrite(RegWriteE),
        .o_MemtoReg(MemtoRegE),
        .o_MemWrite(MemWriteE),
        .o_ALUControl(ALUControlE),
        .o_ALUSrc(ALUSrcE),
        .o_RegDst(RegDstE),
        
        .i_inst(instD),
        .i_RD1(RD1D),
        .i_RD2(RD2D),
        .i_signimm(SignImmD),
        .o_inst(instE),
        .o_RD1(RD1E),
        .o_RD2(RD2E),
        .o_signimm(SignImmE)
    );
    //instance EXE_MEM register
    EXE_MEM_pipe_reg u_EXE_MEM_pipe_reg(
        .clk(clk),
        .rst_n(rst_n),
        
        .i_RegWrite(RegWriteE),
        .i_MemtoReg(MemtoRegE),
        .i_MemWrite(MemWriteE),
        .o_RegWrite(RegWriteM),
        .o_MemtoReg(MemtoRegM),
        .o_MemWrite(MemWriteM),
        
        .i_inst(instE),
        .i_ALUOut(ALUOutE),
        .i_WriteData(WriteDataE),
        .i_WriteReg(WriteRegE),
        .o_inst(instM),
        .o_ALUOut(ALUOutM),
        .o_WriteData(WriteDataM),
        .o_WriteReg(WriteRegM)
    );
    //instance MEM_WB register
    MEM_WB_pipe_reg u_MEM_WB_pipe_reg(
        .clk(clk),
        .rst_n(rst_n),
        
        .i_RegWrite(RegWriteM),
        .i_MemtoReg(MemtoRegM),
        .o_RegWrite(RegWriteW),
        .o_MemtoReg(MemtoRegW),
        
        .i_inst(instM),
        .i_ALUOut(ALUOutM),
        .i_ReadData(ReadDataM),
        .i_WriteReg(WriteRegM),
        .o_inst(instW),
        .o_ALUOut(ALUOutW),
        .o_ReadData(ReadDataW),
        .o_WriteReg(WriteRegW)
    );

    //instance control_unit
    control_unit u_control_unit(
        .opcode     (instD[31:26]),
        .funct      (instD[5:0]),
        
        .RegWrite   (RegWriteD),
        .MemtoReg   (MemtoRegD),
        .MemWrite   (MemWriteD),
        .ALUControl (ALUControlD),
        .ALUSrc     (ALUSrcD),
        .RegDst     (RegDstD),
        .Branch     (BranchD)
    );

    //instance next_pc_logic
	next_pc_logic_pipe #(
        .RESET_PC    (RESET_PC)
    ) u_next_pc_logic_pipe(
		.clk        (clk),
        .rst_n      (rst_n),
        .en         (~StallF),
        
        .SignImmD   (SignImmD),
        .PCPlus4D   (PCPlus4D),
        .PCBranchD  (PCBranchD),
		.PCSrcD     (PCSrcD),		
		.PCPlus4F   (PCPlus4F),
		.pcF        (pcF)
    );

    //instance reg_file_async
	reg_file_async rf(
		.clk        (clk),
        .rst_n      (rst_n),
        .we         (RegWriteW),
        .ra1        (instD[25:21]), 
        .ra2        (instD[20:16]),
        .wa         (WriteRegW),
        .wd         (ResultW),
        .rd1        (RD1D), 
        .rd2        (RD2D)
	);

    //instance sign_extension
    sign_extension u_extension(
	    .imm        (instD[15:0]),
	    .signimm    (SignImmD)
    );

    //instance alu_32bit
    wire [31:0] tmpE1, tmpE2;
    assign tmpE1 = (ForwardAE == 2'b00) ? RD1E:
                   (ForwardAE == 2'b01) ? ResultW:
                   (ForwardAE == 2'b10) ? ALUOutM:
                   32'bx;
    assign tmpE2 = (ForwardBE == 2'b00) ? RD2E:
                   (ForwardBE == 2'b01) ? ResultW:
                   (ForwardBE == 2'b10) ? ALUOutM:
                   32'bx;
    alu_32bit u_alu(
        .ALUSrc     (ALUSrcE),
        .ALUControl (ALUControlE),
        .signimm    (SignImmE),
        .RD1        (tmpE1),
        .RD2        (tmpE2),
        .result     (ALUOutE),
        .Z          ()
    );

    //connect to memory 
    assign pc = pcF;
    assign instF = inst;
    assign WriteDataE = tmpE2;
    assign MemAddr  = ALUOutM;
    assign MemWData = WriteDataM;
    assign ReadDataM = MemRData;
    assign MemWrite = MemWriteM;

    //Set PCSrc 
    wire EqualD;
    wire [31:0] tmpD1, tmpD2;
    assign tmpD1 = (ForwardAD) ? ALUOutM : RD1D;
    assign tmpD2 = (ForwardBD) ? ALUOutM : RD2D;
    assign EqualD = (tmpD1 == tmpD2);
    assign PCSrcD = BranchD & EqualD;

    //instance write_back_data
	write_back_data u_write_back_data(
		.MemtoReg   (MemtoRegW),  
		.ALUResult  (ALUOutW),
		.ReadData   (ReadDataW),
		.Result     (ResultW)
	);
  
    //instance write_back_address
    write_back_address u_write_back_address(
	    .RegDst     (RegDstE), 	
        .instr      (instE),
        .WriteReg   (WriteRegE)
    );
    
    //instance hazard control unit
    hazard_unit u_hazard_unit(
        .BranchD(BranchD), 
        .MemtoRegE(MemtoRegE),
        .RegWriteE(RegWriteE), 
        .MemtoRegM(MemtoRegM), 
        .RegWriteM(RegWriteM), 
        .RegWriteW(RegWriteW),
        .RsD(instD[25:21]), 
        .RtD(instD[20:16]),
        .RsE(instE[25:21]), 
        .RtE(instE[20:16]),
        .WriteRegE(WriteRegE), 
        .WriteRegM(WriteRegM), 
        .WriteRegW(WriteRegW),
        .StallF(StallF),
        .StallD(StallD),
        .FlushE(FlushE),
        .ForwardAD(ForwardAD), 
        .ForwardBD(ForwardBD),
        .ForwardAE(ForwardAE), 
        .ForwardBE(ForwardBE)        
    );
endmodule