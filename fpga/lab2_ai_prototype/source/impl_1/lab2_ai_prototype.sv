module time_mux_7seg (
    input  logic       clk,      // System clock
    input  logic       rst_n,    // Active-low asynchronous reset
    input  logic [3:0] in0,      // First 4-bit binary input
    input  logic [3:0] in1,      // Second 4-bit binary input
    output logic [6:0] seg0,     // Common anode display 0 ({g,f,e,d,c,b,a})
    output logic [6:0] seg1      // Common anode display 1 ({g,f,e,d,c,b,a})
);

    logic       select;
    logic [3:0] mux_in;
    logic [6:0] dec_out;

    // 1. Multiplexer select toggle
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            select <= 1'b0;
        else
            select <= ~select;
    end

    // 2. Input Mux to select between in0 and in1
    assign mux_in = select ? in1 : in0;

    // 3. Shared Common-Anode Decoder (Active-Low: 0 = LED ON, 1 = LED OFF)
    always_comb begin
        case (mux_in)
            4'h0: dec_out = 7'b100_0000;
            4'h1: dec_out = 7'b111_1001;
            4'h2: dec_out = 7'b010_0100;
            4'h3: dec_out = 7'b011_0000;
            4'h4: dec_out = 7'b001_1001;
            4'h5: dec_out = 7'b001_0010;
            4'h6: dec_out = 7'b000_0010;
            4'h7: dec_out = 7'b111_1000;
            4'h8: dec_out = 7'b000_0000;
            4'h9: dec_out = 7'b001_0000;
            4'hA: dec_out = 7'b000_1000;
            4'hb: dec_out = 7'b000_0011;
            4'hC: dec_out = 7'b100_0110;
            4'hd: dec_out = 7'b010_0001;
            4'hE: dec_out = 7'b000_0110;
            4'hF: dec_out = 7'b000_1110;
            default: dec_out = 7'b111_1111; // Off
        endcase
    end

    // 4. Output Demux Registers to hold decoded values
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            seg0 <= 7'b111_1111;
            seg1 <= 7'b111_1111;
        end else begin
            if (select == 1'b0)
                seg0 <= dec_out;
            else
                seg1 <= dec_out;
        end
    end

endmodule