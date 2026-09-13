// Emily Ing
// eing@g.hmc.edu
// Date of creation: 9/12/2026
// Summary: Top module used to instantiate modules plus the switch-to-LED assign logic.

module lab2_ei(
	input  logic [3:0] s, // DIP switches
	input  logic       reset,
	output logic [6:0] seg,
	output logic [2:0] led,
	output logic       clk
);
		
	// Internal high-speed oscillator
	HSOSC hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(clk));
	
	// Instantiate seven-segment display decoder module
	lab2_7_seg_decoder lab2_7_seg_decoder_inst(s, seg);
	
	// Instantiate scanning module
	lab2_scanning lab2_scanning_inst();

// Simple clock divider
	always_ff @(posedge clk) begin
		if (!nreset) begin // 0 = high and 1 = low.
				counter <= 0;
				count_state <= 0;
				clk_state <= 0;
			end	
   // Choosing a max count of 400,000 due to calculations of 48 mHz/120 Hz	
		else if (enable) begin
			if (counter >= MAXCOUNT - 1) begin
					counter <= 0;
					count_state <= count_state + 1; // adding to count each cycle
					clk_state <= ~clk_state; // toggles the new clock
				end
			else begin
					counter <= counter + 1;
\				end
			end
		else begin
				counter <= counter + 0;
			end
		end

endmodule