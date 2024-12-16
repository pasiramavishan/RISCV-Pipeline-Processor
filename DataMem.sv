module DataMem(
    input logic clk, rstn, WriteEn, ReadEn,
    input logic [2:0] funct3,
    input logic [31:0] Addr, WriteData, 
    output logic [31:0] ReadData
);
    logic [31:0] memory [69:0];



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
			  memory[7] <= 32'b10100101001000010100101010101011;
			  memory[8] <= 32'd25;
			  memory[9] <= 32'd22;
			  memory[10] <= 32'd32;
			  memory[11] <= 32'd16;
			  memory[12] <= 32'd24;
              memory[13] <= 32'd29;
			  memory[14] <= 32'd5;
			  memory[15] <= 32'd40;
			  memory[16] <= 32'd11;
			  memory[17] <= 32'd28;
			  memory[18] <= 32'd17;
			  memory[19] <= 32'd9;
			  memory[20] <= 32'd33;
			  memory[21] <= 32'd21;
			  memory[22] <= 32'd6;
			  memory[23] <= 32'd27;
			  memory[24] <= 32'd14;
			  memory[25] <= 32'd31;
			  memory[26] <= 32'd13;
			  memory[27] <= 32'd19;
			  memory[28] <= 32'd38;
			  memory[29] <= 32'd42;
			  memory[30] <= 32'd26;
			  memory[31] <= 32'd7;
			  memory[32] <= 32'd45;
			  memory[33] <= 32'd2;
			  memory[34] <= 32'd34;
			  memory[35] <= 32'd50;
			  memory[36] <= 32'd30;
			  memory[37] <= 32'd16;
			  memory[38] <= 32'd23;
			  memory[39] <= 32'd12;
			  memory[40] <= 32'd3;
			  memory[41] <= 32'd55;
			  memory[42] <= 32'd173;
			  memory[43] <= 32'd41;
			  memory[44] <= 32'd18;
			  memory[45] <= 32'd20;
			  memory[46] <= 32'd4;
			  memory[47] <= 32'd36;
			  memory[48] <= 32'd9;
			  memory[49] <= 32'd37;
			  memory[50] <= 32'd25;
			  memory[51] <= 32'd15;
			  memory[52] <= 32'd28;
			  memory[53] <= 32'd43;
			  memory[54] <= 32'd31;
			  memory[55] <= 32'd48;
			  memory[56] <= 32'd13;
			  memory[57] <= 32'd39;
			  memory[58] <= 32'd24;                  
			  memory[59] <= 32'b11010100100101001010001011111010;
			  memory[60] <= 32'd22;
			  memory[61] <= 32'd51;
			  memory[62] <= 32'd46;
			  memory[63] <= 32'd19;
			  memory[64] <= 32'd8;
			  memory[65] <= 32'd40;
			  memory[66] <= 32'd32;
			  memory[67] <= 32'd11;
			  memory[68] <= 32'd47;
			  memory[69] <= 32'd17;
        end else begin
            if (WriteEn) begin
                // memory[Addr] <= WriteData;
                if (funct3 == 3'b000) begin
                    memory[Addr][7:0] <= WriteData[7:0];   /// Not sure
				end

                else if (funct3 == 3'b001) begin
                    memory[Addr][15:0] <= WriteData[15:0];
				end 
                else begin
                    memory[Addr] <= WriteData;
				end       
            end
        end
    end   

    assign ReadData = (ReadEn) ? memory[Addr] : 32'd0;

endmodule
