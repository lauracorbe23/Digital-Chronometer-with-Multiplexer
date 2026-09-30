`timescale 1ns / 1ps

module freq_div (
    input  logic        clk_in,
    input  logic        rst,
    input  logic [31:0] factor,
    output logic        clk_out
);

    logic [31:0] count;

    always_ff @(posedge clk_in or posedge rst) begin
        if (rst) begin
            count   <= 0;
            clk_out <= 0;
        end
        else begin
            if (count >= (factor / 2) - 1) begin
                count   <= 0;
                clk_out <= ~clk_out;
            end
            else begin
                count <= count + 1;
            end
        end
    end

endmodule