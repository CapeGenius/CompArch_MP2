
iverilog -g2012 -o smooth_led smooth_led_tb.sv
vvp smooth_led
gtkwave smooth_led_tb.vcd

mv smooth_led test_bench/smooth_led
mv smooth_led_tb.vcd test_bench/smooth_led_tb.vcd