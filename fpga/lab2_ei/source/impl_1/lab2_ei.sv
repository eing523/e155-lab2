// Emily Ing
// eing@g.hmc.edu
// Date of creation: 9/12/2026
// Summary: Top module used to instantiate modules plus the switch-to-LED assign logic.

module lab2_ei(
	input  logic       nreset,
	input  logic [3:0] sw1,
	input  logic [3:0] sw2,
	input  logic [3:0] col,
	output logic [6:0] seg,
	output logic [3:0] led,
	output logic       clk,
    output logic [1:0] power, // determines power
	output logic [3:0] row

);
	
	localparam WIDTH = 32; 

	logic clk_new_scanner;
	logic clk_new_counter;
	logic [WIDTH-1:0] counter;
    logic [3:0] s; // DIP switches

	// Internal high-speed oscillator
	HSOSC hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(clk));
	
	// Instantiate counter module
	lab2_counter #(.MAXCOUNT(200_000), .WIDTH(32)) lab2_counter_inst (.clk(clk), .nreset(nreset), .enable(1'b1), .counter(counter), .clk_new(clk_new_counter));
	
	// Instantiate scanning module
	lab2_scanning lab2_scanning_inst(.clk(clk), .nreset(nreset), .clk_new(clk_new_scanner), .row(row));
	
	// column to led assign
	assign led[3] = (col == 4'b0111);
	assign led[2] = (col == 4'b1011);
	assign led[1] = (col == 4'b1101);
    assign led[0] = (col == 4'b1110);

	// power mux
	assign power = (clk_new_scanner == 1'b0) ? 2'b10 : 2'b01;
	
	// switch mux
	assign s = (clk_new_scanner == 1'b0) ? sw1 : sw2;
	
	// Instantiate seven-segment display decoder module
	lab2_7_seg_decoder lab2_7_seg_decoder_inst(s, seg);
	
endmodule