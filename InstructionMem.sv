// module InstructionMem(
//     input logic rstn,
//     input logic [31:0] Addr,
//     output logic [31:0] ReadData
// );
//     logic [31:0] memory [2^30-1:0];
    
//     assign ReadData = (~rstn) ? {32{1'b0}} : memory[Addr];


//     initial begin
// //       memory[0]  = 32'b00000000010100110000000010110011;      
// //       memory[4]  = 32'b00000000011101000000001101100011;
// //       memory[4]  = 32'b00000000010100110000000110110011;
// //       memory[8]  = 32'b01000000100000001000000100110011; 
      
// //      memory[0]  = 32'b01000000011000101000001110110011;
// //      memory[4]  = 32'b00000000011000111000001010110011;
// //      memory[8]  = 32'b01000000010100111000000110110011;
// //		  memory[12] = 32'b00000000010100011000000110010011;
// //		  memory[16] = 32'b00000000010100011000000110010011;
// //		  memory[20] = 32'b00000000000100011000000110110011;
// //		  memory[24] = 32'b00000000010100011000000110010011;

// 		  memory[0]  = 32'b00000000010100101000001000000011;
// 		  memory[4]  = 32'b00000000011000100000011100110011;
// 		  // memory[4]  = 32'b00000000101001001000011100110011;
		  
// 		  memory[8]  = 32'b00000000011100100000011110110011;

//     end

// endmodule


module InstructionMem(
    input logic rstn,
    input logic [31:0] Addr,          
    output logic [31:0] ReadData
);
    logic [31:0] memory [2^30-1:0];        
    assign ReadData = (~rstn) ? 32'b0 : memory[Addr >> 2];

    initial begin
      memory[0]  = 32'b00000000010100110000000010110011;      
     // memory[1]  = 32'b00000000011101000000001101100011; // BEQ s0 t2 0
      memory[1]  = 32'h00132423;
      memory[2]  = 32'b00000000010100110000000000110011;
      memory[3]  = 32'h00132423; 
      memory[4]  = 32'h00132423; // sw x6 8 x1
      memory[5]  = 32'h0074AE03; // lw x28 x9 7
      memory[6]  = 32'h00E00A6F; // jal x20 7
      memory[7]  = 32'b00000000010100110000000010110011; 
      memory[8] = 32'h0074AE03;
      memory[9] = 32'h00848967; //jalr
      memory[10] = 32'h00132423; // sw x6 8 x1     
      memory[11] = 32'h0074AE03;
      memory[12]  = 32'b00000000010100110000000010110011;  
      memory[13] = 32'h0074AE03;
      memory[14] = 32'h00848967; //jalr
      memory[15]  = 32'b00000000010100110000000010110011;  
    end

endmodule