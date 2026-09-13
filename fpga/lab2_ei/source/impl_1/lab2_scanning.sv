// Emily Ing
// eing@g.hmc.edu
// Date of creation: 9/12/2026
// Summary: Scanning module for E155 Lab 2, which asserts signals on each row one at a time, then observes the values of the columns.

module lab2_scanning (
	input  logic       clk,
	input  logic       clk_new,
	input  logic       counter,
	input  logic       nreset,
	output logic [3:0] row
);


	// Instantiate counter module
	lab2_counter #(.MAXCOUNT(12_000_000), .WIDTH(25)) lab2_counter_inst (.clk(clk), .nreset(nreset), .enable(1'b1), .counter(counter), .clk_new(clk_new));
	
	// row logic
	
	assign row = 
		   (nreset == 0) ? row == 4'b0000;
		   ((clk_new == 0) & (MAXCOUNT == 5999)) ? row == 4'b1000 :
		   ((clk_new == 0) & (MAXCOUNT == 11_999_999)) ? row == 4'b0100 :
		   ((clk_new == 1) & (MAXCOUNT == 5999)) ? row == 4'b0010 :
		   ((clk_new == 1) & (MAXCOUNT == 11_999_999)) ? row == 4'b0001;
		   row == 4'b1111;
		   
endmodule