source template.tcl

# defining link properties
set edge_link 100.0Mb
set agg_link 100.0Mb
set core_link 100.0Mb

set edge_delay 0.025ms
set agg_delay 0.025ms
set core_delay 0.025ms

set num_hosts 16
set num_nodes 36

# creating nodes
for { set i 0 } { $i <= $num_nodes } { incr i } {
    set n($i) [$ns node]
}

# creating links
$ns duplex-link $n(0) $n(16) $edge_link $edge_delay DropTail
$ns duplex-link $n(1) $n(16) $edge_link $edge_delay DropTail
$ns duplex-link $n(2) $n(17) $edge_link $edge_delay DropTail
$ns duplex-link $n(3) $n(17) $edge_link $edge_delay DropTail
$ns duplex-link $n(4) $n(18) $edge_link $edge_delay DropTail
$ns duplex-link $n(5) $n(18) $edge_link $edge_delay DropTail
$ns duplex-link $n(6) $n(19) $edge_link $edge_delay DropTail
$ns duplex-link $n(7) $n(19) $edge_link $edge_delay DropTail
$ns duplex-link $n(8) $n(20) $edge_link $edge_delay DropTail
$ns duplex-link $n(9) $n(20) $edge_link $edge_delay DropTail
$ns duplex-link $n(10) $n(21) $edge_link $edge_delay DropTail
$ns duplex-link $n(11) $n(21) $edge_link $edge_delay DropTail
$ns duplex-link $n(12) $n(22) $edge_link $edge_delay DropTail
$ns duplex-link $n(13) $n(22) $edge_link $edge_delay DropTail
$ns duplex-link $n(14) $n(23) $edge_link $edge_delay DropTail
$ns duplex-link $n(15) $n(23) $edge_link $edge_delay DropTail
$ns duplex-link $n(16) $n(24) $edge_link $edge_delay DropTail
$ns duplex-link $n(16) $n(25) $edge_link $edge_delay DropTail
$ns duplex-link $n(17) $n(24) $edge_link $edge_delay DropTail
$ns duplex-link $n(17) $n(25) $edge_link $edge_delay DropTail
$ns duplex-link $n(18) $n(26) $edge_link $edge_delay DropTail
$ns duplex-link $n(18) $n(27) $edge_link $edge_delay DropTail
$ns duplex-link $n(19) $n(26) $edge_link $edge_delay DropTail
$ns duplex-link $n(19) $n(27) $edge_link $edge_delay DropTail
$ns duplex-link $n(20) $n(28) $edge_link $edge_delay DropTail
$ns duplex-link $n(20) $n(29) $edge_link $edge_delay DropTail
$ns duplex-link $n(21) $n(28) $edge_link $edge_delay DropTail
$ns duplex-link $n(21) $n(29) $edge_link $edge_delay DropTail
$ns duplex-link $n(22) $n(30) $edge_link $edge_delay DropTail
$ns duplex-link $n(22) $n(31) $edge_link $edge_delay DropTail
$ns duplex-link $n(23) $n(30) $edge_link $edge_delay DropTail
$ns duplex-link $n(23) $n(31) $edge_link $edge_delay DropTail
$ns duplex-link $n(24) $n(32) $edge_link $edge_delay DropTail
$ns duplex-link $n(24) $n(33) $edge_link $edge_delay DropTail
$ns duplex-link $n(25) $n(34) $edge_link $edge_delay DropTail
$ns duplex-link $n(25) $n(35) $edge_link $edge_delay DropTail
$ns duplex-link $n(26) $n(32) $edge_link $edge_delay DropTail
$ns duplex-link $n(26) $n(33) $edge_link $edge_delay DropTail
$ns duplex-link $n(27) $n(34) $edge_link $edge_delay DropTail
$ns duplex-link $n(27) $n(35) $edge_link $edge_delay DropTail
$ns duplex-link $n(28) $n(32) $edge_link $edge_delay DropTail
$ns duplex-link $n(28) $n(33) $edge_link $edge_delay DropTail
$ns duplex-link $n(29) $n(34) $edge_link $edge_delay DropTail
$ns duplex-link $n(29) $n(35) $edge_link $edge_delay DropTail
$ns duplex-link $n(30) $n(32) $edge_link $edge_delay DropTail
$ns duplex-link $n(30) $n(33) $edge_link $edge_delay DropTail
$ns duplex-link $n(31) $n(34) $edge_link $edge_delay DropTail
$ns duplex-link $n(31) $n(35) $edge_link $edge_delay DropTail

# creating link arrays
array set links1 { 0 0 1 16 2 1 3 16 4 2 5 17 6 3 7 17 8 4 9 18 10 5 11 18 12 6 13 19 14 7 15 19 16 8 17 20 18 9 19 20 20 10 21 21 22 11 23 21 24 12 25 22 26 13 27 22 28 14 29 23 30 15 31 23 32 16 33 24 34 16 35 25 36 17 37 24 38 17 39 25 40 18 41 26 42 18 43 27 44 19 45 26 46 19 47 27 48 20 49 28 50 20 51 29 52 21 53 28 54 21 55 29 56 22 57 30 58 22 59 31 60 23 61 30 62 23 63 31 64 24 65 32 66 24 67 33 68 25 69 34 70 25 71 35 72 26 73 32 74 26 75 33 76 27 77 34 78 27 79 35 80 28 81 32 82 28 83 33 84 29 85 34 86 29 87 35 88 30 89 32 90 30 91 33 92 31 93 34 94 31 95 35}
array set links2 { 0 16 1 0 2 16 3 1 4 17 5 2 6 17 7 3 8 18 9 4 10 18 11 5 12 19 13 6 14 19 15 7 16 20 17 8 18 20 19 9 20 21 21 10 22 21 23 11 24 22 25 12 26 22 27 13 28 23 29 14 30 23 31 15 32 24 33 16 34 25 35 16 36 24 37 17 38 25 39 17 40 26 41 18 42 27 43 18 44 26 45 19 46 27 47 19 48 28 49 20 50 29 51 20 52 28 53 21 54 29 55 21 56 30 57 22 58 31 59 22 60 30 61 23 62 31 63 23 64 32 65 24 66 33 67 24 68 34 69 25 70 35 71 25 72 32 73 26 74 33 75 26 76 34 77 27 78 35 79 27 80 32 81 28 82 33 83 28 84 34 85 29 86 35 87 29 88 32 89 30 90 33 91 30 92 34 93 31 94 35 95 31}
set lnk_size [array size links1]

# monitoring links
for { set i 0 } { $i < [expr $lnk_size] } { incr i } {
	set qmon_ab($i) [$ns monitor-queue $n($links1($i)) $n($links2($i)) ""]
	set bing_ab($i) [$qmon_ab($i) get-bytes-integrator];
	set ping_ab($i) [$qmon_ab($i) get-pkts-integrator];
	set fileq($i) "qmon.trace"
	set futil_name($i) "qmon.util"

	append fileq($i) "$links1($i)"
	append fileq($i) "$links2($i)"
	append futil_name($i) "$links1($i)"
	append futil_name($i) "$links2($i)"

set fq_mon($i) [open $fileq($i) w]
	set f_util($i) [open $futil_name($i) w]


	$ns at $STATS_START  "$qmon_ab($i) reset"
	$ns at $STATS_START  "$bing_ab($i) reset"
	$ns at $STATS_START  "$ping_ab($i) reset"
	set buf_bytes [expr 0.00025 * 1000 / 1 ]
	$ns at [expr $STATS_START+$STATS_INTR] "linkDump [$ns link $n($links1($i)) $n($links2($i))] $bing_ab($i) $ping_ab($i) $qmon_ab($i) $STATS_INTR A-B $fq_mon($i) $f_util($i) $buf_bytes"
}


set num_nodes 36;
set num_agents 0
for { set i 0 } { $i < $num_nodes } { incr i } {
	for {set j 0} {$j < $num_nodes} {incr j} {
		set p($num_agents) [new Agent/Ping]
		$ns attach-agent $n($i) $p($num_agents)
		incr num_agents
	}
}


set ite 0
set jStart 0
for { set i 0 } { $i < 36 } { incr i } {
	for { set j $jStart } { $j < 37 } { incr j } {
		if { $j == 36 } {
			set ite [expr $ite + $i + 1]
			continue
		}

		$ns connect $p($ite) $p([expr 36*$j + $i])
		incr ite
	}
	incr jStart
}

set num_agents1 $num_agents
for { set i 0 } { $i < $num_nodes } { incr i } {
	for {set j 0} {$j < $num_nodes} {incr j} {
		set p($num_agents) [new Agent/esdndht]
		$ns attach-agent $n($i) $p($num_agents)
		incr num_agents
	}
}

set ite $num_agents1
set jStart 0
for { set i 0 } { $i < 36 } { incr i } {
	for { set j $jStart } { $j < 37 } { incr j } {
		if { $j == 36 } {
			set ite [expr $ite + $i + 1]
			continue
		}
		$ns connect $p($ite) $p([expr 36*$j + $i + $num_agents1])
		incr ite
	}
	incr jStart
}

# Arguments
set total_senders 16;
# is CDF webSearchCDF?
set webSearchCDF 1;
# sim_time
set sim_time     3;
# random
set num_seed     3;
# 0.7 or 0.5
set mice_load    0.7;
# Bandwidth of the aggregation-core link, Mbps
set ac_bw        1000;

proc esdn-build-tcp { src dst pktSize node_id startTime transfer_size } {
    global ns
    global f_id

    set tcp [new Agent/TCP]
    $ns attach-agent $src $tcp

    set snk [new Agent/TCPSink]
    $ns attach-agent $dst $snk

    $ns connect $tcp $snk

    # $tcp set window_ 10000

    set ftp [$tcp attach-source FTP]
    $tcp set starts $startTime

    $tcp set fid_ $f_id
    incr f_id

    $tcp set sess $f_id
    $tcp set node $node_id
    $tcp set packetSize_ $pktSize
    $tcp set size $transfer_size

    # send one packet
    #$ns at 0.1 "$tcp tcp_send"
    $ns at [expr $startTime - 0.000001] "$tcp tcp_send"

    $ns at $startTime "$tcp flow_start"
    $ns at $startTime "$ftp send $transfer_size"

    # FIXME:: call tcp flow end at end time
    return $tcp
}

puts "Starting Custom CDF files Experiments"

##############################
# Random-number-generation
##############################
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

##################################
# ALL TO ALL SCENARIO
##################################
# already set in template
# set total_senders [expr $num_machine*$num_tor*$num_aggr*$num_core]

##############################
# Get the Source and dest
##############################
set min 0
set max [expr  floor ( $total_senders - 0.0001) ]
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
# Here mice load would be the overall load on the network i.e. 70% 80%..
# btnk_bw is the agg-core aggricated bandwidth(Mbps) in a POD. for 4-ary Fattree it would be 40000 Mbps
# numTors are total no of Tors in the network for A2A traffic and numTors/2 for L2R traffic pattern
set pkSize 1000
set btnk_bw $ac_bw
set numToRs 4

# 40 is packet header size
set av_inter_arrival [expr (($av_file_size*($pkSize+40)*8.0) / ($mice_load*$btnk_bw*1000000))];
set av_inter_arrival [expr $av_inter_arrival / $numToRs];

# This rv is used for generating inter-arrival times
set short_arrival [new RNG];
$short_arrival seed 2

set s_arrival [new RandomVariable/Exponential]
$s_arrival set avg_ $av_inter_arrival
$s_arrival use-rng $short_arrival

# puts $av_inter_arrival
puts "average filesize = $av_file_size"
puts "mean inter-arrival time = $av_inter_arrival";

#############################
# START SIMULATION
#############################

# cannot start at 0 flow tables arent installed.
set global_time 0.2

while { $global_time <= [expr $sim_time/2.0] } {
    # next time after interarrival time
    set inter [expr [$s_arrival value]]
    puts "inter: $inter"

    set global_time [expr $global_time + $inter]
    puts "next global time: $global_time"

    # get transfer size
    set transfer_size [expr ceil ([$rv_nbytes value])]
    set transfer_size [expr $transfer_size*1000]

    # random src and dst
    set sink [expr int (floor ([$short_src value]))]
    set dest [expr int (floor ([$short_src value]))]

    # src and dst not same
    while {$dest == $sink} {
        set dest [expr int (floor ([$short_src value]))]
    }

    # custom TCP function
    puts "src: $sink, dst: $dest, size: [expr $transfer_size/1000] KB, start_time::$global_time"
    # set stcp [esdn-build-tcp $n($sink) $n($dest) $pkSize $sink $global_time $transfer_size]

    # set dest_addr($flow_id) $dest
    # set flow_id [expr $flow_id + 1]
}

puts "sim_time: $sim_time"
puts "mice_load: $mice_load"

set stcp [esdn-build-tcp $n(0) $n(4) $pkSize 0 1.1 $transfer_size]
set stcp [esdn-build-tcp $n(0) $n(4) $pkSize 0 2.1 $transfer_size]

$ns at $sim_time "finish"
$ns run

# Scheduler:: Event UID not valid!
#
# Each event in NS2 has a unique UID. The scheduler toggles the UID twice,
# once during dispatching and once during scheduling. Thus, the event has a
# positive UID after being scheduled and a negative one before being scheduled.
# If the event has been scheduled but not dispatched, then it will have a
# positive UID and cannot be scheduled again.
#
# In implementing a new protocol, this error can happen in two cases:
#
# 1. You are using timers. When a timer is scheduled again without the
# previous schedule expiring - Trace which timer is scheduled and when it
# will expire.
#
# 2. You are dealing with packets. A packet is also a kind of event to be
# scheduled and a UID is associated with it. When you create a
# copy or alloc again before freeing it, due to the same packet with a positive
# UID, it cannot be scheduled again.

