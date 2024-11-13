// module branchTop (
//     input logic branch,
//     input [2:0] funct3,
//     output [2:0] branchOp
// );

//     assign branchOp =   ((branch == 1'b1) & (funct3 == 3'b000)) ? 3'b001 : 
//                         ((branch == 1'b1) & (funct3 == 3'b001)) ? 3'b010 : 
//                         ((branch == 1'b1) & (funct3 == 3'b100)) ? 3'b011 : 
//                         ((branch == 1'b1) & (funct3 == 3'b101)) ? 3'b100 :
//                         ((branch == 1'b1) & (funct3 == 3'b110)) ? 3'b101 : 
//                         ((branch == 1'b1) & (funct3 == 3'b111)) ? 3'b110 : 3'b000; 

    
// endmodule

// module branchTop (
//     input logic branch,
//     input [2:0] funct3,
//     output [2:0] branchOp
// );

//     assign branchOp =   ((branch == 1'b1) & (funct3 == 3'b000)) ? 3'b001 : 
//                         ((branch == 1'b1) & (funct3 == 3'b001)) ? 3'b010 : 
//                         ((branch == 1'b1) & (funct3 == 3'b100)) ? 3'b011 : 
//                         ((branch == 1'b1) & (funct3 == 3'b101)) ? 3'b100 :
//                         ((branch == 1'b1) & (funct3 == 3'b110)) ? 3'b101 : 
//                         ((branch == 1'b1) & (funct3 == 3'b111)) ? 3'b110 : 3'b000; 

    
// endmodule

// module BranchControl (
//     input logic Branch, Zero, Negative,
//     input logic [2:0] funct3,
//     output logic BranchOp
// );

//     assign BranchOp =   ((Branch == 1'b1) & (funct3 == 3'b000 && Zero == 1'b1)) || 
//                         ((Branch == 1'b1) & (funct3 == 3'b001 && Zero != 1'b1)) || 
//                         ((Branch == 1'b1) & (funct3 == 3'b100 && Negative == 1'b1)) ||
//                         ((Branch == 1'b1) & (funct3 == 3'b101 && Negative != 1'b1)) ||
//                         ((Branch == 1'b1) & (funct3 == 3'b110)) ||
//                         ((Branch == 1'b1) & (funct3 == 3'b111)) ? 1'b1 : 1'b0; 
// endmodule


module BranchControl (
    input logic Branch, Zero, Negative, Jump, Jalr,
    input logic [2:0] funct3,
    output logic [1:0] BranchOp
);

    assign BranchOp =   ((Branch == 1'b1) & (funct3 == 3'b000 && Zero == 1'b1)) || 
                        ((Branch == 1'b1) & (funct3 == 3'b001 && Zero != 1'b1)) || 
                        ((Branch == 1'b1) & (funct3 == 3'b100 && Negative == 1'b1)) ||
                        ((Branch == 1'b1) & (funct3 == 3'b101 && Negative != 1'b1)) ||
                        ((Branch == 1'b1) & (funct3 == 3'b110)) ||
                        ((Branch == 1'b1) & (funct3 == 3'b111)) ||
                        (Jump == 1'b1) ? 2'b00 : 
                        (Jalr == 1'b1) ? 2'b10 : 2'b01; 
endmodule