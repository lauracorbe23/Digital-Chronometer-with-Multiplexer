`timescale 1ns / 1ps

module ram4x4 (
    input  logic       clk,
    input  logic       we,
    input  logic [1:0] addr,
    input  logic [3:0] data_in,
    output logic [3:0] data_out
);

    logic [3:0] memorie [0:3];
    always_ff @(posedge clk) begin
        if (we) begin
            memorie[addr] <= data_in;
        end
    end
    assign data_out = memorie[addr];

endmodule