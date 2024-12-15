module FetchDecodePipe (
    input logic clk, rstn,
    input logic [31:0] PC_Out,
    input logic [31:0] instruction,
    output logic [31:0] PC_Out_next,
    output logic [31:0] instruction_out
);

always_ff @(posedge clk or negedge rstn) begin
        if(!rstn) begin
            PC_Out_next <= 0;
            instruction_out <= 0;  
        end else begin
            PC_Out_next <= PC_Out;
            instruction_out <= instruction;  
        end 
    end
endmodule