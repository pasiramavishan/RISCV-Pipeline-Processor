module Mux(
    input logic [31:0] inp1, inp2,
    input logic sel,
    output logic [31:0] out
);

    assign out = (sel) ? inp1 : inp2 ;
    
endmodule
