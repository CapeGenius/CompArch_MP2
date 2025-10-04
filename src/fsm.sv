`include "pwm.sv"
`include "fade.sv"

module fsm #(
    parameter PWM_INTERVAL = 1800,
    parameter MAX_PHASES = 6
)(
    input logic clk,
    output logic  red,
    output logic  green,
    output logic  blue
);

    localparam phase_interval = 2000000;
    localparam constant_on = 1'b1;
    localparam constant_off= 1'b0;
    // declare red, blue, and green

    logic [$clog2(phase_interval) - 1 : 0 ] counter;
    logic [$clog2(MAX_PHASES) - 1 : 0] phases;
    logic [$clog2(PWM_INTERVAL) - 1 : 0] pwm_value;
    

    // declare pwm out and phase out
    logic pwm_out;

    initial begin
        counter <= 0;
        phases <= 0; 
    end

    fade #(
        .PWM_INTERVAL   (PWM_INTERVAL)
    ) u1 (
        .clk            (clk),
        .pwm_value      (pwm_value)
    );

    pwm #(
        .PWM_INTERVAL   (PWM_INTERVAL)
    ) u2 (
        .clk            (clk),
        .pwm_value      (pwm_value),
        .pwm_out        (pwm_out)
    );

    always_ff @( posedge clk) begin

        if (counter == phase_interval - 1) begin
            counter <= 0; 
            
            if (phases == MAX_PHASES - 1) begin
                phases <= 0;
            end
            else begin
                phases <= phases + 1;
            end
        end
        else begin
            counter <= counter + 1;
        end

    end

    always_comb begin

        {red, green, blue} = 3'b000;

        case (phases)
            0: {red, green, blue} = {constant_on, pwm_out, constant_off};
            1: {red, green, blue} = {pwm_out, constant_on, constant_off};
            2: {red, green, blue} = {constant_off, constant_on, pwm_out};
            3: {red, green, blue} = {constant_off, pwm_out, constant_on};
            4: {red, green, blue} = {pwm_out, constant_off, constant_on};
            5: {red, green, blue} = {constant_on, constant_off, pwm_out};
            default: {red, green, blue} = 3'bxxx;
        endcase 
    end

endmodule