
# get number of cpus
source num_of_cpu.tcl
set N [num_of_cpu]

# 计时开始
set start [clock seconds]

# 创建工程
set orig_proj_dir  ./project
set origin_dir     ./
source create_project.tcl

# 开始编译
launch_runs synth_1 -jobs $N
wait_on_run synth_1


# 生成bin/bit文件
set_property STEPS.WRITE_BITSTREAM.ARGS.BIN_FILE true [get_runs impl_1]

# 布局布线
launch_runs impl_1 -to_step write_bitstream -jobs $N
wait_on_run impl_1


# 计时结束
set stop [clock seconds]
set seconds [expr $stop - $start]
puts "take $seconds seconds!"

# 开启GUI
# start_gui
