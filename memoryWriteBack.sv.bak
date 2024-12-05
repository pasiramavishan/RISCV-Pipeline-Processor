module memoryWriteBackPipe (
    input logic clk, rstn,
    input logic [31:0] readData, memAddress, //Jump_addr,
    input logic [4:0] rd,
    input logic RegWrite, 
    input logic [1:0] MemtoReg,
    output logic [31:0] readData_out, memAddress_out, //Jump_addr_out,
    output logic [4:0] rd_out,
    output logic RegWrite_out,
    output logic [1:0] MemtoReg_out
);

    always_ff @(posedge clk or negedge rstn) begin
        if(!rstn) begin
            readData_out <= 0; 
            memAddress_out <= 0;
            rd_out <= 0;
            RegWrite_out <= 0; 
            MemtoReg_out <= 0;   
            //Jump_addr_out <= 0;
        end else begin
            readData_out <= readData; 
            memAddress_out <= memAddress;
            rd_out <= rd;
            RegWrite_out <= RegWrite; 
            MemtoReg_out <= MemtoReg;
            // Jump_addr_out <= Jump_addr;
        end    
    end
    
endmodule