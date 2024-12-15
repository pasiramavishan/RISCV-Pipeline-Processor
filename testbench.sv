module testbench();
    localparam CLK_PERIOD = 10;
    logic clk, rstn = 0;

  //Finish the simulation after 1000 time units
   initial begin
       #2000 $finish;
   end

  
    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk = ~clk; 
    end

    Main dut (.*);

    initial begin
      $dumpfile("dump.vcd");
      $dumpvars(5);
        rstn <= 1;
        @(posedge clk);
        //rstn <=1;
    end
endmodule