module AdderPC(
    input logic [31:0] Addr, 
    output logic [31:0] NextAddr
);
    assign NextAddr = Addr + 32'd4;
    
endmodule
