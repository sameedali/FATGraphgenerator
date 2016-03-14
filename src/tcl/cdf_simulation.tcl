puts "Sourcing CDF simulation tcl file"

# Create Short-lived TCP flows
proc build-short-lived-tcp=flows { src dest pktSize fid node_id startTime tcp_src tcp_sink transfer_size} {
    global ns

    set tcp [$ns create-connection $tcp_src $src $tcp_sink $dest fid]
    $tcp set window_ 10000
    $tcp set fid_ $fid
    set ftp [$tcp attach-source FTP]

    $tcp set starts $startTime
    $tcp set sess $fid
    $tcp set node $node_id
    $tcp set packetSize_ $pktSize
    $tcp set size $transfer_size

    $ns at [$tcp set starts] "$ftp send [$tcp set size]"
    return $tcp
}

##########################################################################
#   The follwoing code has been borrowed but edits are my own - Sameed   #
##########################################################################

##########################################################################
# Custom Distribution Files
##########################################################################

# LOAD CUSTOM DISTRIBUTION FILES ACTIVATED HERE
puts "Starting Custom CDF files Experiments"

set run_i $num_seed
set s [expr 33*($run_i+1)+4369*($run_i+3)]

set rng2 [new RNG]
$rng2 seed $s
set rv_nbytes [new RandomVariable/Empirical];
$rv_nbytes use-rng $rng2
$rv_nbytes set interpolation_ 2

# load the CDF file
$rv_nbytes loadCDF "CDF_file.tcl"
puts "FlowSize: Empirical Distribution from CDF_file.tcl"

puts "Starting ALL To ALL Experiments for Custom CDF's"

# Define avg file size
set av_file_size 1141

set total_senders [expr $num_machine*$num_tor*$num_aggr*$num_core]

########################################
# Deciding on the Source and destination

set min 0
set max $total_senders-0.0001
puts "min = $min and max = $max"

set sender_num [new RNG];                     # This rv is used for picking source and destination nodes for short flows
$sender_num seed $run_i
set short_src [new RandomVariable/Uniform]
$short_src use-rng $sender_num
$short_src set min_ [expr $min]
$short_src set max_ [expr $max]

#########################################
# Generating Inter-Arrival Times
#########################################
set ratio [expr 2.0*($total_senders-1)/$total_senders]

puts "Ratio: $ratio"
# 1000000 has been multiplied because
set av_inter_arrival [expr (($av_file_size*(1000)*8.0*100) / ($ratio*$mice_load*$ac_bw*1000000))];

#bneck_bw is in Mbps
# puts $av_inter_arrival
puts "average filesize = $av_file_size"
puts "mean inter-arrival time = $av_inter_arrival";
set short_arrival [new RNG];                  # This rv is used for generating inter-arrival times
$short_arrival seed 2
set s_arrival [new RandomVariable/Exponential]
$s_arrival set avg_ $av_inter_arrival
$s_arrival use-rng $short_arrival

# INIT FLOW
set tcp1 [build-tcp $n(0) $n(8) 1.5 2.8];

$tcp1 set packetSize_ 1000
set ftp [new Application/FTP]
$ftp attach-agent $tcp

set global_time 1.6
$tcp set starts $global_time
$tcp set sess 1
$tcp set node $n(8)
$ns at $global_time "$ftp send $transfer_size"
$tcp set signal_on_empty_ TRUE

# set global_time 0.0
# set i 0
#
# while { $global_time <= [expr $sim_time/2.0] } {
#
#     set inter [expr [$s_arrival value]]
#     set global_time [expr $global_time + $inter]
#
#
#     set transfer_size [expr ceil ([$rv_nbytes value])]
#     set transfer_size [expr $transfer_size*1000]
#     set sink [expr int (floor ([$short_src value]))]
#     set dest [expr int (floor ([$short_src value]))]
#
#     if {$shortie == 1 } {
#         $ns at $global_time "set_buffer $sink $flow_id"
#     }
#
#     while {$dest == $sink} {
#         set dest [expr int (floor ([$short_src value]))]
#     }
#
#     if {$pfabric == 0} {
#
#         set stcp [build-short-lived $m($sink) $m($dest) 1000 $flow_id $sink $global_time $SRC $SINK $transfer_size]
#         set dest_addr($flow_id) $dest
#
#     } else {
#
#         set tcp($i) [new Agent/TCP]
#         set sink_dctcp($i) [new Agent/TCP]
#
#         $sink_dctcp($i) listen
#
#
#         $ns attach-agent $m($sink) $tcp($i)
#         $ns attach-agent $m($dest) $sink_dctcp($i)
#
#         $tcp($i) set fid_ [expr $flow_id]
#         $sink_dctcp($i) set fid_ [expr $flow_id]
#
#         $tcp($i) set packetSize_ 1000
#         $ns connect $tcp($i) $sink_dctcp($i)
#         set ftp($i) [new Application/FTP]
#         $ftp($i) attach-agent $tcp($i)
#
#         $tcp($i) set starts $global_time
#         $tcp($i) set sess $flow_id
#         $tcp($i) set node $sink
#         $ns at $global_time "$ftp($i) send $transfer_size"
#         $tcp($i) set signal_on_empty_ TRUE
#         set i [expr $i + 1]
#     }
#
#     puts "flow $flow_id of size [expr $transfer_size/1000] KB generated at $global_time from node $sink to node $dest"
#
#     set flow_id [expr $flow_id + 1]
# }

puts "Completed sourcing CDF file"
