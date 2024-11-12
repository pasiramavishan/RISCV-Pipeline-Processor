module ImmGen(
    input logic [31:0] Instruction,
    input logic rstn, 
    output logic [31:0] Extended_imm
);
    logic [6:0] opcode;

    assign opcode = Instruction[6:0];

    always_comb begin
        if (~rstn)
            Extended_imm = 32'b0;
        else begin
            case(opcode)
                7'b0010011, // I-type (e.g., addi)
                7'b0000011, // Load (e.g., lw)
                7'b1100111: // JALR
                    Extended_imm = {{20{Instruction[31]}}, Instruction[31:20]}; // Sign-extended 12-bit immediate

                7'b0100011: // S-type (e.g., sw)
                    Extended_imm = {{20{Instruction[31]}}, Instruction[31:25], Instruction[11:7]}; // Sign-extended 12-bit immediate

                7'b0110111, // LUI
                7'b0010111: // AUIPC
                    Extended_imm = {Instruction[31:12], 12'b0}; // Upper 20 bits with lower 12 bits as zero

                7'b1101111: // J-type (e.g., JAL)
                    Extended_imm = {{12{Instruction[31]}}, Instruction[19:12], Instruction[20], Instruction[30:21], 1'b0}; // Sign-extended 20-bit immediate

                7'b1100011: // B-type (e.g., beq)
                    Extended_imm = {{19{Instruction[31]}}, Instruction[7], Instruction[30:25], Instruction[11:8], 1'b0}; // Sign-extended 13-bit immediate

                default:
                    Extended_imm = 32'b0;
            endcase
        end
    end
endmodule