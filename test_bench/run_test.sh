iverilog -g2012 -o smooth_led smooth_led_tb.sv
vvp smooth_led
gtkwave smooth_led_tb.vcd

rm -rf smooth_led.vcd smooth_led