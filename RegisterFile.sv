// module RegisterFile(
//     input logic clk, rstn, WriteEn,
//     input logic [4:0] ReadAddr1, ReadAddr2, WriteAddr,
//     input logic [31:0] WriteData,
//     output logic [31:0] ReadData1, ReadData2
// );

//     logic [31:0] Register [31:0];

//     always_ff @(posedge clk or negedge rstn) begin
//         if (!rstn) begin
//         end else begin
//             if (WriteEn) begin
//                 Register[WriteAddr] <= WriteData;
//             end
//         end
//     end  

//     assign ReadData1 = (!rstn) ? 32'd0 : Register[ReadAddr1];
//     assign ReadData2 = (!rstn) ? 32'd0 : Register[ReadAddr2];

//     initial begin
//         Register[0] = 32'h00000000;
//         Register[5] = 32'h00000005;
//         Register[6] = 32'h00000004; 
//         Register[7] = 32'd25;
//         Register[8] = 32'd25; 
//         Register[9] = 32'd40;
//         Register[10] = 32'd50; 
//     end
// endmodule

// module RegisterFile(
//     input logic clk, rstn, WriteEn,
//     input logic [4:0] ReadAddr1, ReadAddr2, WriteAddr,
//     input logic [31:0] WriteData,
//     output logic [31:0] ReadData1, ReadData2
// );

//     logic [31:0] Register [31:0];

//     always_ff @(posedge clk or negedge rstn) begin
//         if (!rstn) begin
//             // Initialize registers upon reset
            // Register[0] <= 32'd0;
            // Register[1] <= 32'd24;
			// 	Register[2] <= 32'd29;
			// 	Register[3] <= 32'd21;
            // Register[4] <= 32'd22;
            // Register[5] <= 32'd5;
            // Register[6] <= 32'd4;
            // Register[7] <= 32'd30;
            // Register[8] <= 32'd25;
            // Register[9] <= 32'd40;
            // Register[10] <= 32'd56;
//             /* Register[0] = 32'h00000000;
//             Register[5] = 32'h00000005;
//             Register[6] = 32'h00000004; 
//             Register[7] = 32'd25;
//             Register[8] = 32'd25; 
//             Register[9] = 32'd4;
//             Register[10] = 32'd50; */
//         end else if (WriteEn) begin
//             // Write data to specified register address
//             Register[WriteAddr] <= WriteData;
//         end
//     end  

//     assign ReadData1 = (!rstn) ? 32'd0 : Register[ReadAddr1];
//     assign ReadData2 = (!rstn) ? 32'd0 : Register[ReadAddr2];

// endmodule

module RegisterFile(
    input logic clk, rstn, WriteEn,
    input logic [4:0] ReadAddr1, ReadAddr2, WriteAddr,
    input logic [31:0] WriteData,
    output logic [31:0] ReadData1, ReadData2, 
	 output logic [31:0] registerOut [31:0]
);

    logic [31:0] Register [31:0];

    always_ff @(negedge clk or negedge rstn) begin
        if (!rstn) begin
            // Initialize all registers to zero
            //for (int i = 0; i < 32; i++) begin
            //    Register[i] <= 32'd0;
            //end
            // Set specific registers to predefined values
            Register[0] <= 32'd0;
            Register[1] <= 32'd24;
            Register[2] <= 32'd2;
            Register[3] <= 32'd21;
            Register[4] <= 32'd22;
            Register[5] <= 32'd5;
            Register[6] <= 32'd4;
            Register[7] <= 32'd30;
            Register[8] <= 32'd25;
            Register[9] <= 32'd40;
            Register[10] <= 32'd56;
            Register[11] <= 32'd30;
            Register[12] <= 32'd30;
			Register[13] <= 32'd18;
            Register[14] <= 32'd42;
            Register[15] <= 32'd9;
            Register[16] <= 32'd53;
            Register[17] <= 32'd11;
            Register[18] <= 32'd7;
            Register[19] <= 32'd34;
            Register[20] <= 32'd49;
            Register[21] <= 32'd14;
            Register[22] <= 32'd27;
            Register[23] <= 32'd38;
            Register[24] <= 32'd6;
            Register[25] <= 32'd45;
            Register[26] <= 32'd8;
            Register[27] <= 32'd59;
            Register[28] <= 32'd31;
            Register[29] <= 32'd12;
            Register[30] <= 32'd29;
            Register[31] <= 32'd3;	
				
        end else if (WriteEn) begin
            // Write data to specified register address
            Register[WriteAddr] <= WriteData;
        end
    end  
	
	// assign ReadData1 = (WriteAddr == ReadAddr1 && WriteAddr)? WriteData: Register[ReadAddr1];
	// assign ReadData2 = (WriteAddr == ReadAddr2 && WriteAddr)?	WriteData: Register[ReadAddr2];

    assign ReadData1 = Register[ReadAddr1];
	assign ReadData2 = Register[ReadAddr2];
	assign registerOut = Register;
	
endmodule
