`timescale 1ns / 1ps

module timer (
    input  logic        clk_in,
    input  logic        rst,
    input  logic        en,
    input  logic        we,
    input  logic [1:0]  addr,
    input  logic [31:0] factor,
    input  logic        src_sel,
    output logic [3:0]  out_val
);

    logic       clk_divizat;
    logic [3:0] val_numarator;
    logic [3:0] val_ram;

    freq_div divizor_inst (
        .clk_in (clk_in),
        .rst    (rst),
        .factor (factor),
        .clk_out(clk_divizat)
    );

    counter numarator_inst (
        .clk  (clk_divizat),
        .rst  (rst),
        .en   (en),
        .limit(4'd9),
        .count(val_numarator)
    );

    ram4x4 memorie_inst (
        .clk     (clk_in),
        .we      (we),
        .addr    (addr),
        .data_in (val_numarator),
        .data_out(val_ram)
    );

    always_comb begin
        if (src_sel == 1'b1)
            out_val = val_numarator;
        else
            out_val = val_ram;
    end

endmodule