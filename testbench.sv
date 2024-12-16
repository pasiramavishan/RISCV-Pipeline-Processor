module testbench();
    localparam CLK_PERIOD = 10;
    logic clk50, rstn = 0;
	 logic [4:0] sel;
	 logic [6:0] seg1, seg2, seg3, seg4;
	 logic [8:0] LED_out;

  //Finish the simulation after 1000 time units
   initial begin
       #2000 $finish;
   end

  
    initial begin
        clk50 = 0;
        forever #(CLK_PERIOD/2) clk50 = ~clk50; 
    end

    Main dut (.*);

    initial begin
      $dumpfile("dump.vcd");
      $dumpvars(5);
        rstn <= 1;
        @(posedge clk50);
        //rstn <=1;
		  
		  
		  
		  #200;
		  
		  @(posedge clk50);
		  sel <= 5'd1;
		  
		  @(posedge clk50);
		  sel <= 5'd3;
		  
    end
endmodule