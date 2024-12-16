// module ControlUnit(
//     input logic [6:0] Op,
//     output logic RegWrite, ALUSrc, MemWrite, Branch, MemRead, MemtoReg,
//     output logic [1:0] ALUOp, 
//     output logic [6:0] OpForward
// );

//   assign RegWrite = (Op == 7'b0000011 | Op == 7'b0110011 | Op == 7'b0010011 | Op == 7'b1101111 | Op == 7'b1100111 | Op == 7'b0110111 | Op == 7'b0010111) ? 1'b1 :1'b0 ;
                                                            
//     // assign ImmSrc = (Op == 7'b0100011 | Op = 7'b0000011 | Op = 7'b0010011) ? 2'b01 : (Op == 7'b1100011) ? 2'b10 :   2'b00 ;
//   assign ALUSrc = (Op == 7'b0000011 | Op == 7'b0010011 | Op == 7'b0100011 | Op == 7'b1100111) ? 1'b1 :1'b0 ;
//   assign MemWrite = (Op == 7'b0100011 | Op == 7'b) ? 1'b1 :1'b0 ;
//     assign MemRead = (Op == 7'b0000011) ? 1'b1 : 1'b0 ;
//     assign MemtoReg = (Op == 7'b0000011) ? 1'b1 : 1'b0 ;
//     //assign ResultSrc = (Op == 7'b0000011) ? 1'b1 :1'b0 ;
//     assign Branch = (Op == 7'b1100011) ? 1'b1 : 1'b0 ;     
//     assign ALUOp = (Op == 7'b0110011) ? 2'b10 :(Op == 7'b1100011) ? 2'b01 :2'b00 ;
//     assign OpForward = Op;

// endmodule   


module ControlUnit(
    input logic [6:0] Op,
    output logic RegWrite, ALUSrc, ALUSrc_A, MemWrite, Branch, MemRead, Jump, Jalr,
    output logic [1:0] MemtoReg,
    output logic [1:0] ALUOp,
    output logic [6:0] OpForward
);

    assign RegWrite = (Op == 7'b0000011 || Op == 7'b0110011 || Op == 7'b0010011 || Op == 7'b1101111 || Op == 7'b1100111 || Op == 7'b0110111 || Op == 7'b0010111) ? 1'b1 :1'b0 ;
                                                            
    // assign ImmSrc = (Op == 7'b0100011 | Op = 7'b0000011 | Op = 7'b0010011) ? 2'b01 : (Op == 7'b1100011) ? 2'b10 :   2'b00 ;
    assign ALUSrc = (Op == 7'b0000011 || Op == 7'b0010011 || Op == 7'b0100011 || Op == 7'b1100111 || Op == 7'b0110111 || Op == 7'b0010111) ? 1'b1 :1'b0 ;
    assign ALUSrc_A = (Op == 7'b0110111)? 2'b10: (Op == 7'b0010111)? 2'b01 : 2'b00;
    assign MemWrite = (Op == 7'b0100011) ? 1'b1 :1'b0 ;
    assign MemRead = (Op == 7'b0000011) ? 1'b1 : 1'b0 ;
    assign MemtoReg = (Op == 7'b0000011) ? 2'b00:
                      (Op == 7'b1101111 || Op == 7'b1100111) ? 2'b10 : 2'b01;
    //assign ResultSrc = (Op == 7'b0000011) ? 1'b1 :1'b0 ;
    assign Branch = (Op == 7'b1100011) ? 1'b1 : 1'b0 ;     
    assign ALUOp = (Op == 7'b0110011) ? 2'b10 :
                    (Op == 7'b1100011) ? 2'b01 :2'b00 ;
    assign Jump =  (Op == 7'b1101111) ? 1'b1 : 1'b0 ;
    assign Jalr = (Op == 7'b1100111) ? 1'b1 : 1'b0 ;
    assign OpForward = Op;

endmodule   