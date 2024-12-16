module Main (
    input logic rstn, clk50,
	 input logic [4:0] sel,
	 output logic [6:0] seg1, seg2, seg3, seg4,
	 output logic [8:0] LED_out
); //result

    logic [31:0] JumpAddr, nextAddr, PC_In, PC_out, instruction, instruction_out, PC_Out_next_decode, imm_data, ReadData1, ReadData2, branchAddr_next,
    instruction_out_func, Addr, branchAddr, ReadData1_out, ReadData2_out, Jump_addr, Jump_addr_out, Jump_toMux; // result;
    
	logic [31:0] Extended_imm_out, ALU_A, ALU_A_prev, ALU_B, result, ALU_B_prev, result_out, writeData, writeData_dup, readData, readData_Med, writeData_reg, final_data, final_adress, write_dataForward;
    
	logic Overflow, Overflow_out, MemRead_decode, MemWrite_decode, branch_decode, ALUSrc, RegWrite_mem, RegWrite_execute, Jump_toBC, Jalr_toBC,
    memRead, RegWrite_WB, RegWrite_decode, ALUSrc_decode, ALUSrc_decode_A, branch_next, Jump, Jalr, Jump_out, Jalr_out, stal;
    logic MemRead_execute, MemWrite_execute, Branch_execute, Zero, Negative, zero_next, negative_next, MemWrite_out; 
    logic [6:0] opcode, OpForward; //branchOp
    logic [4:0] RS1, RS2, RD, rd_out_mem, rd_out_write, rd_out;
    logic [3:0]  ALUControl;
    logic [1:0] forwardA, forwardB;
    logic [1:0] ALUOp_decode, ALUOp, branchOp, finalSelect, MemtoReg_execute, MemtoReg_decode, MemtoReg_mem, ALUSrc_A;
    logic [2:0] branchFunct;
    logic [4:0] rs1_out, rs2_out;
	 logic [31:0] registerOut [31:0];
	 
    
    // Mux PC_Mux (
    //     .inp1(branchAddr_next), 
    //     .inp2(nextAddr),
    //     .sel(branchOp),
    //     .out(PC_In)
    // );


    /* clock_divide_half clock(
        .clk50(clk50), 
        .rstn(rstn),
        .clk(clk)
    ); */
	
	clock_divider_divider clock (
		 .clk50(clk50),     // 50 MHz input clock
		 .reset(rstn),      // Asynchronous reset
		 .clk(clk)    // 10 MHz output clock
	);

    ALU_mux PC_Mux(
        .data1(branchAddr_next),
        .data2(nextAddr),
        .data3(result_out),
        .control(branchOp),
        .dataOut(PC_In)
    );

    PC PC_Module(
		  .stall(stall),
        .clk(clk), 
        .rstn(rstn),
        .NextAddr(PC_In),
        .Addr(PC_out),
		  .JumpAddr(JumpAddr)
        // .BranchOp(branchOp)
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
		  .stall(stall),
        .clk(clk),
        .rstn(rstn),
        .PC_Out(PC_out),
        .instruction(instruction),
        .PC_Out_next(PC_Out_next_decode),
        .instruction_out(instruction_out),
        .BranchOp(branchOp)
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
        .ReadData2(ReadData2),
		  .registerOut(registerOut)
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
        .ALUSrc_A(ALUSrc_decode_A),
        .MemWrite(MemWrite_decode), 
        .Branch(branch_decode), 
        .MemRead(MemRead_decode), 
        .MemtoReg(MemtoReg_decode),
        .ALUOp(ALUOp_decode),
        .OpForward(OpForward),
        .Jump(Jump), 
        .Jalr(Jalr)
    );
	 
	 FourDigitSevenSegmentDisplay display (
        .number(registerOut[sel]),       // Input: 4-digit number (16 bits, max value 9999)
        .seg1(seg1),				// Output for rightmost digit
        .seg2(seg2),         // Output for second digit
        .seg3(seg3),         // Output for third digit
        .seg4(seg4),
        .number_out(LED_out)	 // Output for leftmost digit
    );


    DecodeExecutionPipe Pipe2(
	     .stall(stall),
        .clk(clk), 
        .rstn(rstn),
        .RegWrite(RegWrite_decode), 
        .ALUSrc(ALUSrc_decode),
        .ALUSrc_A(ALUSrc_decode_A),
        .MemWrite(MemWrite_decode), 
        .Jump(Jump),
        .Jalr(Jalr),
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
        .PC_jump(Jump_addr),
        .RegWrite_out(RegWrite_execute), 
        .ALUSrc_out(ALUSrc), 
        .ALUSrc_out_A(ALUSrc_A),
        .MemWrite_out(MemWrite_execute), 
        .Branch_out(Branch_execute), 
        .MemRead_out(MemRead_execute), 
        .MemtoReg_out(MemtoReg_execute),
        .ALUOp_out(ALUOp),
        .Jump_out(Jump_out),
        .Jalr_out(Jalr_out),
        .BranchOp(branchOp)
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
	 
	 stall stallingUnit(
		 .rd(rd_out_mem), 
		 .rs1(rs1_out), 
		 .rs2(rs2_out),
		 .memToReg(MemtoReg_mem),
		 .stall(stall)
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

    // forwardingUnit forwardUnit(
    //     .rs1(rs1_out), 
    //     .rs2(rs2_out), 
    //     .rd_Mem(rd_out_mem), 
    //     .rd_Write(rd_out_write),
    //     .writeBackExe(RegWrite_mem), 
    //     .writeBackMem(RegWrite_WB),
    //     .ALUSrc(ALUSrc),
    //     .forwardA(forwardA), 
    //     .forwardB(forwardB)
    // );

    ALU_mux mux_A(
        .data1(ReadData1_out), 
        .data2(writeData_reg), 
        .data3(result_out),
        .control(forwardA),
        .dataOut(ALU_A_prev)
    );

    // ALU_mux ALU_Mux_front_A (
    //     .inp1(0'b0), 
    //     .inp2(ALU_A_prev),
    //     .sel(ALUSrc_A),
    //     .out(ALU_A)
    // );

    ALU_mux ALU_Mux_front_A(
        .data1(ALU_A_prev), 
        .data2(Addr), 
        .data3(32'b0),
        .control(ALUSrc_A),
        .dataOut(ALU_A)
    );

    ALU_mux mux_B(
        .data1(ReadData2_out), 
        .data2(writeData_reg), 
        .data3(result_out),
        .control(forwardB),
        .dataOut(ALU_B_prev)
    );

    Mux ALU_Mux_front_B (
        .inp1(Extended_imm_out), 
        .inp2(ALU_B_prev),
        .sel(ALUSrc),
        .out(ALU_B)
    );

// mux_4 mux_B(
//     .data0(ReadData2_out), 
//     .data1(writeData_reg), 
//     .data2(result_out), 
//     .data3(Extended_imm_out), 
//     .control(forwardB),                
//     .dataOut(ALU_B)                  
// );

    ALU alu(
        .rs1(ALU_A),
        .rs2(ALU_B),
        .ALUControl(ALUControl),
        .Zero(Zero), 
        .Negative(Negative),
        .ALUOut(result),
        .Overflow(Overflow)
    );


//branchAddr_next
    executeMemPipe Pipe3 (
	     .stall(stall),
        .clk(clk),
        .rstn(rstn),
        .RegWrite(RegWrite_execute), 
        .MemtoReg(MemtoReg_execute),
        .Branch(Branch_execute), 
        .MemWrite(MemWrite_execute), 
        .MemRead(MemRead_execute),
        .Zero(Zero),
        .Overflow(Overflow),
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
        .Overflow_out(Overflow_out),
        .negative_next(negative_next),
        .NextAddr_out(branchAddr_next), 
        .writeData_out(writeData),
        .rd_out(rd_out_mem),
        .result_out(result_out),
        .funct3_out(branchFunct),
        .Jump_addr(Jump_addr),
        .Jump_addr_out(Jump_addr_out),
        .Jump(Jump_out), 
        .Jump_out(Jump_toBC), 
        .Jalr(Jalr_out), 
        .Jalr_out(Jalr_toBC),
        .BranchOp(branchOp)
    );

    BranchControl isBranch(
        .Branch(branch_next), 
        .Zero(zero_next), 
        .Overflow(Overflow_out),
        .Negative(negative_next),
        .BranchOp(branchOp),
        .funct3(branchFunct),
        .Jump(Jump_toBC), 
        .Jalr(Jalr_toBC)
    );

    // storeControl storeController(
    //     .MemWrite(MemWrite_out),
    //     .funct3(branchFunct),
    //     .InputData(writeData_dup), 
    //     .WriteData(writeData)
    // );


    DataMem dataMemory(
        .clk(clk), 
        .rstn(rstn), 
        .WriteEn(MemWrite_out), 
        .ReadEn(memRead),
        .funct3(branchFunct),
        .Addr(result_out), 
        .WriteData(writeData),
        .ReadData(readData_Med)
    );

    Loadcontrol loadcontrol(
        .MemRead(memRead),
        .funct3(branchFunct),
        //.funct7(),
        .InputData(readData_Med), 
        .WriteData(readData)
    );

    memoryWriteBackPipe Pipe4 (
	     //.stall(1),
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
        //.Jump_addr(Jump_addr_out),
        //.Jump_addr_out(Jump_toMux)
    );

    ALU_mux MemRegMuxr(
        .data1(final_data),
        .data2(final_adress),
        .data3(Jump_addr_out),
        .control(finalSelect),
        .dataOut(writeData_reg)
    );
endmodule