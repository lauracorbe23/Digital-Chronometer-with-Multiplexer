`timescale 1ns / 1ps

module top #(
    parameter int F = 50000 
)(
    input  logic       clk_in,
    input  logic       rst,
    input  logic       en,
    input  logic       we,
    input  logic [1:0] addr,
    input  logic       src_sel,
    output logic [6:0] out_7seg,
    output logic [3:0] sel_7seg
);

    logic       clk_1ms;
    logic [3:0] sel_cnt;
    logic [3:0] val_10ms;
    logic [3:0] val_100ms;
    logic [3:0] val_1s;
    logic [3:0] val_10s;
    logic [3:0] cifra_curenta;

    freq_div div_1ms (
        .clk_in (clk_in),
        .rst    (rst),
        .factor (32'(F)),
        .clk_out(clk_1ms)
    );

    counter cnt_afisaj (
        .clk  (clk_1ms),
        .rst  (rst),
        .en   (1'b1),
        .limit(4'd3),
        .count(sel_cnt)
    );

    // Instantierea celor 4 timere
    timer timer_10ms (
        .clk_in (clk_in),
        .rst    (rst),
        .en     (en),
        .we     (we),
        .addr   (addr),
        .factor (32'(10 * F)),
        .src_sel(src_sel),
        .out_val(val_10ms)
    );

    timer timer_100ms (
        .clk_in (clk_in),
        .rst    (rst),
        .en     (en),
        .we     (we),
        .addr   (addr),
        .factor (32'(100 * F)),
        .src_sel(src_sel),
        .out_val(val_100ms)
    );

    timer timer_1s (
        .clk_in (clk_in),
        .rst    (rst),
        .en     (en),
        .we     (we),
        .addr   (addr),
        .factor (32'(1000 * F)),
        .src_sel(src_sel),
        .out_val(val_1s)
    );

    timer timer_10s (
        .clk_in (clk_in),
        .rst    (rst),
        .en     (en),
        .we     (we),
        .addr   (addr),
        .factor (32'(10000 * F)),
        .src_sel(src_sel),
        .out_val(val_10s)
    );

    always_comb begin
        case (sel_cnt[1:0])
            2'b00: cifra_curenta = val_10ms;
            2'b01: cifra_curenta = val_100ms;
            2'b10: cifra_curenta = val_1s;
            2'b11: cifra_curenta = val_10s;
            default: cifra_curenta = 4'd0;
        endcase
    end

    transcoder_7seg trans_inst (
        .val(cifra_curenta),
        .seg(out_7seg)
    );

    decodor_0hot dec_inst (
        .sel(sel_cnt[1:0]),
        .out(sel_7seg)
    );

endmodule