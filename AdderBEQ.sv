module AdderBEQ(
    input logic [31:0] Addr,
    input logic [31:0] Extended_imm_out,
    output logic [31:0] NextAddr
);

    assign NextAddr = Addr + (Extended_imm_out<<1);
endmodule