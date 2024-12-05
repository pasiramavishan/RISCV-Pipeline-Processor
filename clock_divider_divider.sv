/* module clock_divide_divider (
    input logic clk50, rstn,
    output logic clk
);

    // Toggle flip-flop for dividing the clock by 2
    always_ff @(posedge clk50 or negedge rstn) begin
		  if (~rstn) clk <= 1'b0;
		  
        else clk <= ~clk;
    end

endmodule */

module clock_divider_divider (
    input logic clk50,     // 50 MHz input clock
    input logic reset,     // Asynchronous reset
    output logic clk       // 10 MHz output clock
);

    // Counter to divide clock
/*    logic [2:0] counter;    // 3-bit counter for dividing by 5

    always_ff @(posedge clk50 or negedge reset) begin
        if (!reset)
            counter <= 3'b000;            // Reset the counter
        else if (counter == 0)            // When the counter reaches 4
            counter <= 3'b000;            // Reset to 0
        else
            counter <= counter + 1;       // Increment counter
    end

    // Generate the output clock: toggle every 5 input clock cycles
    always_ff @(posedge clk50 or negedge reset) begin
        if (!reset)
            clk <= 1'b0;                  // Reset the output clock
        else if (counter == 0)
            clk <= ~clk;                  // Toggle the output clock
    end

	 */
	 
	 assign clk = clk50;
endmodule

