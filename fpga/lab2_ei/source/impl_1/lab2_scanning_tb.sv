`
timescale 1 ns/1 ns

module lab2_scanning_tb();
	logic [3:0] row;

    lab2_scanning dut (
		.row(row)
    );

  initial begin
// check that enable feature works
	#20 nreset = 0;
	#20 nreset = 1;
	
	#3;

	// checking that the enable is off for 48 MHz for a few periods to make sure
		enable = 0;
		#40;
		assert (dut.counter == 0)       // check outputs
				$display("PASSED! The counter enable behaves as desired at time: %0t.", $time);
			else 
				$error("FAILED! The counter enable behaves incorrectly at time: %0t.", dut.counter, $time); 
		
		// checking that the enable is on for 48 MHz
		#40;
		enable = 1;
		
		#249_960_000; // waiting for counter to activate
		
		assert (dut.counter == 12_000_000)       // check outputs
				$display("PASSED! The counter enable behaves as desired at time: %0t.", $time);
			else 
				$error("FAILED! The counter enable behaves incorrectly at time: %0t.", $time); 
			
			
// check that all 4 output transitions work			
    nreset = 0;
	#2;
        assert (row == 4'b0000)       // check outputs
            $display("PASSED! The output transitions (rows) behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The output transitions (rows) behaves incorrectly at time: %0t.", $time); 
	
	#20 nreset = 1;
	#2;
	
	#124980000;
	
		row = 4'b1000;              // setup inputs
        assert ((dut.clk_new == 0) & (MAXCOUNT <= 5999))       // check outputs
            $display("PASSED! The output transitions (rows) behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The output transitions (rows) behaves incorrectly at time: %0t.", $time); 
	
	#124980000;
	
		row = 2'b0100;              // setup inputs
        assert ((dut.clk_new == 0) & (MAXCOUNT <= 11_999_999))       // check outputs
            $display("PASSED! The output transitions (rows) behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The output transitions (rows) behaves incorrectly at time: %0t.", $time); 
	
	#124980000;
	
		row = 4'b0010;              // setup inputs
			assert ((dut.clk_new == 1) & (MAXCOUNT <= 5999))       // check outputs
				$display("PASSED! The output transitions (rows) behaves as desired at time: %0t.", $time);
			else 
				$error("FAILED! The output transitions (rows) behaves incorrectly at time: %0t.", $time); 
	
	#124980000;
		
			row = 2'b0001;              // setup inputs
			assert ((dut.clk_new == 1) & (MAXCOUNT <= 11_999_999))       // check outputs
				$display("PASSED! The output transitions (rows) behaves as desired at time: %0t.", $time);
			else 
				$error("FAILED! The output transitions (rows) behaves incorrectly at time: %0t.", $time); 
	#20;


// check that reset feature works
	#80;
	reset = 0;
    #20 reset = 1;
	
	assert (dut.counter == 0 & clk_new == 1'b0)       // check outputs
            $display("PASSED! The counter reset behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The counter reset behaves incorrectly at time: %0t.", $time); 
			

	
    #100 $stop;
  end
endmodule