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
//           Register[0] <= 32'd0;
//           Register[1] <= 32'd20;
//           Register[4] <= 32'd22;
//           Register[5] <= 32'd5;
//           Register[6] <= 32'd4;
//           Register[7] <= 32'd30;
//             Register[8] <= 32'd25;
//             Register[9] <= 32'd40;
//             Register[10] <= 32'd50;
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
    output logic [31:0] ReadData1, ReadData2
);

    logic [31:0] Register [31:0];

    always_ff @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            // Initialize all registers to zero
            for (int i = 0; i < 32; i++) begin
                Register[i] <= 32'd0;
            end
            // Set specific registers to predefined values
            Register[1] <= 32'd20;
            Register[4] <= 32'd22;
            Register[5] <= 32'd5;
            Register[6] <= 32'd4;
            Register[7] <= 32'd30;
            Register[8] <= 32'd25;
            Register[9] <= 32'd40;
            Register[10] <= 32'd50;
        end else if (WriteEn) begin
            // Write data to specified register address
            Register[WriteAddr] <= WriteData;
        end
    end  

    assign ReadData1 = Register[ReadAddr1];
    assign ReadData2 = Register[ReadAddr2];

endmodule
