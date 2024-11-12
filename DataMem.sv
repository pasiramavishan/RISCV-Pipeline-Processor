module DataMem(
    input logic clk, rstn, WriteEn, ReadEn,
    input [31:0] Addr, WriteData,
    output [31:0] ReadData
);
    logic [31:0] memory [2^30-1:0];

    // initial begin
    //     integer i;
    //     for (i = 0; i < 2^30; i = i + 1) begin
    //         memory[i] = 32'd0;
    //     end
    // end

    always_ff @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            // memory[Addr] <= 32'd0;
        end else begin
            if (WriteEn) begin
                memory[Addr] <= WriteData;
            end
        end
    end   

    assign ReadData = (ReadEn) ? memory[Addr] : 32'd0;

endmodule
