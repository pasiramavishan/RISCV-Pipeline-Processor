module Instruction_Parser(
    input logic [31:0] instruction,
    output logic [6:0] opcode,
    output logic [6:0] rs1, rs2, rd
);

    assign opcode = instruction[6:0];
    assign rs1 = instruction[19:15];
    assign rs2 = instruction[24:20];

// if (instruction[6:0] == 7'b0110011 || instruction[6:0] == 7'b0010011 )
    assign rd =  instruction[11:7];


endmodule