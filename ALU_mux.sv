/* module ALU_mux (
  input logic [31:0] data1, data2, data3,
  input logic [1:0] control,
  output logic [31:0] dataOut
);


always_comb begin 
   
    case (control)
        2'b00: dataOut = data1;

        2'b01: dataOut = data2;

        2'b10: dataOut = data3;

        default:
            dataOut = 32'b0; 
      
    endcase 
end    
endmodule */

module ALU_mux (
    input logic [31:0] data1, data2, data3,
    input logic [1:0] control,
    output logic [31:0] dataOut
);

assign dataOut = (control[1]) ? data3 : (control[0]) ? data2 : data1;

endmodule
