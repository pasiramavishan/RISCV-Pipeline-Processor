module DecodeExecutionPipe (
    input logic clk, RegWrite, ALUSrc, MemWrite, Branch, MemRead, MemtoReg, rstn,
    input logic [1:0] ALUOp, //BranchOp,
    input logic [31:0] PC, 
    input logic [31:0] Extended_imm,
    input logic [31:0] ReadData1, ReadData2,
    input logic [4:0] rs1, rs2, rd,
  	input logic [31:0] instruction,
    output logic [4:0] rs1_out, rs2_out, rd_out,
    output logic [31:0] instruction_out, Extended_imm_out,
    output logic [31:0] ReadData1_out, ReadData2_out,
    output logic [31:0] PC_next,
    output logic RegWrite_out, ALUSrc_out, MemWrite_out, Branch_out, MemRead_out, MemtoReg_out,
    output logic [1:0] ALUOp_out //BranchOp_out

);

    always_ff @(posedge clk or negedge rstn) begin
        if(!rstn) begin
            RegWrite_out <= 0;
            ALUSrc_out <= 0;
            MemWrite_out <= 0;
            Branch_out <= 0;
            MemRead_out <= 0;
            MemtoReg_out <= 0;
            ALUOp_out <= 0;
            // BranchOp <= BranchOp_out;
            PC_next <= 0;
            ReadData1_out <= 0;
            ReadData2_out <= 0;
            rs1_out <= 0;
            rs2_out <= 0;
            rd_out <= 0;
            instruction_out <= 0;
            Extended_imm_out <= 0;  
        end else begin
            RegWrite_out <= RegWrite;
            ALUSrc_out <= ALUSrc;
            MemWrite_out <= MemWrite;
            Branch_out <=  Branch;
            MemRead_out <=  MemRead;
            MemtoReg_out <= MemtoReg;
            ALUOp_out <= ALUOp;
            // BranchOp <= BranchOp_out;
            PC_next <= PC;
            ReadData1_out <= ReadData1;
            ReadData2_out <= ReadData2;
            rs1_out <= rs1;
            rs2_out <= rs2;
            rd_out <= rd;
            instruction_out <= instruction;
            Extended_imm_out <= Extended_imm;       
        end
    end
    
endmodule