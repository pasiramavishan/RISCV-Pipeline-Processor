/* module FetchDecodePipe (
    input logic clk, rstn,
    input logic [31:0] PC_Out,
    input logic [31:0] instruction,
    input logic [1:0] BranchOp,
    output logic [31:0] PC_Out_next,
    output logic [31:0] instruction_out
);

    logic flush;
    
    assign flush = (BranchOp == 2'b00 || BranchOp == 2'b10) ? 1'b1 : 1'b0;

    always_ff @(posedge clk or negedge rstn) begin
            if(!rstn || flush) begin
                PC_Out_next <= 0;
                instruction_out <= 0;  
            end else begin
                PC_Out_next <= PC_Out;
                instruction_out <= instruction;  
            end 
        end
endmodule */

module FetchDecodePipe (
    input logic clk, rstn, stall,
    input logic [31:0] PC_Out,
    input logic [31:0] instruction,
    input logic [1:0] BranchOp,
    output logic [31:0] PC_Out_next,
    output logic [31:0] instruction_out
);

    logic flush;
    
    assign flush = (BranchOp == 2'b00 || BranchOp == 2'b10) ? 1'b1 : 1'b0;

    always_ff @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            PC_Out_next <= 0;
            instruction_out <= 0; 
				
        end else begin
		  
		  if (flush) begin 
				PC_Out_next <= 0;
            instruction_out <= 0;
		  end
		 else if (!stall) begin
            PC_Out_next <= PC_Out;
            instruction_out <= instruction; 
			end	
        end 
    end
endmodule
