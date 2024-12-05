module stall (
    input logic [4:0] rd, rs1, rs2,
    input logic [1:0] memToReg,
    
    output logic stall
);

    always_comb begin
        // Default value for stall
        stall = 0;
        
        // Check for stall condition
        if (memToReg == 2'b00 && (rd == rs1 || rd == rs2)) begin
            stall = 1;
        end
    end

endmodule
