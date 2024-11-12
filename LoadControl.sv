module Loadcontrol(
    input logic MemRead,
    input logic [2:0]funct3,
    input logic [6:0]funct7,
    input logic [31:0] InputData, 
    output logic [31:0] WriteData
);
    // Method 1 
    // assign ALUControl = (ALUOp == 2'b00) ? 3'b000 :
    //                     (ALUOp == 2'b01) ? 3'b001 :
    //                     (ALUOp == 2'b10) ? ((funct3 == 3'b000) ? ((({op[5],funct7[5]} == 2'b00) | ({op[5],funct7[5]} == 2'b01) | ({op[5],funct7[5]} == 2'b10)) ? 3'b000 : 3'b001) : 
    //                                         (funct3 == 3'b010) ? 3'b101 : 
    //                                         (funct3 == 3'b110) ? 3'b011 : 
    //                                         (funct3 == 3'b111) ? 3'b010 : 3'b000) :
    //                                        3'b000;

    // Method 2
    assign WriteData = ((MemRead == 1'b1) & (funct3 == 3'b000)) ? InputData[7:0] :   /// Not sure
                        ((MemRead == 1'b1) & (funct3 == 3'b001)) ? InputData[15:0] :
                        ((MemRead == 1'b1) & (funct3 == 3'b010)) ? InputData[31:0] :
                        ((MemRead == 1'b1) & (funct3 == 3'b100)) ? 32'b0 + InputData[7:0]:
                        ((MemRead == 1'b1) & (funct3 == 3'b101)) ? 32'b0 + InputData[15:0] :
                        InputData; 
endmodule