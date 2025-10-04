`timescale 10ns/10ns
`include "../src/top.sv"

module smooth_led_tb;

    parameter PWM_INTERVAL = 1800;

    logic clk = 0;
    logic RGB_R;
    logic RGB_B;
    logic RGB_G;

    top # (
        .PWM_INTERVAL   (PWM_INTERVAL)
    ) u0 (
        .clk                (clk),
        .RGB_R              (RGB_R),
        .RGB_G              (RGB_G),
        .RGB_B              (RGB_B)
    );

    initial begin
        $dumpfile("smooth_led_tb.vcd");
        $dumpvars(0, smooth_led_tb);
        #120000000
        $finish;
    end

    always begin
        #4
        clk = ~clk;
    end

endmodule

