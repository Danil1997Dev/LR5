set name TB
 
vlib work
 
vlog "*.v"       
 
vsim -voptargs=+acc work.$name

# Set the window types 
view wave
view structure
view signals
#add wave 
add wave -noupdate -divider {all}
add wave -noupdate -radix unsigned sim:/$name/* 
add wave -noupdate -divider {uut} 
add wave -noupdate -radix unsigned sim:/$name/uut/* 
add wave -noupdate -divider {btnf_r} 
add wave -noupdate -radix unsigned sim:/$name/uut/btnf_r/* 
add wave -noupdate -divider {gce}
add wave -noupdate -radix unsigned sim:/$name/uut/gce/* 
add wave -noupdate -divider {shr}
add wave -noupdate -radix unsigned sim:/$name/uut/shr/* 
add wave -noupdate -divider {main}
add wave -noupdate -radix unsigned sim:/$name/uut/main/* 
add wave -noupdate -divider {pwm0}
add wave -noupdate -radix unsigned sim:/$name/uut/pwm0/* 
add wave -noupdate -divider {pwm15}
add wave -noupdate -radix unsigned sim:/$name/uut/pwm15/* 
run -all

#00110110011110010111001001101100
#00110110111110010111001001101100