module DataMem(
    input logic clk, rstn, WriteEn, ReadEn,
    input [31:0] Addr, WriteData,
    output [31:0] ReadData
);
    logic [31:0] memory [1023:0];



    always_ff @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            // memory[Addr] <= 32'd0;
		     memory[0] <= 32'd10;
			  memory[1] <= 32'd9;
			  memory[2] <= 32'd8;
			  memory[3] <= 32'd12;
			  memory[4] <= 32'd15;
			  memory[5] <= 32'd20;
			  memory[6] <= 32'd18;
			  memory[7] <= 32'd35;
			  memory[8] <= 32'd25;
			  memory[9] <= 32'd22;
			  memory[10] <= 32'd32;
			  memory[11] <= 32'd16;
			  memory[12] <= 32'd24;
        end else begin
            if (WriteEn) begin
                memory[Addr] <= WriteData;
            end
        end
    end   

    assign ReadData = (ReadEn) ? memory[Addr] : 32'd0;

endmodule
