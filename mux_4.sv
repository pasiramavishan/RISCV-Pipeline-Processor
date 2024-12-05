module mux_4 (
    input logic [31:0] data0, data1, data2, data3, // Four input data lines
    input logic [1:0] control,                   // 2-bit control signal
    output logic [31:0] dataOut                  // Output data
);

    assign dataOut = (control == 2'b00) ? data0 :
                     (control == 2'b01) ? data1 :
                     (control == 2'b10) ? data2 : data3;

endmodule
