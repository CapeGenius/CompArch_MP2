`include "fsm.sv"

module top #(
    parameter PWM_INTERVAL = 1800,
    parameter MAX_PHASES = 6
)(
    input logic clk,
    output logic  RGB_R,
    output logic  RGB_G,
    output logic  RGB_B
);
    // declare red, blue, and green
    logic red, blue, green;


    fsm #(
        .PWM_INTERVAL   (PWM_INTERVAL),
        .MAX_PHASES     (MAX_PHASES)
    ) fsm_module (
        .clk            (clk),
        .red            (red),
        .green          (green),
        .blue           (blue)
    );

    assign RGB_R = ~red;
    assign RGB_G = ~green;
    assign RGB_B = ~blue;


endmodule