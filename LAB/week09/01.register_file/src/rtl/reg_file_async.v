module reg_file_async (
	input   clk,
	input	rst_n,
  input   we,
  input   [4:0] ra1, ra2, wa,
  input   [31:0] wd,
  output  [31:0] rd1, rd2
);

  parameter DEPTH = 32;
  reg [31:0] mem [0:31];

  //---------------------------------------
  //Read - async
  //---------------------------------------
  assign rd1 = mem[ra1];
  assign rd2 = mem[ra2];

  //---------------------------------------
  //Write - sync
  //---------------------------------------
  always @(negedge clk or negedge rst_n)
  begin
    if(!rst_n) begin
      mem[0] <= 32'h0;                    
    end
    else begin
      if(we)
        mem[wa] <= wd;                    
      else
        mem[wa] <= mem[wa];                    
    end
  end

  //---------------------------------------
  //Check reg file using waveform
  //---------------------------------------
  wire [31:0] x0  = mem[0];
  wire [31:0] x5  = mem[5];
  wire [31:0] x6  = mem[6];
  wire [31:0] x8  = mem[8];

endmodule
