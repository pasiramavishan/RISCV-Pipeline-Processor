module Main (
    input logic rstn, clk
); //result

    logic [31:0] nextAddr, PC_In, PC_out, instruction, instruction_out, PC_Out_next_decode, imm_data, ReadData1, ReadData2, branchAddr_next,
    instruction_out_func, Addr, branchAddr, ReadData1_out, ReadData2_out; // result;
    
	 logic [31:0] Extended_imm_out, ALU_A, ALU_B, result, ALU_B_prev, result_out, writeData, readData, writeData_reg, final_data, final_adress, write_dataForward;
    
	 logic branchOp, MemRead_decode, MemtoReg_decode, MemWrite_decode, branch_decode, ALUSrc, RegWrite_mem, RegWrite_execute,
    memRead, RegWrite_WB, RegWrite_decode, ALUSrc_decode, MemtoReg_mem, branch_next, finalSelect;
    logic MemRead_execute, MemtoReg_execute, MemWrite_execute, Branch_execute, Zero, Negative, zero_next, negative_next, MemWrite_out; 
    logic [6:0] opcode, OpForward; //branchOp
    logic [4:0] RS1, RS2, RD, rd_out_mem, rd_out_write, rd_out;
    logic [3:0] ALUOp_decode, ALUControl;
    logic [1:0] forwardA, forwardB;
    logic [1:0] ALUOp;
    logic [2:0] branchFunct;
    logic [4:0] rs1_out, rs2_out;
    
    Mux PC_Mux (
        .inp1(branchAddr_next), 
        .inp2(nextAddr),
        .sel(branchOp),
        .out(PC_In)
    );

    PC PC_Module(
        .clk(clk), 
        .rstn(rstn),
        .NextAddr(PC_In),
        .Addr(PC_out)
    );

    AdderPC PC_Adder(
        .Addr(PC_out), 
        .NextAddr(nextAddr)
    );

    InstructionMem instructionMemory(
        .rstn(rstn),
        .Addr(PC_out),
        .ReadData(instruction)
    );

    FetchDecodePipe Pipe1(
        .clk(clk),
        .rstn(rstn),
        .PC_Out(PC_out),
        .instruction(instruction),
        .PC_Out_next(PC_Out_next_decode),
        .instruction_out(instruction_out)
    );

    Instruction_Parser instructionDecoder(
        .instruction(instruction_out),
        .opcode(opcode),
        .rs1(RS1), 
        .rs2(RS2), 
        .rd(RD)
    );

    RegisterFile registers(
        .clk(clk), 
        .rstn(rstn), 
        .WriteEn(RegWrite_WB),
        .ReadAddr1(RS1), 
        .ReadAddr2(RS2), 
        .WriteAddr(rd_out_write),
        .WriteData(writeData_reg),
        .ReadData1(ReadData1), 
        .ReadData2(ReadData2)
    );

    ImmGen ImmDataExtactor(
        .Instruction(instruction_out),
        .rstn(rstn), 
        .Extended_imm(imm_data)
    );




    ControlUnit control(
        .Op(opcode),
        .RegWrite(RegWrite_decode),
        .ALUSrc(ALUSrc_decode), 
        .MemWrite(MemWrite_decode), 
        .Branch(branch_decode), 
        .MemRead(MemRead_decode), 
        .MemtoReg(MemtoReg_decode),
        .ALUOp(ALUOp_decode),
        .OpForward(OpForward)
    );


    DecodeExecutionPipe Pipe2(
        .stall(),
        .clk(clk), 
        .rstn(rstn),
        .RegWrite(RegWrite_decode), 
        .ALUSrc(ALUSrc_decode),
        .MemWrite(MemWrite_decode), 
        .Branch(branch_decode), 
        .MemRead(MemRead_decode), 
        .MemtoReg(MemtoReg_decode),
        .ALUOp(ALUOp_decode), 
        //.BranchOp(branch_decode),
        .PC(PC_Out_next_decode),
        .Extended_imm(imm_data),
        .ReadData1(ReadData1), 
        .ReadData2(ReadData2),
        .rs1(RS1), 
        .rs2(RS2),
        .rd(RD),
        .instruction(instruction_out),
        .rs1_out(rs1_out), 
        .rs2_out(rs2_out), 
        .rd_out(rd_out),
        .instruction_out(instruction_out_func), 
        .Extended_imm_out(Extended_imm_out),
        .ReadData1_out(ReadData1_out), 
        .ReadData2_out(ReadData2_out),
        .PC_next(Addr),
        .RegWrite_out(RegWrite_execute), 
        .ALUSrc_out(ALUSrc), 
        .MemWrite_out(MemWrite_execute), 
        .Branch_out(Branch_execute), 
        .MemRead_out(MemRead_execute), 
        .MemtoReg_out(MemtoReg_execute),
        .ALUOp_out(ALUOp)
        //.BranchOp_out(branch_execute)

    );

    ALUcontrol aluControl(
        .ALUOp(ALUOp),
        .funct3(instruction_out_func[14:12]),
        .funct7(instruction_out_func[31:25]),
        .op(instruction_out_func[6:0]),
        .ALUControl(ALUControl)
    );

    AdderBEQ adderBEQ(
        .Addr(Addr),
        .Extended_imm_out(Extended_imm_out),
        .NextAddr(branchAddr)
    );
    

    forwardingUnit forwardUnit(
        .rs1(rs1_out), 
        .rs2(rs2_out), 
        .rd_Mem(rd_out_mem), 
        .rd_Write(rd_out_write),
        .writeBackExe(RegWrite_mem), 
        .writeBackMem(RegWrite_WB),
        .forwardA(forwardA), 
        .forwardB(forwardB)
    );

    ALU_mux mux_A(
        .data1(ReadData1_out), 
        .data2(writeData_reg), 
        .data3(write_dataForward),
        .control(forwardA),
        .dataOut(ALU_A)
    );

    ALU_mux mux_B(
        .data1(ReadData2_out), 
        .data2(writeData_reg), 
        .data3(write_dataForward),
        .control(forwardB),
        .dataOut(ALU_B_prev)
    );

    Mux ALU_Mux_front (
        .inp1(Extended_imm_out), 
        .inp2(ALU_B_prev),
        .sel(ALUSrc),
        .out(ALU_B)
    );

    ALU alu(
        .rs1(ALU_A),
        .rs2(ALU_B),
        .ALUControl(ALUControl),
        .Zero(Zero), 
        .Negative(Negative),
        .ALUOut(result)
    );


//branchAddr_next
    executeMemPipe Pipe3 (
        .clk(clk),
        .rstn(rstn),
        .RegWrite(RegWrite_execute), 
        .MemtoReg(MemtoReg_execute),
        .Branch(Branch_execute), 
        .MemWrite(MemWrite_execute), 
        .MemRead(MemRead_execute),
        .Zero(Zero),
        .negative(Negative),
        .NextAddr(branchAddr), 
        .writeData(ALU_B_prev),
        .rd(rd_out),
        .funct3(instruction_out_func[14:12]),
        .result(result),
        .RegWrite_out(RegWrite_mem), 
        .MemtoReg_out(MemtoReg_mem),
        .Branch_out(branch_next), 
        .MemWrite_out(MemWrite_out),
        .MemRead_out(memRead),
        .Zero_out(zero_next),
        .negative_next(negative_next),
        .NextAddr_out(branchAddr_next), 
        .writeData_out(writeData),
        .rd_out(rd_out_mem),
        .result_out(result_out),
        .funct3_out(branchFunct)
    );

    BranchControl isBranch(
        .Branch(branch_next), 
        .Zero(zero_next), 
        .Negative(negative_next),
        .BranchOp(branchOp),
        .funct3(branchFunct)
    );

    DataMem dataMemory(
        .clk(clk), 
        .rstn(rstn), 
        .WriteEn(MemWrite_out), 
        .ReadEn(memRead),
        .Addr(result_out), 
        .WriteData(writeData),
        .ReadData(readData)
    ); 

   Mux forwardingMux (
        .inp1(readData), 
		  .inp2(result_out),
        .sel(MemtoReg_mem),
        .out(write_dataForward)
    );



    memoryWriteBackPipe Pipe4 (
        .readData(readData), 
        .rstn(rstn),
        .memAddress(result_out),
        .rd(rd_out_mem),
        .RegWrite(RegWrite_mem),
        .MemtoReg(MemtoReg_mem),
        .readData_out(final_data), 
        .memAddress_out(final_adress),
        .rd_out(rd_out_write),
        .RegWrite_out(RegWrite_WB),
        .MemtoReg_out(finalSelect),
        .clk(clk)
    );

    Mux MemRegMux (
        .inp1(final_data), 
        .inp2(final_adress),
        .sel(finalSelect),
        .out(writeData_reg)
    );
   
endmodule