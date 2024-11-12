module PC_pipe (
    input logic clk, rstn,
    input logic [31:0] PC_in,
    output logic [31:0] PC_Out
);

always_ff @( posedge clk or rstn ) begin : blockName
    if (!rstn) begin
        PC_Out <= 32'b0;
    end 
    
    else begin
        PC_Out <= PC_in;
    end
end
endmodule