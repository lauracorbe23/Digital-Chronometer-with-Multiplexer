`timescale 1ns / 1ps

module counter (
    input  logic       clk,
    input  logic       rst,
    input  logic       en,
    input  logic [3:0] limit,
    output logic [3:0] count
);

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            count <= 4'b0000;
        end
        else if (en == 1'b1) begin
            if (count >= limit) begin
                count <= 4'b0000; 
            end
            else begin
                count <= count + 1;
            end
        end
    end

endmodule