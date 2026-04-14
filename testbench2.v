`timescale 1ns/1ps

module testbench;
    reg clk;
    reg rst;
    reg [1:0] wb;
    reg [2:0] mem;
    reg [31:0] npc;
    reg [31:0] readData1;
    reg [31:0] readData2;
    reg [31:0] signExtend;
    reg [31:0] instr;
    reg aluSrc;
    reg [1:0] aluOp;
    reg regDst;
    
    wire [1:0] writeBack;
    wire [2:0] memory;
    wire [31:0] adderResult;
    wire zero;
    wire [31:0] aluResult;
    wire [31:0] readData2ExMem;
    wire [4:0] regAddr;
    
    execute e0(
        .clk(clk),
        .rst(rst),
        .wb(wb),
        .mem(mem),
        .npc(npc),
        .readData1(readData1),
        .readData2(readData2),
        .signExtend(signExtend),
        .instr(instr),
        .aluSrc(aluSrc),
        .aluOp(aluOp),
        .regDst(regDst),
        .writeBack(writeBack),
        .memory(memory),
        .adderResult(adderResult),
        .zero(zero),
        .aluResult(aluResult),
        .readData2ExMem(readData2ExMem),
        .regAddr(regAddr)  
    );
    
    initial begin
        clk = 0;
        forever #5 clk =~clk;
    end
    
    initial begin 
        rst = 1;
        wb = 2'b0;
        mem = 3'b0;
        npc = 32'b0;
        readData1 = 32'b0;
        readData2 = 32'b0;
        signExtend = 32'b0;
        instr = 32'b0;
        aluSrc = 1'b0;
        aluOp = 2'b0;
        regDst = 1'b0;
        
        #1 
        rst = 0;
        
        #1 
        rst = 1;
        
        // R-Type Instruction, Add contents in Reg 0 and Reg 1 and store in Reg 2
        readData1 = 32'hABCD;
        readData2 = 32'h0001;
        aluOp = 2'b10;
        signExtend = 32'b00000000000000000000000000100000;
        instr = 32'b00000000000000010001000000100000;
        
        #10
        // I-Type Instruction, Load word from memory address 2
        readData1 = 32'h00000001;
        readData2 = 32'h00000002;
        aluOp = 2'b0;
        regDst = 1'b1;
        signExtend = 32'b00000000000000000000000000000010;
        instr = 32'b10001100000000010000000000000010;
        
        #10 
        //R-Type Instruction, OR contents in Reg 0 and Reg 1 and store in Reg 2
        readData1 = 32'hFFFFFFFE;
        readData2 = 32'h00000001;
        aluOp = 2'b10;
        regDst = 1'b0;
        signExtend = 32'b00000000000000000000000000100101;
        
        instr = 32'b00000000000000010001000000100101;
        
        #10
        // R-Type Instruction, AND contents in Reg 0 and Reg 1 and store in Reg 2
        readData1 = 32'hFFFFFFFE;
        readData2 = 32'h00000001;
        aluOp = 2'b10;
        regDst = 1'b0;
        signExtend = 32'bb00000000000000000000000000100100;
        instr = 32'b00000000000000010001000000100100;
        
        #20
        $finish;
    
    end



endmodule
