// module PC(
//     input logic clk, rstn,
//     input logic [31:0] NextAddr,
//     output logic [31:0] Addr
// );

//     always_ff @(posedge clk or negedge rstn) begin
//         if(!rstn)
//             Addr <= {32{1'b0}};
//         else
//             Addr <= NextAddr;        
//     end
// endmodule


module PC(
    input logic clk, rstn, stall,
    input logic [31:0] NextAddr,
    output logic [31:0] Addr,
    output logic [31:0] JumpAddr
);

    always_ff @(posedge clk or negedge rstn) begin
        if(!rstn)
            Addr <= {32{1'b0}};
        else
				if (!stall) begin
					Addr <= NextAddr; 
					JumpAddr <= NextAddr + 4;   
				end
    end
endmodule