// // // module data_mem #(
// // //     parameter ADDR_WIDTH = 32,
// // //     parameter DATA_WIDTH = 8,
// // //     parameter MEM_SIZE = 1024
// // // )(
// // //     input  logic                  clk, rstn,
// // //     input  logic                  ReadEn,
// // //     input  logic                  WriteEn,
// // //     input  logic [ADDR_WIDTH-1:0] Addr,
// // //     input  logic [DATA_WIDTH-1:0] WriteData,
// // //     output logic [DATA_WIDTH-1:0] ReadData
// // // );

// // // logic [DATA_WIDTH-1:0] memory [1023:0];

// // // always_ff @(posedge clk or negedge rstn) begin
// // //         if (!rstn) begin
// // //             // memory[Addr] <= 8'd0;
// // // 		    memory[0] <= 8'd10;
// // //             memory[1] <= 8'd9;
// // //             memory[2] <= 8'd8;
// // //             memory[3] <= 8'd12;
// // //             memory[4] <= 8'd15;
// // //             memory[5] <= 8'd20;
// // //             memory[6] <= 8'd18;
// // //             memory[7] <= 8'b10100101001000010100101010101011;
// // //             memory[8] <= 8'd25;
// // //             memory[9] <= 8'd22;
// // //             memory[10] <= 8'd8;
// // //             memory[11] <= 8'd16;
// // //             memory[12] <= 8'd24;
// // //             memory[13] <= 8'd29;
// // //             memory[14] <= 8'd5;
// // //             memory[15] <= 8'd40;
// // //             memory[16] <= 8'd11;
// // //             memory[17] <= 8'd28;
// // //             memory[18] <= 8'd17;
// // //             memory[19] <= 8'd9;
// // //             memory[20] <= 8'd33;
// // //             memory[21] <= 8'd21;
// // //             memory[22] <= 8'd6;
// // //             memory[23] <= 8'd27;
// // //             memory[24] <= 8'd14;
// // //             memory[25] <= 8'd31;
// // //             memory[26] <= 8'd13;
// // //             memory[27] <= 8'd19;
// // //             memory[28] <= 8'd38;
// // //             memory[29] <= 8'd42;
// // //             memory[30] <= 8'd26;
// // //             memory[31] <= 8'd7;
// // //             memory[8] <= 8'd45;
// // //             memory[33] <= 8'd2;
// // //             memory[34] <= 8'd34;
// // //             memory[35] <= 8'd50;
// // //             memory[36] <= 8'd30;
// // //             memory[37] <= 8'd16;
// // //             memory[38] <= 8'd23;
// // //             memory[39] <= 8'd12;
// // //             memory[40] <= 8'd3;
// // //             memory[41] <= 8'd55;
// // //             memory[42] <= 8'd173;
// // //             memory[43] <= 8'd41;
// // //             memory[44] <= 8'd18;
// // //             memory[45] <= 8'd20;
// // //             memory[46] <= 8'd4;
// // //             memory[47] <= 8'd36;
// // //             memory[48] <= 8'd9;
// // //             memory[49] <= 8'd37;
// // //             memory[50] <= 8'd25;
// // //             memory[51] <= 8'd15;
// // //             memory[52] <= 8'd28;
// // //             memory[53] <= 8'd43;
// // //             memory[54] <= 8'd31;
// // //             memory[55] <= 8'd48;
// // //             memory[56] <= 8'd13;
// // //             memory[57] <= 8'd39;
// // //             memory[58] <= 8'd24;                  
// // //             memory[59] <= 8'b11010100100101001010001011111010;
// // //             memory[60] <= 8'd22;
// // //             memory[61] <= 8'd51;
// // //             memory[62] <= 8'd46;
// // //             memory[63] <= 8'd19;
// // //             memory[64] <= 8'd8;
// // //             memory[65] <= 8'd40;
// // //             memory[66] <= 8'd8;
// // //             memory[67] <= 8'd11;
// // //             memory[68] <= 8'd47;
// // //             memory[69] <= 8'd17;
// // //         end else begin
// // //             if (WriteEn) begin
// // //                 memory[Addr] <= WriteData;
// // //                 // if (funct3 == 3'b000) begin
// // //                 //     memory[Addr] <= WriteData[7:0];   /// Not sure
// // // 				// end
// // //                 // else if (funct3 == 3'b001) begin
// // //                 //     memory[Addr] <= WriteData[7:0];
// // //                 //     memory[Addr+1] <= WriteData[15:8];
// // // 				// end 
// // //                 // else begin
// // //                 //     memory[Addr] <= WriteData[7:0];
// // //                 //     memory[Addr+1] <= WriteData[15:8];
// // //                 //     memory[Addr+2] <= WriteData[23:16];
// // //                 //     memory[Addr+3] <= WriteData[31:24];
// // // 				// end       
// // //             end
// // //         end
// // //     end   

// // //     // assign ReadData =   ((ReadEn == 1'b1) & (funct3 == 3'b000)) ? {24'b0, memory[Addr]} :   /// Not sure
// // //     //                     ((ReadEn == 1'b1) & (funct3 == 3'b001)) ? {16'b0, memory[Addr+1], memory[Addr]} :
// // //     //                     ((ReadEn == 1'b1) & (funct3 == 3'b010)) ? {memory[Addr+3], memory[Addr+2], memory[Addr+1], memory[Addr]} :
// // //     //                     ((ReadEn == 1'b1) & (funct3 == 3'b100)) ? {{24{memory[Addr][7]}}, memory[Addr]}:
// // //     //                     ((ReadEn == 1'b1) & (funct3 == 3'b101)) ? {{16{memory[Addr+1][7]}}, memory[Addr+1], memory[Addr]} :
// // //     //                     32'd0; 

// // //     assign ReadData = (ReadEn) ? {memory[Addr+3], memory[Addr+2], memory[Addr+1], memory[Addr]}: 32'd0;

// // // endmodule


// // module data_mem #(
// //     parameter ADDR_WIDTH = 10,  // Use 10 bits for addressing 1024 locations
// //     parameter DATA_WIDTH = 8,
// //     parameter MEM_SIZE = 1024
// // )(
// //     input  logic                  clk, rstn,
// //     input  logic                  ReadEn,
// //     input  logic                  WriteEn,
// //     input  logic [ADDR_WIDTH-1:0] Addr,
// //     input  logic [DATA_WIDTH-1:0] WriteData,
// //     output logic [DATA_WIDTH-1:0] ReadData
// // );

// // logic [DATA_WIDTH-1:0] memory [MEM_SIZE-1:0]; // 1024 memory locations

// // always_ff @(posedge clk or negedge rstn) begin
// //     if (!rstn) begin
// //         // Initialize all memory locations to 0
// //         integer i;
// //         for (i = 0; i < MEM_SIZE; i = i + 1) begin
// //             memory[i] <= 8'd0;  // Initialize memory to 0 (or set default values)
// //         end
// //         // You can still manually initialize specific locations if needed
// //         memory[0] <= 8'd10;
// //         memory[1] <= 8'd9;
// //         memory[2] <= 8'd8;
// //         // Continue manual initialization as needed
// //     end else begin
// //         if (WriteEn) begin
// //             if (Addr < MEM_SIZE)  // Prevent out-of-bounds write
// //                 memory[Addr] <= WriteData;
// //         end
// //     end
// // end

// // // Ensure read operation returns a valid value when ReadEn is high
// // assign ReadData = (ReadEn && Addr < MEM_SIZE) ? memory[Addr] : 8'd0;

// // endmodule



// module DataMem(
//     input logic clk, rstn, WriteEn, ReadEn,
//     input logic [2:0] funct3,
//     input logic [31:0] Addr, WriteData, 
//     output logic [31:0] ReadData
// );
//     logic [7:0] memory [69:0];

//     always_ff @(posedge clk or negedge rstn) begin
//         if (!rstn) begin
//             // memory[Addr] <= 8'd0;
// 		    memory[0] <= 8'd10;
//             memory[1] <= 8'd9;
//             memory[2] <= 8'd8;
//             memory[3] <= 8'd12;
//             memory[4] <= 8'd15;
//             memory[5] <= 8'd20;
//             memory[6] <= 8'd18;
//             memory[7] <= 8'b10100101001000010100101010101011;
//             memory[8] <= 8'd25;
//             memory[9] <= 8'd22;
//             memory[10] <= 8'd8;
//             memory[11] <= 8'd16;
//             memory[12] <= 8'd24;
//             memory[13] <= 8'd29;
//             memory[14] <= 8'd5;
//             memory[15] <= 8'd40;
//             memory[16] <= 8'd11;
//             memory[17] <= 8'd28;
//             memory[18] <= 8'd17;
//             memory[19] <= 8'd9;
//             memory[20] <= 8'd33;
//             memory[21] <= 8'd21;
//             memory[22] <= 8'd6;
//             memory[23] <= 8'd27;
//             memory[24] <= 8'd14;
//             memory[25] <= 8'd31;
//             memory[26] <= 8'd13;
//             memory[27] <= 8'd19;
//             memory[28] <= 8'd38;
//             memory[29] <= 8'd42;
//             memory[30] <= 8'd26;
//             memory[31] <= 8'd7;
//             memory[8] <= 8'd45;
//             memory[33] <= 8'd2;
//             memory[34] <= 8'd34;
//             memory[35] <= 8'd50;
//             memory[36] <= 8'd30;
//             memory[37] <= 8'd16;
//             memory[38] <= 8'd23;
//             memory[39] <= 8'd12;
//             memory[40] <= 8'd3;
//             memory[41] <= 8'd55;
//             memory[42] <= 8'd173;
//             memory[43] <= 8'd41;
//             memory[44] <= 8'd18;
//             memory[45] <= 8'd20;
//             memory[46] <= 8'd4;
//             memory[47] <= 8'd36;
//             memory[48] <= 8'd9;
//             memory[49] <= 8'd37;
//             memory[50] <= 8'd25;
//             memory[51] <= 8'd15;
//             memory[52] <= 8'd28;
//             memory[53] <= 8'd43;
//             memory[54] <= 8'd31;
//             memory[55] <= 8'd48;
//             memory[56] <= 8'd13;
//             memory[57] <= 8'd39;
//             memory[58] <= 8'd24;                  
//             memory[59] <= 8'b11010100100101001010001011111010;
//             memory[60] <= 8'd22;
//             memory[61] <= 8'd51;
//             memory[62] <= 8'd46;
//             memory[63] <= 8'd19;
//             memory[64] <= 8'd8;
//             memory[65] <= 8'd40;
//             memory[66] <= 8'd8;
//             memory[67] <= 8'd11;
//             memory[68] <= 8'd47;
//             memory[69] <= 8'd17;
//         end else begin
//             if (WriteEn) begin
//                 // memory[Addr] <= WriteData;
//                 if (funct3 == 3'b000) begin
//                     memory[Addr] <= WriteData[7:0];   /// Not sure
// 				end
//                 else if (funct3 == 3'b001) begin
//                     memory[Addr] <= WriteData[7:0];
//                     memory[Addr+1] <= WriteData[15:8];
// 				end 
//                 else begin
//                     memory[Addr] <= WriteData[7:0];
//                     memory[Addr+1] <= WriteData[15:8];
//                     memory[Addr+2] <= WriteData[23:16];
//                     memory[Addr+3] <= WriteData[31:24];
// 				end       
//             end
//         end
//     end   

//     assign ReadData =   ((ReadEn == 1'b1) & (funct3 == 3'b000)) ? {24'b0, memory[Addr]} :   /// Not sure
//                         ((ReadEn == 1'b1) & (funct3 == 3'b001)) ? {16'b0, memory[Addr+1], memory[Addr]} :
//                         ((ReadEn == 1'b1) & (funct3 == 3'b010)) ? {memory[Addr+3], memory[Addr+2], memory[Addr+1], memory[Addr]} :
//                         ((ReadEn == 1'b1) & (funct3 == 3'b100)) ? {{24{memory[Addr][7]}}, memory[Addr]}:
//                         ((ReadEn == 1'b1) & (funct3 == 3'b101)) ? {{16{memory[Addr+1][7]}}, memory[Addr+1], memory[Addr]} :
//                         32'd0; 

//     // assign ReadData = (ReadEn) ? {memory[Addr+3], memory[Addr+2], memory[Addr+1], memory[Addr]}: 32'd0;

// endmodule



module data_mem#(
    parameter DATA_WIDTH = 32,      // Word size
    parameter LINE_SIZE = 4       // Words per cache line
)(
    input logic clk, rstn, WriteEn, ReadEn,
    input logic [2:0] funct3,
    input logic [31:0] Addr, WriteData, 
    // output logic [31:0] ReadData,
    output logic [DATA_WIDTH-1:0] data [LINE_SIZE]
);
    logic [31:0] memory [499:0];



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
			  memory[336] <= 32'd12414;
			  memory[337] <= 32'd33424;
			  memory[338] <= 32'd34524;
			  memory[339] <= 32'd35434;
			  
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

    
    assign data[0] = (ReadEn) ? memory[{Addr[31:2], 2'b00 }] : 32'd0;
    assign data[1] = (ReadEn) ? memory[{Addr[31:2], 2'b01 }] : 32'd0;
    assign data[2] = (ReadEn) ? memory[{Addr[31:2], 2'b10 }] : 32'd0;
    assign data[3] = (ReadEn) ? memory[{Addr[31:2], 2'b11 }] : 32'd0;


endmodule
