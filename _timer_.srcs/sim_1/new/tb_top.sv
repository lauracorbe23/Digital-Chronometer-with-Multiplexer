`timescale 1ns / 1ps

module tb_top;

    logic clk_in;
    logic rst;
    logic en;
    logic we;
    logic [1:0] addr;
    logic src_sel;

    logic [6:0] out_7seg;
    logic [3:0] sel_7seg;
    
    top #(.F(4)) uut (
        .clk_in  (clk_in),
        .rst     (rst),
        .en      (en),
        .we      (we),
        .addr    (addr),
        .src_sel (src_sel),
        .out_7seg(out_7seg),
        .sel_7seg(sel_7seg)
    );

    always begin
        #5 clk_in = ~clk_in;
    end

    initial begin
        
        clk_in  = 0;
        rst     = 0;
        en      = 0;
        we      = 0;
        addr    = 2'b00;
        src_sel = 1; 
        #10;
        rst = 1;
        #50;
        rst = 0;
        #20;
        en = 1;
        #9000; 
        addr = 2'b10;
        we = 1;
        #10;
        we = 0;
        #2000;
        src_sel = 0;
        #2000;
        src_sel = 1;
        #1000;
        en = 0;
        #2000;
        en = 1;
        #3000;
        rst = 1;
        #50;
        rst = 0;
        #1000;

        $finish;
    end

endmodule