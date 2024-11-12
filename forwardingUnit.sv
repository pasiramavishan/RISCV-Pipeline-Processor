module forwardingUnit (
    input logic [4:0] rs1, rs2, rd_Mem, rd_Write,
    input logic writeBackExe, writeBackMem,
    output logic [1:0] forwardA, forwardB
);

always_comb begin

    if (writeBackExe == 1 && rd_Mem == rs1) begin
        forwardA = 2'b10;
    end

    else if (writeBackMem == 1 && rd_Write == rs1) begin
        forwardA = 2'b01;
    end

    else begin
        forwardA = 2'b00;
    end

    if (writeBackExe == 1 && rd_Mem == rs2) begin
        forwardB = 2'b10;
    end

    else if (writeBackMem == 1 && rd_Write == rs2) begin
        forwardB = 2'b01;
    end

    else begin
        forwardB = 2'b00;
    end
    // if (writeBackExe == 1) begin
    //     if (rd_Mem == rs1) begin
    //         forwardA = 2'b10;
    //     end

    //     if (rd_Mem == rs2) begin
    //         forwardB = 2'b10;
    //     end
    // end

    // else if (writeBackMem == 1) begin
    //     if (rd_Mem == rs1) begin
    //         forwardA = 2'b01;
    //     end

    //     if (rd_Mem == rs2) begin
    //         forwardB = 2'b01;
    //     end
 
    // end

    // else begin
    //     forwardA = 2'b00;
    //     forwardB = 2'b00;
    // end

    
    // assign forwardA = (rs1 == rd_Mem) ? 2'b10 : (rs1 == rd_Write == rd_Write) ?  2'b01 : 2'b00;
    // assign forwardB = (rs1 == rd_Mem) ? 2'b10 : (rs1 == rd_Write == rd_Write) ?  2'b01 : 2'b00; 


end
    
endmodule