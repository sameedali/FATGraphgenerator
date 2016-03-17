# Helper functions
# source twoway_basic_functions.tcl

# Custom build TCP function
proc esdn-build-tcp { src dst pktSize node_id startTime transfer_size } {
    global ns
    global time_tcp
    global time_increment
    global f_id

    set tcp [new Agent/TCP]
    $ns attach-agent $src $tcp

    set snk [new Agent/TCPSink]
    $ns attach-agent $dst $snk

    $ns connect $tcp $snk

    $tcp set window_ 10000

    set ftp [$tcp attach-source FTP]

    $tcp set starts $startTime

    $tcp set fid_ $f_id
    incr f_id

    $tcp set sess $f_id
    $tcp set node $node_id
    $tcp set packetSize_ $pktSize
    $tcp set size $transfer_size

    $ns at 0.1 "$tcp tcp_send"
    set time_tcp [expr $time_tcp + $time_increment]

    $ns at $startTime "$tcp flow_start"
    $ns at $startTime "$ftp send [$tcp set size]"
    return $tcp
}

# Arguments
# set total_senders [expr $num_machine*$num_tor*$num_aggr*$num_core]
# is CDF webSearchCDF?
set webSearchCDF [expr [lindex $argv 0]];
# sim_time
set sim_time     [expr [lindex $argv 1]];
# random
set num_seed     [expr [lindex $argv 2]];
# 0.7 or 0.5
set mice_load    [expr [lindex $argv 3]];
# (~ 1000) Bandwidth of the aggregation-core link, Mbps
set ac_bw        [expr [lindex $argv 4]];

puts "Starting Custom CDF files Experiments"
################################################################################
# Random-number-generation
################################################################################
# num-seed is random number from CL
set run_i $num_seed
set s [expr 33*($run_i+1)+4369*($run_i+3)]

set rng2 [new RNG]

$rng2 seed $s
set rv_nbytes [new RandomVariable/Empirical];
$rv_nbytes use-rng $rng2
$rv_nbytes set interpolation_ 2

# load CDF file
$rv_nbytes loadCDF "CDF.tcl"
puts "FlowSize: Empirical Distribution from CDF.tcl"

# average flow size
if { $webSearchCDF == 1} {
    set av_file_size 1141
} else {
    # DATA MINING
    set av_file_size 5116
}

# ALREADY SET IN TEMPLATE
# set total_senders [expr $num_machine*$num_tor*$num_aggr*$num_core]
# total_senders are total number of end hosts available

################################################################################
# Deciding on the Source and destination
################################################################################
set min 0
set max [expr $total_senders - 0.0001 ]
puts "min = $min and max = $max"

# This rv is used for picking source and destination nodes for short flows
set sender_num [new RNG];

$sender_num seed $run_i

set short_src [new RandomVariable/Uniform]
$short_src use-rng $sender_num
$short_src set min_ [expr $min]
$short_src set max_ [expr $max]
################################################################################
# Generating Inter-Arrival Times
################################################################################
set ratio [expr 2.0*($total_senders-1)/$total_senders]

puts "Ratio: $ratio"

# 1000000 has been multiplied because bneck_bw is in Mbps
set av_inter_arrival [expr (($av_file_size*(1000)*8.0*100) / ($ratio*$mice_load*$ac_bw*1000000))];

# puts $av_inter_arrival
puts "average filesize = $av_file_size"
puts "mean inter-arrival time = $av_inter_arrival";

# This rv is used for generating inter-arrival times
set short_arrival [new RNG];
$short_arrival seed 2
set s_arrival [new RandomVariable/Exponential]
$s_arrival set avg_ $av_inter_arrival
$s_arrival use-rng $short_arrival

################################################################################
# START SIMULATION
################################################################################
set global_time 0.5
puts "Building flows: (pktSize 1000)"

while { $global_time <= [expr $sim_time/2.0] } {
    set inter [expr [$s_arrival value]]
    set global_time [expr $global_time + $inter]

    set transfer_size [expr ceil ([$rv_nbytes value])]
    set transfer_size [expr $transfer_size*1000]
    set sink [expr int (floor ([$short_src value]))]
    set dest [expr int (floor ([$short_src value]))]

    # if {$shortie == 1 } {
    #     $ns at $global_time "set_buffer $sink $flow_id"
    # }

    while {$dest == $sink} {
        set dest [expr int (floor ([$short_src value]))]
    }

    # custom TCP function
    puts "src: $sink, dst: $dest, size: [expr $transfer_size/1000] KB, start_time::$global_time"
    set stcp [esdn-build-tcp $n($sink) $n($dest) 1000 $sink $global_time $transfer_size]

    # set dest_addr($flow_id) $dest
    # set flow_id [expr $flow_id + 1]
}

$ns at $sim_time "finish"
