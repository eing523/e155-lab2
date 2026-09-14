`timescale 1 ns/1 ns
// fix later
module lab2_ei_tb();
	logic       nreset,
	logic [3:0] sw1;
	logic [3:0] sw2;
	logic [3:0] col;
	logic [6:0] seg;
	logic [2:0] led;
	logic       clk;

    lab2_ei dut (
		.sw1(sw1),
		.sw2(sw2),
		.col(col),
		.seg(seg),
		.led(led),
		.clk(clk)
    );


  initial begin
    nreset = 0;
    #40 nreset = 1;

// check that multiplexing functionality works
	#3;
	
	// power mux testing
		dut.power = 2'b10;              // setup inputs
        assert (dut.clk_new == 0)       // check outputs
            $display("PASSED! The power mux testing behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The power mux testing behaves incorrectly at time: %0t.", $time); 
	#11;
	
		dut.power = 2'b01;              // setup inputs
        assert (dut.clk_new == 1)       // check outputs
            $display("PASSED! The power mux testing behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The power mux testing behaves incorrectly at time: %0t.", $time); 
	#11;
	
	// switch mux testing
	
	nreset = 0;
    #40 nreset = 1;
	
    #3;
		dut.s = sw1;              // setup inputs
        assert (dut.clk_new == 0)       // check outputs
            $display("PASSED! The switch mux testing behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The switch mux testing behaves incorrectly at time: %0t.", $time); 
	#11;
	
		dut.s = sw2;              // setup inputs
        assert (dut.clk_new == 1)       // check outputs
            $display("PASSED! The switch mux testing behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The switch mux testing behaves incorrectly at time: %0t.", $time); 
	#11;


// check that LED driving functionality works
	#20 nreset = 0;
	#20 nreset = 1;
	
	#3;

	// test 1
        col == 4'b0111;                // setup inputs
        #10;                        // wait required time
        assert (led[3] == 1'b1)       // check outputs
            $display("PASSED! The led driving functionality behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The led driving functionality behaves incorrectly at time: %0t.", $time); 
	
	// test 2
        col == 4'b1011;                // setup inputs
        #10;                        // wait required time
        assert (led[2] == 1'b1)       // check outputs
            $display("PASSED! The led driving functionality behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The led driving functionality behaves incorrectly at time: %0t.", $time); 
	
	// test 3
        col == 4'b1101;                // setup inputs
        #10;                        // wait required time
        assert (led[1] == 1'b1)       // check outputs
            $display("PASSED! The led driving functionality behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The led driving functionality behaves incorrectly at time: %0t.", $time); 
	
	// test 4
        col == 4'b1110;                // setup inputs
        #10;                        // wait required time
        assert (led[0] == 1'b1)       // check outputs
            $display("PASSED! The led driving functionality behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The led driving functionality behaves incorrectly at time: %0t.", $time); 

    #100 $stop;
  end
endmodule