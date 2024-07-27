module hazard_unit(
    input reset,
    input BranchD, MemtoRegE, RegWriteE, MemtoRegM, RegWriteM, RegWriteW,
    input [4:0] RsD, RtD,
    input [4:0] RsE, RtE,
    input [4:0] WriteRegE, WriteRegM, WriteRegW,
    output reg StallF, StallD, FlushE,
    output reg [1:0] ForwardAD, ForwardBD,
    output reg [1:0] ForwardAE, ForwardBE 
    );
    
    reg branchstall, lwstall;
    
    //initialize
    always @(*)
    begin
        if(reset)
        begin
            ForwardAD = 2'b0;
            ForwardBD = 2'b0;
            ForwardAE = 2'b0;
            ForwardBE = 2'b0;
            StallF = 1'b0;
            StallD = 1'b0;
            FlushE = 1'b0;
        end
    end
    
    //Data Hazard
    always @(*)
    begin
        if((RsE!=0) & (RsE==WriteRegM) & RegWriteM)
            ForwardAE = 2'b10;
        else if((RsE!=0) & (RsE==WriteRegW) & RegWriteW)
            ForwardAE = 2'b01;
        else ForwardAE = 2'b00;
        
        if((RtE!=0) & (RtE==WriteRegM) & RegWriteM)
            ForwardBE = 2'b10;
        else if((RtE!=0) & (RtE==WriteRegW) & RegWriteW)
            ForwardBE = 2'b01;
        else ForwardBE = 2'b00;
        
        lwstall = ((RsD==RtE)|(RtD==RtE)) & MemtoRegE;
    end
    
    //control Hazard
    always @(*)
    begin
        ForwardAD = (RsD!=0) & (RsD == WriteRegM) & RegWriteM;
        ForwardBD = (RtD!=0) & (RtD == WriteRegM) & RegWriteM;
        
        branchstall = (BranchD & RegWriteE & ((WriteRegE == RsD)|(WriteRegE == RtD))) | (BranchD & MemtoRegM & ((WriteRegM == RsD)|(WriteRegM == RtD)));
        
        StallF = lwstall|branchstall;
        StallD = lwstall|branchstall;
        FlushE = lwstall|branchstall;
    end
endmodule