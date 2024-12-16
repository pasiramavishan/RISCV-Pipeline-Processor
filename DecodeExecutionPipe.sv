module DecodeExecutionPipe (
    input logic clk, RegWrite, ALUSrc, MemWrite, Branch, MemRead, rstn, Jump, Jalr, stall, ALUSrc_A,
    input logic [1:0] ALUOp, MemtoReg, BranchOp,
    input logic [31:0] PC, 
    input logic [31:0] Extended_imm,
    input logic [31:0] ReadData1, ReadData2,
    input logic [4:0] rs1, rs2, rd,
  	input logic [31:0] instruction,
    output logic [4:0] rs1_out, rs2_out, rd_out,
    output logic [31:0] instruction_out, Extended_imm_out,
    output logic [31:0] ReadData1_out, ReadData2_out,
    output logic [31:0] PC_next, PC_jump,
    output logic RegWrite_out, ALUSrc_out, MemWrite_out, Branch_out, MemRead_out, Jump_out, Jalr_out, ALUSrc_out_A,
    output logic [1:0] ALUOp_out, MemtoReg_out //BranchOp_out

);  
    logic flush;
    
    assign flush = (BranchOp == 2'b00 || BranchOp == 2'b10) ? 1'b1 : 1'b0;

    always_ff @(posedge clk or negedge rstn) begin
        if(!rstn) begin
            RegWrite_out <= 0;
            ALUSrc_out <= 0;
            MemWrite_out <= 0;
            Branch_out <= 0;
            MemRead_out <= 0;
            MemtoReg_out <= 1;
            ALUOp_out <= 0;
            ALUSrc_out_A <= 0;
            // BranchOp <= BranchOp_out;
            PC_next <= 0;
            ReadData1_out <= 0;
            ReadData2_out <= 0;
            rs1_out <= 0;
            rs2_out <= 0;
            rd_out <= 0;
            instruction_out <= 32'b00000000000000000000000000010011;
            PC_jump <= 0;
            Extended_imm_out <= 0; 
            Jump_out <= 0;
            Jalr_out <= 0;
        end else begin
		  
		  if (flush) begin
			  RegWrite_out <= 0;
					ALUSrc_out <= 0;
					MemWrite_out <= 0;
					Branch_out <= 0;
					MemRead_out <= 0;
					MemtoReg_out <= 1;
					ALUOp_out <= 0;
                    ALUSrc_out_A <= 0;
					// BranchOp <= BranchOp_out;
					PC_next <= 0;
					ReadData1_out <= 0;
					ReadData2_out <= 0;
					rs1_out <= 0;
					rs2_out <= 0;
					rd_out <= 0;
					instruction_out <= 32'b00000000000000000000000000010011;
					PC_jump <= 0;
					Extended_imm_out <= 0; 
					Jump_out <= 0;
					Jalr_out <= 0;
			  
			  end
			else if (!stall) begin
            RegWrite_out <= RegWrite;
            ALUSrc_out <= ALUSrc;
            MemWrite_out <= MemWrite;
            Branch_out <=  Branch;
            MemRead_out <=  MemRead;
            MemtoReg_out <= MemtoReg;
            ALUOp_out <= ALUOp;
            ALUSrc_out_A <= ALUSrc_A;
            // BranchOp <= BranchOp_out;
            PC_next <= PC;
            PC_jump <= PC;
            ReadData1_out <= ReadData1;
            ReadData2_out <= ReadData2;
            rs1_out <= rs1;
            rs2_out <= rs2;
            rd_out <= rd;
            instruction_out <= instruction;
            Extended_imm_out <= Extended_imm;
            Jump_out <= Jump;
            Jalr_out <= Jalr; 
			end
		end
    end
    
endmodule