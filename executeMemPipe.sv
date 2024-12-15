module executeMemPipe (
    input logic clk, rstn,
    input logic RegWrite, Branch, MemWrite, MemRead, MemtoReg,
    input logic Zero, negative, negative_next,
  	input logic [31:0] NextAddr, writeData, result,
    input logic [4:0] rd,
    input logic [2:0] funct3,
    output logic RegWrite_out, Branch_out, MemWrite_out, MemRead_out, MemtoReg_out,
    output logic Zero_out,
    output logic [31:0] NextAddr_out, writeData_out,
    output logic [4:0] rd_out,
    output logic [31:0] result_out,
    output logic [2:0] funct3_out
);
    always_ff @(posedge clk or negedge rstn) begin
        if(!rstn) begin
            RegWrite_out <= 0; 
            Branch_out <= 0;
            MemWrite_out <= 0;
            MemRead_out <= 0;
            Zero_out <= 0;
            NextAddr_out <= 0;
            writeData_out <= 0;
            rd_out <= 0;
            MemtoReg_out <= 0;
				    funct3_out <= 0;
        end else begin
            RegWrite_out <= RegWrite; 
            Branch_out <= Branch;
            MemWrite_out <= MemWrite;
            MemRead_out <= MemRead;
            Zero_out <= Zero;
            NextAddr_out <= NextAddr;
            writeData_out <= writeData;
            rd_out <= rd;
            result_out <= result;
            MemtoReg_out <= MemtoReg;
				funct3_out <= funct3;
        end
    end   
endmodule