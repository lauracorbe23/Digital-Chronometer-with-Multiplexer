`timescale 1ns / 1ps

module decodor_0hot (
    input  logic [1:0] sel,
    output logic [3:0] out
);

    always_comb begin
        case (sel)
            2'b00:   out = 4'b1110;
            2'b01:   out = 4'b1101;
            2'b10:   out = 4'b1011;
            2'b11:   out = 4'b0111;
            default: out = 4'b1111;
        endcase
    end

endmodule