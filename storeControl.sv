module storeControl (
    input logic MemWrite,
    input logic [2:0]funct3,
    input logic [31:0] InputData, 
    output logic [31:0] WriteData
);

 assign WriteData = ((MemWrite == 1'b1) & (funct3 == 3'b000)) ? {24'b0, InputData[7:0]} :   /// Not sure
                        ((MemWrite == 1'b1) & (funct3 == 3'b001)) ? {24'b0, InputData[15:0]} :
                        ((MemWrite == 1'b1) & (funct3 == 3'b010)) ? InputData[31:0] : InputData; 
    
endmodule