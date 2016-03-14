# written by Aisha and Asad

source twoway_basic_functions.tcl

#Create a Simulator object
set ns [new Simulator]

#set nf [open out.nam w]
#$ns namtrace-all $nf

# input parameters
set num_machine		[expr [lindex $argv 0]]; # number of machines per TOR
set num_tor		[expr [lindex $argv 1]]; # number of TORs per aggregation switch
set num_aggr		[expr [lindex $argv 2]]; # number of aggregation switches per core
set num_core		[expr [lindex $argv 3]]; # number of core switches
set ac_bw		[expr [lindex $argv 4]]; # bandwidth of the aggregation-core link, Mbps
set ta_bw		[expr [lindex $argv 5]]; # bandwidth of the tor-aggregation link, Mbps
set mt_bw		[expr [lindex $argv 6]]; # bandwidth of the machine-tor link, Mbps
set rttp		[expr [lindex $argv 7]]; # round trip propogation delay, ms
set sim_time            [expr [lindex $argv 8]]; # simulation time, secs


set buffratio		[expr [lindex $argv 9]]; # size of the buffer, bdp
set base_buf		[expr [lindex $argv 10]];

set SRC			[lindex $argv 11];
set SINK		[lindex $argv 12];
set QUEUE		[lindex $argv 13];

set min_fsize		[expr [lindex $argv 14]]; # minimum filesize
set max_fsize           [expr [lindex $argv 15]]; # maximum filesize

set mice_load		[expr [lindex $argv 16]];
set pareto_rate		[expr [lindex $argv 17]];
set incast_senders	[expr [lindex $argv 18]];
set chunk_data		[expr [lindex $argv 19]];
set incast_load		[expr [lindex $argv 20]];

set num_long		[expr [lindex $argv 21]];

set min_rto		[expr [lindex $argv 22]];

set STATS_START 0.0
set STATS_INTR		[expr [lindex $argv 23]];

set protocol		[lindex $argv 24];

set increment		[expr [lindex $argv 25]];
set num_seed		[expr [lindex $argv 26]];
set marking_thresh	[expr [lindex $argv 27]];
set check		[expr [lindex $argv 28]];

#pfabric params
set slowstartrestart	[expr [lindex $argv 29]];
set ackRatio		[expr [lindex $argv 30]];
set prio_scheme_	[expr [lindex $argv 31]];
set prob_cap_		[expr [lindex $argv 32]];
set drop_prio_		[lindex $argv 33];
set deque_prio_		[lindex $argv 34];
set keep_order_		[lindex $argv 35];
set enablePQ		[expr [lindex $argv 36]];
set PQ_mode		[expr [lindex $argv 37]];
set PQ_gamma		[expr [lindex $argv 38]];
set PQ_thresh		[expr [lindex $argv 39]];
set enablePacer		[expr [lindex $argv 40]];
set Pacer_assoc_timeout         [expr [lindex $argv 41]];
set Pacer_assoc_prob		[expr [lindex $argv 42]];
set Pacer_qlength_factor	[expr [lindex $argv 43]];
set Pacer_rate_ave_factor	[expr [lindex $argv 44]];
set Pacer_rate_update_interval  [expr [lindex $argv 45]];

#long buffer
set l_buf       [expr [lindex $argv 46]];
set all         [expr [lindex $argv 47]];
set custom	[expr [lindex $argv 48]];
set webSearchCDF	[expr [lindex $argv 49]];
set interR      [expr [lindex $argv 50]];

set shortie 0
set pfabric 0


###################################################################
#setting ns parameters

set bdp [expr ceil($rttp * $ac_bw / 8.0) ];
set long_buf $bdp
set f_btnk_buf			[expr ceil($buffratio * $rttp * $ac_bw / 8.0) ]; #in 1KB packet

Agent/TCP set window_ 100000
Agent/TCP set maxcwnd_ 100000

Agent/TCP set tcpTick_ 0.000001
Agent/TCP set minrto_ $min_rto ; # minRTO = 200ms & 10ms (To avoid incast)
Agent/TCP set rtxcur_init_ $min_rto ;

if {$protocol == "mulbuff" } {

        puts "MulBuff has been enabled"

        set other_buf $base_buf
        set long_buf $l_buf
        puts "short buffer $other_buf"
        puts "long buffer $long_buf"

        set f_buf [open fp_queue_size w]
        set shortie 1

        Queue/DropTail set nl_ $num_long
        Queue set limit_two_ $long_buf; #in 1KB packet
        Queue set upper_limit_ [expr $f_btnk_buf - $long_buf];
        Queue/DropTail set base_ $other_buf
        Queue/DropTail set increment_ $increment

} elseif { $protocol == "dctcp" } {

        puts "DCTCP has been enabled"

        set K $marking_thresh ; # marking threshold
        set DCTCP_g_ 0.0625
        set packetSize 1000
        set QUEUE RED

        Agent/TCP set ecn_ 1
        Agent/TCP set old_ecn_ 1
        Agent/TCP set slow_start_restart_ false
        Agent/TCP set windowOption_ 0
        Agent/TCP set dctcp_ true
        Agent/TCP set dctcp_g_ $DCTCP_g_;

        Queue/RED set bytes_ false
        Queue/RED set queue_in_bytes_ true
        Queue/RED set mean_pktsize_ $packetSize
        Queue/RED set setbit_ true
        Queue/RED set gentle_ false
        Queue/RED set q_weight_ 1.0
        Queue/RED set mark_p_ 1.0
        Queue/RED set thresh_ [expr $K]
        Queue/RED set maxthresh_ [expr $K]

        DelayLink set avoidReordering_ true
} elseif { $protocol == "dctcp-mulbuff" } {

        set other_buf $base_buf
        set long_buf $l_buf
        puts "short buffer $other_buf"
        puts "long buffer $long_buf"

        set f_buf [open fp_queue_size w]
        set shortie 1

        Queue/RED set base_ $other_buf ;
        Queue/RED set increment_ $increment ;
        Queue/RED set nl_ $num_long ;
        Queue set limit_two_ $long_buf; #in 1KB packet
        Queue set upper_limit_ [expr $f_btnk_buf - $long_buf]
        Queue/DropTail set base_ $other_buf
        Queue/DropTail set increment_ $increment

        set K $marking_thresh ; # marking threshold
        set DCTCP_g_ 0.0625
        set packetSize 1000
        set QUEUE RED


        puts "marking thresh = $K"
        Agent/TCP set ecn_ 1
        Agent/TCP set old_ecn_ 1
        Agent/TCP set slow_start_restart_ false
        Agent/TCP set windowOption_ 0
        Agent/TCP set dctcp_ true
        Agent/TCP set dctcp_g_ $DCTCP_g_;

        Queue/RED set bytes_ false
        Queue/RED set queue_in_bytes_ true
        Queue/RED set mean_pktsize_ $packetSize
        Queue/RED set setbit_ true
        Queue/RED set gentle_ false
        Queue/RED set q_weight_ 1.0
        Queue/RED set mark_p_ 1.0
        Queue/RED set thresh_ [expr $K]
        Queue/RED set maxthresh_ [expr $K]

        DelayLink set avoidReordering_ true
} elseif { $protocol == "pfabric" } {


        set SRC "TCP/FullTcp/Sack/MinTCP"
        set SINK "TCP/FullTcp/Sack/MinTCP"
        set pktSize 1000
        set DCTCP_g 0.0625
        set link_rate [expr $ac_bw/1000.0]
        set queueSize [expr 2*$bdp]
        set pfabric 1
        set K 100000

        Agent/TCP set ecn_ 1
        Agent/TCP set old_ecn_ 1
        Agent/TCP set packetSize_ $pktSize
        Agent/TCP/FullTcp set segsize_ $pktSize
        Agent/TCP/FullTcp set spa_thresh_ 0
        Agent/TCP set windowInit_ $bdp; #in 1KB packet #bdp
        Agent/TCP set slow_start_restart_ $slowstartrestart
        Agent/TCP set windowOption_ 0
        Agent/TCP set minrto_ [expr 3*$rttp/1000];
        Agent/TCP set rtxcur_init_ [expr 3*$rttp/1000];
        Agent/TCP set maxrto_ 2
        Agent/TCP/FullTcp set nodelay_ true; # disable Nagle
        Agent/TCP/FullTcp set segsperack_ $ackRatio;
        Agent/TCP/FullTcp set interval_ 0.000006

        if {$ackRatio > 2} {
            Agent/TCP/FullTcp set spa_thresh_ [expr ($ackRatio - 1) * $pktSize]
        }

        Agent/TCP set ecnhat_ true;   #if SACK
        Agent/TCPSink set ecnhat_ true ; #if SACK
        Agent/TCP set ecnhat_g_ $DCTCP_g; #if SACK

        Agent/TCP/FullTcp set prio_scheme_ $prio_scheme_;
        Agent/TCP/FullTcp set dynamic_dupack_ 1000000; #disable dupack
        Agent/TCP/FullTcp/Sack set clear_on_timeout_ false;
        Agent/TCP/FullTcp/Sack set sack_rtx_threshmode_ 2;

        if {$queueSize > $bdp} { ; #bdp
           Agent/TCP set maxcwnd_ [expr $queueSize - 1];
        } else {
           Agent/TCP set maxcwnd_ $bdp; #bdp
        }
        Agent/TCP/FullTcp set prob_cap_ $prob_cap_;

        Queue set limit_ $queueSize

        Queue/DropTail set queue_in_bytes_ true; #false
        Queue/DropTail set drop_prio_ $drop_prio_
        Queue/DropTail set deque_prio_ $deque_prio_
        Queue/DropTail set keep_order_ $keep_order_

        Queue/RED set bytes_ false
        Queue/RED set queue_in_bytes_ true; #false
        Queue/RED set mean_pktsize_ $pktSize
        Queue/RED set setbit_ true
        Queue/RED set gentle_ false
        Queue/RED set q_weight_ 1.0
        Queue/RED set mark_p_ 1.0
        Queue/RED set thresh_ $K
        Queue/RED set maxthresh_ $K
        Queue/RED set drop_prio_ $drop_prio_
        Queue/RED set deque_prio_ $deque_prio_

        if {$enablePQ == 1} {
            Queue/RED set pq_enable_ 1
            Queue/RED set pq_mode_ $PQ_mode ; # 0 = Series, 1 = Parallel
            Queue/RED set pq_drainrate_ [expr $PQ_gamma * $link_rate * 1000000]
            Queue/RED set pq_thresh_ $PQ_thresh
            #Queue/RED set thresh_ 100000
            #Queue/RED set maxthresh_ 100000
        }
        if {$enablePacer == 1} {
            TBF set bucket_ [expr 3100 * 8]
            TBF set qlen_ 10000
            TBF set pacer_enable_ 1
            TBF set assoc_timeout_ $Pacer_assoc_timeout
            TBF set assoc_prob_ $Pacer_assoc_prob
            TBF set maxrate_ [expr $link_rate * 1000000]
            TBF set minrate_ [expr 0.01 * $link_rate * 1000000]
            TBF set rate_ [expr $link_rate * 1000000]
            TBF set qlength_factor_ $Pacer_qlength_factor
            TBF set rate_ave_factor_ $Pacer_rate_ave_factor
            TBF set rate_update_interval_ $Pacer_rate_update_interval
        }

        $ns rtproto DV
        Agent/rtProto/DV set advertInterval [expr 2*$sim_time]
        Node set multiPath_ 1
}

###################################################################
# Get these from the template file
{{{
#sanity checks
# if {$num_core < 1} {
#         set num_core 1
# }
#
# if {$num_aggr < 2} {
#         set num_aggr 2
# }
#
# if {$num_tor < 1} {
#         set num_tor 1
# }
#
# if {$num_machine < 1} {
#         set num_machine 1
# }
#
# if {$incast_senders > 0 } {
#         set num_machine [expr $incast_senders + 1]
#         set num_tor 1
#         set num_aggr 1
#         set num_core 1
# }
}}}
###################################################################
###################################################################

#Setting buffer sizes
set ac_btnk_buf                 [expr ceil($buffratio * $rttp * $ac_bw / 8.0) ]; #in 1KB packet
set ta_btnk_buf                 [expr ceil($buffratio * $rttp * $ta_bw / 8.0) ]; #in 1KB packet
set mt_btnk_buf                 [expr ceil($buffratio * $rttp * $mt_bw / 8.0) ]; #in 1KB packet
puts "machine = $num_machine TORS = $num_tor Aggr = $num_aggr core = $num_core bdp = $buffratio rttp = $rttp bandwidth = $ac_bw time =$sim_time"

if {$shortie == 1 } {
        set ac_btnk_buf $other_buf ; #setting short buf to 5pkts
        set ta_btnk_buf $other_buf ; #setting short buf to 5pkts
        set mt_btnk_buf $other_buf ; #setting short buf to 5pkts
        puts "Short flow marking enabled"
} elseif { $pfabric == 1 } {
        set ac_btnk_buf $queueSize ; #setting buf to 2 * bdp pkts
        set ta_btnk_buf $queueSize ; #setting buf to 2*bdp pkts
        set mt_btnk_buf $queueSize ; #setting buf to 2*bdp pkts
        puts "Pfabric buffering"
}

for {set i 0} { $i < [expr $num_aggr*$num_core] } {incr i} {
        set a_btnk($i) $ac_btnk_buf
        set a_count($i) 0
}
for {set i 0} { $i < [expr $num_tor*$num_aggr*$num_core] } {incr i} {
        set t_btnk($i) $ta_btnk_buf
        set t_count($i) 0
}
for {set i 0} { $i < [expr $num_machine*$num_tor*$num_aggr*$num_core] } {incr i} {
        set m_btnk($i) $mt_btnk_buf
        set m_count($i) 0
}

puts "Buffer Size (Set according to the Rule of Thumb) = $ac_btnk_buf pkts"
puts "Buffer Size (Set according to the Rule of Thumb) = $ta_btnk_buf pkts"
puts "Buffer Size (Set according to the Rule of Thumb) = $mt_btnk_buf pkts"
set buf_bytes         [expr $ac_btnk_buf * 1000]


###################################################################
#begin: Setup topology



# setup nodes and links between them
# set queue sizes
for {set i 0} { $i < [expr $num_core] } {incr i} {
        set c($i) [$ns node]
}

set delay $rttp/12.0

for {set i 0} { $i < [expr $num_aggr*$num_core] } {incr i} {
        set a($i) [$ns node]
        $ns duplex-link $a($i) $c([expr int(floor($i/$num_aggr))]) [expr $ac_bw]Mb [expr $delay]ms $QUEUE
        $ns queue-limit $a($i) $c([expr int(floor($i/$num_aggr))]) [expr $a_btnk($i)] ; # set forward queue size
        $ns queue-limit $c([expr int(floor($i/$num_aggr))]) $a($i) [expr $a_btnk($i)]	; # set reverse queue size
}

for {set i 0} { $i < [expr $num_tor*$num_aggr*$num_core] } {incr i} {
        set t($i) [$ns node]
        $ns duplex-link $t($i) $a([expr int( floor ($i/$num_tor))]) [expr $ta_bw]Mb [expr $delay]ms $QUEUE
        $ns queue-limit $t($i) $a([expr int( floor ($i/$num_tor))]) [expr $t_btnk($i)] ; # set forward queue size
        $ns queue-limit $a([expr int ( floor ($i/$num_tor))]) $t($i) [expr $t_btnk($i)]	; # set reverse queue size

}

for {set i 0} { $i < [expr $num_machine*$num_tor*$num_aggr*$num_core] } {incr i} {
        set m($i) [$ns node]
        $ns duplex-link $m($i) $t([expr int ( floor ($i/$num_machine))]) [expr $mt_bw]Mb [expr $delay]ms $QUEUE
        $ns queue-limit $m($i) $t([expr int ( floor ($i/$num_machine))]) [expr $m_btnk($i)] ; # set forward queue size
        $ns queue-limit $t([expr int ( floor ($i/$num_machine))]) $m($i) [expr $m_btnk($i)] ; # set reverse queue size

}

#end: setup topology
###################################################################
###################################################################
# begin: flow generation

set flow_id 0

if {$check > 0 } {

        set total_senders [expr $num_machine*$num_tor*$num_aggr*$num_core / 2]

        puts "short flows are $check"
        for {set sink 0} { $sink < $check } { incr sink } {
                set global_time 0.0
                if {$shortie == 1 } {
                #	$ns at $global_time "set_buffer $sink"
                }

                set transfer_s [expr 1024*1024*1024]
                set dest [expr $sink + $total_senders]
                set mstcp($sink) [build-short-lived $m($sink) $m($dest) 1000 $flow_id $sink $global_time $SRC $SINK $transfer_s]
                $mstcp($sink) set window_ 19
                $mstcp($sink) set maxcwnd_ 19
                puts "flow $flow_id of size [expr $transfer_s/1000] KB generated at $global_time from node $sink to node $dest"

                set flow_id [expr $flow_id + 1]
        }
}

##########################################################################
# Custom Distribution Files
##########################################################################

if {$custom == 1} {
        puts "Starting Custom CDF files Experiments"

        set run_i $num_seed
        set s [expr 33*($run_i+1)+4369*($run_i+3)]

        set rng2 [new RNG]
        $rng2 seed $s
        set rv_nbytes [new RandomVariable/Empirical];
        $rv_nbytes use-rng $rng2
        $rv_nbytes set interpolation_ 2
        if { $webSearchCDF == 1 } {
                $rv_nbytes loadCDF "CDF_dctcp.tcl"
                puts "FlowSize: Empirical Distribution from CDF_dctcp.tcl (WEB SEARCH)"
        } else {
                $rv_nbytes loadCDF "CDF.tcl"
                puts "FlowSize: Empirical Distribution from CDF.tcl (DATA MINING)"
        }

        puts "Starting ALL To ALL Experiments for Custom CDF's"

        if { $webSearchCDF == 1} {
                set av_file_size 1141
        } else {
                set av_file_size 5116
        }

        if { $interR == 0 } {
                ########################################
                # All to All scenario

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

                set ratio [expr 2.0*($total_senders-1)/$total_senders]

                puts "Ratio: $ratio"

                set av_inter_arrival [expr (($av_file_size*(1000)*8.0*100) / ($ratio*$mice_load*$ac_bw*1000000))];   # 1000000 has been multiplied because
                                                                                                #bneck_bw is in Mbps

                # puts $av_inter_arrival
                puts "average filesize = $av_file_size"
                puts "mean inter-arrival time = $av_inter_arrival";
                set short_arrival [new RNG];                  # This rv is used for generating inter-arrival times
                $short_arrival seed 2
                set s_arrival [new RandomVariable/Exponential]
                $s_arrival set avg_ $av_inter_arrival
                $s_arrival use-rng $short_arrival

                set global_time 0.0
                set i 0

                while { $global_time <= [expr $sim_time/2.0] } {

                        set inter [expr [$s_arrival value]]
                        set global_time [expr $global_time + $inter]


                        set transfer_size [expr ceil ([$rv_nbytes value])]
                        set transfer_size [expr $transfer_size*1000]
                        set sink [expr int (floor ([$short_src value]))]
                        set dest [expr int (floor ([$short_src value]))]

                        if {$shortie == 1 } {
                                $ns at $global_time "set_buffer $sink $flow_id"
                        }

                        while {$dest == $sink} {
                                set dest [expr int (floor ([$short_src value]))]
                        }

                        if {$pfabric == 0} {

                                set stcp [build-short-lived $m($sink) $m($dest) 1000 $flow_id $sink $global_time $SRC $SINK $transfer_size]
                                set dest_addr($flow_id) $dest

                        } else {

                                set tcp($i) [new Agent/TCP/FullTcp/Sack/MinTCP]
                                set sink_dctcp($i) [new Agent/TCP/FullTcp/Sack/MinTCP]

                                $sink_dctcp($i) listen


                                $ns attach-agent $m($sink) $tcp($i)
                                $ns attach-agent $m($dest) $sink_dctcp($i)

                        $tcp($i) set fid_ [expr $flow_id]
                                $sink_dctcp($i) set fid_ [expr $flow_id]

                                $tcp($i) set packetSize_ 1000
                                $ns connect $tcp($i) $sink_dctcp($i)
                        set ftp($i) [new Application/FTP]
                                $ftp($i) attach-agent $tcp($i)

                                $tcp($i) set starts $global_time
                                $tcp($i) set sess $flow_id
                                $tcp($i) set node $sink
                                $ns at $global_time "$ftp($i) send $transfer_size"
                                $tcp($i) set signal_on_empty_ TRUE
                        set i [expr $i + 1]
                        }

                        puts "flow $flow_id of size [expr $transfer_size/1000] KB generated at $global_time from node $sink to node $dest"

                        set flow_id [expr $flow_id + 1]
                }
        } else {
                puts "Inter-Rack Scenario Loading"

                set total_senders [expr $num_machine*$num_tor*$num_aggr*$num_core / 2]

                # set ratio [expr 2.0*($total_senders-1)/$total_senders]
                set global_time 0.0
                set sink 0
                set i 0

                # set ratio [expr 2.0*($total_senders-1)/$total_senders]

                set s [expr 33*($num_seed+1)+4369*($num_seed+3)]

                #######################################################
                # Inter Rack scenario
                #######################################################

                ########## Generating RNG inter-arrival times : Poisson distribution #############
                puts "mice_load = $mice_load"
                puts "btnk_bw = $ac_bw"
                puts "average filesize = $av_file_size"

                set av_inter_arrival [expr (($av_file_size*1000*8.0*100) / ($mice_load*$ac_bw*1000000.0))];  # 1000000 has been multiplied because
                                                                                                #bneck_bw is in Mbps
                # set av_inter_arrival [expr $av_inter_arrival / ($total_senders)]

                puts "average filesize = $av_file_size"
                puts "mean inter-arrival time = $av_inter_arrival";
                set short_arrival [new RNG];                  # This rv is used for generating inter-arrival times
                $short_arrival seed 2
                set s_arrival [new RandomVariable/Exponential]
                $s_arrival set avg_ $av_inter_arrival
                $s_arrival use-rng $short_arrival

                # set total_senders [expr $num_machine*$num_tor*$num_aggr*$num_core / 2]

                while { $global_time <= [expr $sim_time/2.0] } {

                        if {$sink >= $total_senders } {
                                set sink 0
                        }
                        set dest [expr $sink + $total_senders]
                        set inter [expr [$s_arrival value]]

                        # # Added by Adil
                        # set inter [expr $inter / ($total_senders)]
                        # ##

                        set global_time [expr $global_time + $inter]
                        if {$shortie == 1 } {
                                $ns at $global_time "set_buffer $sink $flow_id"
                                set dest_addr($flow_id) $dest
                        }

                        set transfer_size [expr ceil ([$rv_nbytes value])]
                        set transfer_size [expr $transfer_size*1000]

                        if {$pfabric == 0} {
                                set stcp [build-short-lived $m($sink) $m($dest) 1000 $flow_id $sink $global_time $SRC $SINK $transfer_size]
                                set dest_addr($flow_id) $dest
                        } else {

                                set tcp($i) [new Agent/TCP/FullTcp/Sack/MinTCP]
                                set sink_dctcp($i) [new Agent/TCP/FullTcp/Sack/MinTCP]

                                $sink_dctcp($i) listen


                                $ns attach-agent $m($sink) $tcp($i)
                                $ns attach-agent $m($dest) $sink_dctcp($i)

                        $tcp($i) set fid_ [expr $flow_id]
                                $sink_dctcp($i) set fid_ [expr $flow_id]

                                $tcp($i) set packetSize_ 1000
                                $ns connect $tcp($i) $sink_dctcp($i)
                        set ftp($i) [new Application/FTP]
                                $ftp($i) attach-agent $tcp($i)

                                $tcp($i) set starts $global_time
                                $tcp($i) set sess $flow_id
                                $tcp($i) set node $sink
                                $ns at $global_time "$ftp($i) send $transfer_size"
                                $tcp($i) set signal_on_empty_ TRUE
                                set i [expr $i + 1]
                        }

                        puts "flow $flow_id of size [expr $transfer_size/1000] KB generated at $global_time from node $sink to node $dest"

                        set flow_id [expr $flow_id + 1]
                        set sink [expr $sink+1]
                }


        }


        puts "All done"
}


##########################################################################
# Uniform distribution
##########################################################################
if { $mice_load > 0.0 && $incast_senders <= 0 && $all==0 && $custom != 1} {

        puts "starting uniform distribution"

        set global_time 0.0
        set sink 0
        set i 0

########### Generating RNG file sizes : Uniform distribution #############

        set min $min_fsize
        set max $max_fsize
        puts "min = $min and max = $max"
        set av_file_size [expr ($min + $max) / 2]
        puts "average filesize = $av_file_size"


        set file_size [new RNG];                     # This rv is used for generating file sizes for short flows
        $file_size seed 2
        set short_tcp [new RandomVariable/Uniform]
        $short_tcp use-rng $file_size
        $short_tcp set min_ [expr $min*1000]
        $short_tcp set max_ [expr $max*1000]

########## Generating RNG inter-arrival times : Poisson distribution #############

        set s [expr 33*($num_seed+1)+4369*($num_seed+3)]


        puts "mice_load = $mice_load"
        puts "btnk_bw = $ac_bw"
        puts "average filesize = $av_file_size"

        set av_inter_arrival [expr (($av_file_size*1000*8.0*100) / ($mice_load*$ac_bw*1000000.0))];  # 1000000 has been multiplied because
                                                                                        #bneck_bw is in Mbps
        puts "average filesize = $av_file_size"
        puts "mean inter-arrival time = $av_inter_arrival";
        set short_arrival [new RNG];                  # This rv is used for generating inter-arrival times
        $short_arrival seed 2
        set s_arrival [new RandomVariable/Exponential]
        $s_arrival set avg_ $av_inter_arrival
        $s_arrival use-rng $short_arrival

        set total_senders [expr $num_machine*$num_tor*$num_aggr*$num_core / 2]

        while { $global_time <= [expr $sim_time/2.0] } {

                if {$sink >= $total_senders } {
                        set sink 0
                }
                set dest [expr $sink + $total_senders]
                set inter [expr [$s_arrival value]]
                set global_time [expr $global_time + $inter]
                if {$shortie == 1 } {
                        $ns at $global_time "set_buffer $sink $flow_id"
                        set dest_addr($flow_id) $dest
                }

                set transfer_size [expr [$short_tcp value]]

                if {$pfabric == 0} {
                        set stcp [build-short-lived $m($sink) $m($dest) 1000 $flow_id $sink $global_time $SRC $SINK $transfer_size]
                        set dest_addr($flow_id) $dest
                } else {

                        set tcp($i) [new Agent/TCP/FullTcp/Sack/MinTCP]
                        set sink_dctcp($i) [new Agent/TCP/FullTcp/Sack/MinTCP]

                        $sink_dctcp($i) listen


                        $ns attach-agent $m($sink) $tcp($i)
                        $ns attach-agent $m($dest) $sink_dctcp($i)

                $tcp($i) set fid_ [expr $flow_id]
                        $sink_dctcp($i) set fid_ [expr $flow_id]

                        $tcp($i) set packetSize_ 1000
                        $ns connect $tcp($i) $sink_dctcp($i)
                set ftp($i) [new Application/FTP]
                        $ftp($i) attach-agent $tcp($i)

                        $tcp($i) set starts $global_time
                        $tcp($i) set sess $flow_id
                        $tcp($i) set node $sink
                        $ns at $global_time "$ftp($i) send $transfer_size"
                        $tcp($i) set signal_on_empty_ TRUE
                        set i [expr $i + 1]
                }

                puts "flow $flow_id of size [expr $transfer_size/1000] KB generated at $global_time from node $sink to node $dest"

                set flow_id [expr $flow_id + 1]
                set sink [expr $sink+1]
        }
}
###########################################################################
#	ALL to ALL traffic generation
#       uniform distribution
###########################################################################


if {$all == 1 } {

########### Generating RNG file sizes : Uniform distribution #############
        set total_senders [expr $num_machine*$num_tor*$num_aggr*$num_core]

        set min $min_fsize
        set max $max_fsize
        puts "min = $min and max = $max"
        set av_file_size [expr ($min + $max) / 2]
        puts "average filesize = $av_file_size"


        set file_size [new RNG];                     # This rv is used for generating file sizes for short flows
        $file_size seed 2
        set short_tcp [new RandomVariable/Uniform]
        $short_tcp use-rng $file_size
        $short_tcp set min_ [expr $min*1000]
        $short_tcp set max_ [expr $max*1000]


###########  RNG for source and destination : uniform distribution ###############

        set min 0
        set max $total_senders-0.0001
        puts "min = $min and max = $max"

        set sender_num [new RNG];                     # This rv is used for picking source and destination nodes for short flows
        $sender_num seed 2
        set short_src [new RandomVariable/Uniform]
        $short_src use-rng $sender_num
        $short_src set min_ [expr $min]
        $short_src set max_ [expr $max]

########## Generating RNG inter-arrival times : Poisson distribution #############


        set ratio [expr 2.0*($total_senders-1)/$total_senders]

        puts "Ratio: $ratio"

        set av_inter_arrival [expr (($av_file_size*1000*8.0*100) / ($ratio*$mice_load*$ac_bw*1000000.0))];  # 1000000 has been multiplied because
                                                                                        #bneck_bw is in Mbps
        puts "average filesize = $av_file_size"
        puts "mean inter-arrival time = $av_inter_arrival";
        set short_arrival [new RNG];                  # This rv is used for generating inter-arrival times
        $short_arrival seed 2
        set s_arrival [new RandomVariable/Exponential]
        $s_arrival set avg_ $av_inter_arrival
        $s_arrival use-rng $short_arrival

        set global_time 0.0
        set i 0

        while { $global_time <= [expr $sim_time/2.0] } {

                set inter [expr [$s_arrival value]]
                set global_time [expr $global_time + $inter]


                set transfer_size [expr [$short_tcp value]]
                set sink [expr int (floor ([$short_src value]))]
                set dest [expr int (floor ([$short_src value]))]

                if {$shortie == 1 } {
                        $ns at $global_time "set_buffer $sink $flow_id"
                }

                while {$dest == $sink} {
                        set dest [expr int (floor ([$short_src value]))]
                }

                if {$pfabric == 0} {

                        set stcp [build-short-lived $m($sink) $m($dest) 1000 $flow_id $sink $global_time $SRC $SINK $transfer_size]
                        set dest_addr($flow_id) $dest

                } else {

                        set tcp($i) [new Agent/TCP/FullTcp/Sack/MinTCP]
                        set sink_dctcp($i) [new Agent/TCP/FullTcp/Sack/MinTCP]

                        $sink_dctcp($i) listen


                        $ns attach-agent $m($sink) $tcp($i)
                        $ns attach-agent $m($dest) $sink_dctcp($i)

                $tcp($i) set fid_ [expr $flow_id]
                        $sink_dctcp($i) set fid_ [expr $flow_id]

                        $tcp($i) set packetSize_ 1000
                        $ns connect $tcp($i) $sink_dctcp($i)
                set ftp($i) [new Application/FTP]
                        $ftp($i) attach-agent $tcp($i)

                        $tcp($i) set starts $global_time
                        $tcp($i) set sess $flow_id
                        $tcp($i) set node $sink
                        $ns at $global_time "$ftp($i) send $transfer_size"
                        $tcp($i) set signal_on_empty_ TRUE
                set i [expr $i + 1]
                }

                puts "flow $flow_id of size [expr $transfer_size/1000] KB generated at $global_time from node $sink to node $dest"

                set flow_id [expr $flow_id + 1]
        }

}

###########################################################################
# Pareto distribution
###########################################################################

if {$pareto_rate > 0.0 && $incast_senders <= 0 && $all == 0} {

        set min $min_fsize
        set max $max_fsize
        puts "min = $min and max = $max"
        set filesize [expr ($min + $max)/2]

        set pareto_arrival_rate [expr 1 / [expr $pareto_rate * $ac_bw * 1000000.0 / ($filesize * 1024 * 8.0 * 100)]]
        puts "average arrival rate = $pareto_arrival_rate"

############ Generating RNG filesizes: pareto distribution ##################

        set file_size [new RNG];                    # This rv is used for generating file sizes for short flows
        $file_size seed 0
        set short_tcp [new RandomVariable/Pareto]
        $short_tcp use-rng $file_size
        $short_tcp set avg_ [expr $filesize*1000]
        $short_tcp set shape_ 1.2

############ Generating RNG interarrival times: poisson distribution ##################
        set av_inter_arrival $pareto_arrival_rate

        set short_arrival [new RNG];                 # This rv is used for generating inter-arrival times
        $short_arrival seed 2
        set s_arrival [new RandomVariable/Exponential]
        $s_arrival set avg_ $av_inter_arrival
        $s_arrival use-rng $short_arrival

############# Generating flows ###############

        set global_time 0.0
        set sink 0
        set i 0

        set total_senders [expr $num_machine*$num_tor*$num_aggr*$num_core / 2]

        while { $global_time <= [expr $sim_time/2] } {

                if {$sink >= $total_senders } {
                        set sink 0
                }
                set dest [expr $sink + $total_senders]
                if {$shortie == 1 } {
                        $ns at $global_time "set_buffer $sink $flow_id"; # if mulbuff_enabled, increment buffers in path
                        set dest_addr($flow_id) $dest
                }
                set transfer_size [expr [$short_tcp value]]


                if {$pfabric == 0} {
                        set ptcp [build-short-lived $m($sink) $m($dest) 1000 $flow_id $sink $global_time $SRC $SINK $transfer_size]
                } else {
                        set ptcp($i) [new Agent/TCP/FullTcp/Sack/MinTCP]
                        set sink_dctcp($i) [new Agent/TCP/FullTcp/Sack/MinTCP]

                        $sink_dctcp($i) listen

                        $ns attach-agent $m($sink) $ptcp($i)
                        $ns attach-agent $m($dest) $sink_dctcp($i)

                        $ptcp($i) set fid_ [expr $flow_id]
                        $sink_dctcp($i) set fid_ [expr $flow_id]

                        $ptcp($i) set packetSize_ 1000
                        $ns connect $ptcp($i) $sink_dctcp($i)
                        set ftp($i) [new Application/FTP]
                        $ftp($i) attach-agent $ptcp($i)

                        $ptcp($i) set starts $global_time
                        $ptcp($i) set sess $flow_id
                        $ptcp($i) set node $sink
                        $ns at $global_time "$ftp($i) send $transfer_size"
                        $ptcp($i) set signal_on_empty_ TRUE
                        set i [expr $i + 1]
                }

                puts "flow $flow_id of size [expr $transfer_size/1000] KB generated at $global_time from node $sink to node $dest"
                set inter [expr [$s_arrival value]]
                set global_time [expr $global_time + $inter]
                set flow_id [expr $flow_id + 1]
                set sink [expr $sink+1]
        }
}

#####################################################################
#incast generation
# generates incast within the first tor
#####################################################################

if {$incast_senders > 0 } {

        set FileSize [expr $chunk_data*1000000.0/$incast_senders]

        # randomize flow start time
        set start_time_RNG [new RNG] ; #$start_time_RNG next-substream
        $start_time_RNG seed $num_seed
        set start_time_rnd [new RandomVariable/Uniform]
        $start_time_rnd set min_ 1   ;# ms
        $start_time_rnd set max_ 20000 ;# ms
        $start_time_rnd use-rng $start_time_RNG

        if {$incast_load == 0 } {
                for { set i 0 } { $i < $incast_senders } { incr i } {

                        set start_time [expr [$start_time_rnd value] / 1000000000.0]
                        set start_time [expr $start_time + 0.1]

                        if {$shortie == 1 } {
                                $ns at $start_time "set_buffer_incast"
                        }
                        if {$pfabric == 0 } {
                                set stcp [build-short-lived $m($i) $m($incast_senders) 1000 $flow_id $i $start_time $SRC $SINK $FileSize]
                        } else {

                                set tcp($i) [new Agent/TCP/FullTcp/Sack/MinTCP]
                                set sink_dctcp($i) [new Agent/TCP/FullTcp/Sack/MinTCP]

                                $sink_dctcp($i) listen


                                $ns attach-agent $m($i) $tcp($i)
                                $ns attach-agent $m($incast_senders) $sink_dctcp($i)

                                $tcp($i) set fid_ [expr $flow_id]
                                $sink_dctcp($i) set fid_ [expr $flow_id]

                                $tcp($i) set packetSize_ 1000
                                $ns connect $tcp($i) $sink_dctcp($i)
                                set ftp($i) [new Application/FTP]
                                $ftp($i) attach-agent $tcp($i)

                                $tcp($i) set starts $start_time
                                $tcp($i) set sess $flow_id
                                $tcp($i) set node $i
                                $ns at $start_time "$ftp($i) send $FileSize"
                                $tcp($i) set signal_on_empty_ TRUE

                        }
                        puts "flow $flow_id of size [expr $FileSize/1000] KB generated at $start_time from node $i to node $incast_senders"
                        set flow_id [expr $flow_id + 1]
                }
        } elseif {$incast_load > 0 } {

                puts "incast_mice_load = $incast_load"
                puts "btnk_bw = $mt_bw chunk size = $chunk_data"
                set av_inter_arrival [expr (($chunk_data*1000000*8.0*100) / ($incast_load*$mt_bw*1000000.0))];  # 1000000
                                                                                # has been multiplied because bneck_bw is in Mbps
                puts "mean inter-arrival time = $av_inter_arrival";
                set short_arrival [new RNG];                  # This rv is used for generating inter-arrival times
                $short_arrival seed 2
                set s_arrival [new RandomVariable/Exponential]
                $s_arrival set avg_ $av_inter_arrival
                $s_arrival use-rng $short_arrival

                set global_time 0.0

                while { $global_time <= [expr $sim_time/2.0] } {

                        for { set i 0 } { $i < $incast_senders } { incr i } {

                                set start_time [expr [$start_time_rnd value] / 1000000000.0]
                                set start_time [expr $start_time + $global_time]

                                if {$shortie == 1 } {
                                        $ns at $start_time "set_buffer_incast"
                                }
                                if {$pfabric == 0 } {
                                        set stcp [build-short-lived $m($i) $m($incast_senders) 1000 $flow_id $i $start_time $SRC $SINK $FileSize]
                                } else {

                                        set tcp($i) [new Agent/TCP/FullTcp/Sack/MinTCP]
                                        set sink_dctcp($i) [new Agent/TCP/FullTcp/Sack/MinTCP]

                                        $sink_dctcp($i) listen


                                        $ns attach-agent $m($i) $tcp($i)
                                        $ns attach-agent $m($incast_senders) $sink_dctcp($i)

                                        $tcp($i) set fid_ [expr $flow_id]
                                        $sink_dctcp($i) set fid_ [expr $flow_id]

                                        $tcp($i) set packetSize_ 1000
                                        $ns connect $tcp($i) $sink_dctcp($i)
                                        set ftp($i) [new Application/FTP]
                                        $ftp($i) attach-agent $tcp($i)

                                        $tcp($i) set starts $start_time
                                        $tcp($i) set sess $flow_id
                                        $tcp($i) set node $i
                                        $ns at $start_time "$ftp($i) send $FileSize"
                                        $tcp($i) set signal_on_empty_ TRUE

                                }
                                puts "flow $flow_id of size [expr $FileSize/1000] KB generated at $start_time from node $i to node $incast_senders"
                                set flow_id [expr $flow_id + 1]
                        }

                        set inter [expr [$s_arrival value]]
                        set global_time [expr $global_time + $inter]
                        puts "$global_time"
                }
        }
}

##################################################################################
# Infinitely long flow generation
##################################################################################

if { $incast_senders > 0 } {
        set m_id 0
        for {set i $flow_id} { $i < [expr $num_long + $flow_id] } { incr i } {

                set sink_id [expr $m_id]
                set dest_id [expr $incast_senders]
                set start_time 0
                if { $pfabric == 0 } {
                        set tcp($i) [$ns create-connection $SRC $m($sink_id) $SINK $m($dest_id) $i]
                        set ftp($i) [$tcp($i) attach-source FTP]
                        $ns at $start_time "$ftp($i) start"
                } else {

                        set tcp($i) [new Agent/TCP/FullTcp/Sack/MinTCP]
                        set sink_dctcp($i) [new Agent/TCP/FullTcp/Sack/MinTCP]

                        $sink_dctcp($i) listen

                        $ns attach-agent $m($sink_id) $tcp($i)
                        $ns attach-agent $m($dest_id) $sink_dctcp($i)

                        $tcp($i) set fid_ [expr $flow_id]
                        $sink_dctcp($i) set fid_ [expr $flow_id]

                        $ns connect $tcp($i) $sink_dctcp($i)

                        set ftp($i) [new Application/FTP]
                        $ftp($i) attach-agent $tcp($i)
#			$tcp($i) set signal_on_empty_ TRUE
                        $tcp($i) set starts $start_time
                        $tcp($i) set sess $i
                        $tcp($i) set node $i
                        $ns at $start_time "$ftp($i) send 1000000000000"
                        $tcp($i) set signal_on_empty_ TRUE
                }


                if {$shortie == 1 } {
                        $tcp($i) set short_ $shortie;   #if mulbuff enabled set flag to indicate it is a long flow
                }

                set start_time 0
                puts "long flow $i started at $start_time from node $sink_id to node $dest_id"

                set stop_time  [expr $sim_time]
                $ns at $stop_time "$ftp($i) stop"

                set m_id [expr $m_id + 1]
        }
} else {
        set total_tor [expr $num_tor*$num_aggr*$num_core]
        set sender_tor [expr $total_tor/2]
        set tor 0
        set machine 0
        for {set i $flow_id} { $i < [expr $num_long + $flow_id] } { incr i } {

                if {$tor >= $sender_tor} {
                        set tor 0
                        set machine [expr $machine+1]
                        if { $machine >= $num_machine } {
                                set machine 0
                        }
                }

                set sink_id [expr $tor*$num_machine + $machine]
                set dest_id [expr ($tor+$sender_tor)*$num_machine + $machine]
                set start_time 0

                if {$pfabric == 0 } {

                        set tcp($i) [$ns create-connection $SRC $m($sink_id) $SINK $m($dest_id) $i]
                        set ftp($i) [$tcp($i) attach-source FTP]
                        $ns at $start_time "$ftp($i) start"


                } else {

                        set tcp($i) [new Agent/TCP/FullTcp/Sack/MinTCP]
                        set sink_dctcp($i) [new Agent/TCP/FullTcp/Sack/MinTCP]

                        $sink_dctcp($i) listen

                        $ns attach-agent $m($sink_id) $tcp($i)
                        $ns attach-agent $m($dest_id) $sink_dctcp($i)

                        $tcp($i) set fid_ [expr $flow_id]
                        $sink_dctcp($i) set fid_ [expr $flow_id]

                        $ns connect $tcp($i) $sink_dctcp($i)

                        set ftp($i) [new Application/FTP]
                        $ftp($i) attach-agent $tcp($i)
                        #$tcp($i) set signal_on_empty_ TRUE
                        $tcp($i) set starts $start_time
                        $tcp($i) set sess $i
                        $tcp($i) set node $i
                        $ns at $start_time "$ftp($i) send 1000000000000"
                        $tcp($i) set signal_on_empty_ TRUE

                }
                if {$shortie == 1 } {
                        $tcp($i) set short_ $shortie;   #if mulbuff enabled set flag to indicate it is a long flow
                }

                puts "long flow $i started at $start_time from node $sink_id to node $dest_id"

                set stop_time  [expr $sim_time]
                $ns at $stop_time "$ftp($i) stop"

                set tor [expr $tor + 1]
        }
}


###################################################################

# end: flow generation
###################################################################
###################################################################

# begin : Stats collection

############ Flow completion times #############
set Out [open Out.ns w]

Agent/TCP instproc done {} {
global tcp stcp ns dest_addr s_arrival short_tcp Out ftp c a t m f_buf increment other_buf shortie m_count t_count a_count a_btnk t_btnk m_btnk num_machine num_tor num_aggr num_core total_senders incast_senders long_buf


        set sink [$self set node]

#	puts "from $sink to  $dest_addr([$self set sess])"

        if { $shortie == 1} { #if mulbuff enabled decrement buffer sizes


                if { $incast_senders <= 0 } {

                        set m_id $dest_addr([$self set sess])

                        # setting upward queues in the path of flow
                        #decrement at completion
                        set tor_id [expr int ( floor ($sink/$num_machine))]
                        set aggr_id [expr int ( floor ($tor_id/$num_tor))]
                        set core_id [expr int ( floor ($aggr_id/$num_aggr))]

                        #setting downward queues in the path of flow
                        #decrement at completion
                        set d_tor_id [expr int ( floor ( $m_id/$num_machine))]
                        set d_aggr_id [expr int ( floor ($d_tor_id/$num_tor))]
                        set d_core_id [expr int ( floor ($d_aggr_id/$num_aggr))]

                        if { $m_btnk($sink) > $other_buf } {
                                set m_btnk($sink)        [expr $m_btnk($sink) - $increment]
                        }
                        $ns queue-limit $m($sink) $t($tor_id) [expr $m_btnk($sink)]

                        if { $m_btnk($m_id) > $other_buf } {
                                set m_btnk($m_id)        [expr $m_btnk($m_id) - $increment]
                        }
                        $ns queue-limit $t($d_tor_id) $m($m_id) [expr $m_btnk($m_id)]

                        if {$tor_id != $d_tor_id } {

                                if { $t_btnk($tor_id) > $other_buf } {
                                        set t_btnk($tor_id)        [expr $t_btnk($tor_id) - $increment]
                                }
                                $ns queue-limit $t($tor_id) $a($aggr_id) [expr $t_btnk($tor_id)]

                                if { $t_btnk($d_tor_id) > $other_buf } {
                                        set t_btnk($d_tor_id)        [expr $t_btnk($d_tor_id) - $increment]
                                }
                                $ns queue-limit $a($d_aggr_id) $t($d_tor_id) [expr $t_btnk($d_tor_id)]

                        }

                        if {$aggr_id != $d_aggr_id } {
                                if { $a_btnk($aggr_id) > $other_buf } {
                                        set a_btnk($aggr_id)        [expr $a_btnk($aggr_id) - $increment]
                                }
                                $ns queue-limit $a($aggr_id) $c($core_id) [expr $a_btnk($aggr_id)]

                                if { $a_btnk($d_aggr_id) > $other_buf } {
                                        set a_btnk($d_aggr_id)        [expr $a_btnk($d_aggr_id) - $increment]
                                }
                                $ns queue-limit $c($d_core_id) $a($d_aggr_id) [expr $a_btnk($d_aggr_id)]
                        }

                } elseif { $shortie == 1 && $incast_senders > 0 } {

                        set tor_id 0
                        set m_id $incast_senders
                        if { $m_btnk($m_id) > $other_buf } {
                                set m_btnk($m_id)        [expr $m_btnk($m_id) - $increment]
                        }
                        $ns queue-limit $t($tor_id) $m($m_id) [expr $m_btnk($m_id)]
                }
        }

set duration [expr [$ns now] - [$self set starts]]
puts $Out "[$self set node] \t [$self set sess] \t [$self set starts] \t\
           [$ns now] \t $duration \t [$self set ndatapack_] \t\
           [$self set ndatabytes_] \t [$self set nrexmitbytes_] \t\
           [expr [$self set ndatabytes_]/$duration] \t\
           [$self set ncwndcuts1_] \t [$self set nrexmit_]"
}



Agent/TCP/FullTcp instproc done_data {} {
        global tcp stcp ns s_arrival short_tcp Out ftp c a t m f_buf increment other_buf shortie m_count t_count a_count a_btnk t_btnk m_btnk num_machine num_tor num_aggr num_core total_senders incast_senders
        set duration [expr [$ns now] - [$self set starts]]
        puts $Out "[$self set node] \t [$self set sess] \t [$self set starts] \t\
           [$ns now] \t $duration \t [$self set ndatapack_] \t\
           [$self set ndatabytes_] \t [$self set nrexmitbytes_] \t\
           [expr [$self set ndatabytes_]/$duration] \t\
           [$self set ncwndcuts1_] \t [$self set nrexmit_] \t"

}

# Queue monitor for forward path links

for {set i 0} { $i < [expr $num_aggr*$num_core] } {incr i} {

        set src_id $i
        set dest_id [expr int(floor($i/$num_aggr))]

        set qmon_ac($i) [$ns monitor-queue $a($src_id) $c($dest_id) ""]
        set bing_ac($i) [$qmon_ac($i) get-bytes-integrator];	# bytes integrator
        set ping_ac($i) [$qmon_ac($i) get-pkts-integrator];             # packets integrator

        set fileq_ac($i) "qmon.trace"
        set futil_name_ac($i) "qmon.util"
        set floss_name_ac($i) "qmon.loss"
        set fqueue_name_ac($i) "qmon.queue"

        append fileq_ac($i) "a$src_id"
        append fileq_ac($i) "c$dest_id"
        append futil_name_ac($i) "a$src_id"
        append futil_name_ac($i) "c$dest_id"
        append floss_name_ac($i) "a$src_id"
        append floss_name_ac($i) "c$dest_id"
        append fqueue_name_ac($i) "a$src_id"
        append fqueue_name_ac($i) "c$dest_id"


        set fq_mon_ac($i) [open $fileq_ac($i) w]
        set f_util_ac($i) [open $futil_name_ac($i) w]
        set f_loss_ac($i) [open $floss_name_ac($i) w]
        set f_queue_ac($i) [open $fqueue_name_ac($i) w]


        $ns at $STATS_START  "$qmon_ac($i) reset"
        $ns at $STATS_START  "$bing_ac($i) reset"
        $ns at $STATS_START  "$ping_ac($i) reset"
        $ns at [expr $STATS_START+$STATS_INTR] "linkDump [$ns link $a($src_id) $c($dest_id)] $bing_ac($i) $ping_ac($i) $qmon_ac($i) $STATS_INTR A-B $fq_mon_ac($i) $f_util_ac($i) $f_loss_ac($i) $f_queue_ac($i) $buf_bytes"

}

# Queue monitor for forward path links

for {set i 0} { $i < [expr $num_tor*$num_aggr*$num_core] } {incr i} {

        set src_id $i
        set dest_id [expr int( floor ($i/$num_tor))]

        set qmon_ta($i) [$ns monitor-queue $t($src_id) $a($dest_id) ""]
        set bing_ta($i) [$qmon_ta($i) get-bytes-integrator];	# bytes integrator
        set ping_ta($i) [$qmon_ta($i) get-pkts-integrator];             # packets integrator

        set fileq_ta($i) "qmon.trace"
        set futil_name_ta($i) "qmon.util"
        set floss_name_ta($i) "qmon.loss"
        set fqueue_name_ta($i) "qmon.queue"

        append fileq_ta($i) "t$src_id"
        append fileq_ta($i) "a$dest_id"
        append futil_name_ta($i) "t$src_id"
        append futil_name_ta($i) "a$dest_id"
        append floss_name_ta($i) "t$src_id"
        append floss_name_ta($i) "a$dest_id"
        append fqueue_name_ta($i) "t$src_id"
        append fqueue_name_ta($i) "a$dest_id"


        set fq_mon_ta($i) [open $fileq_ta($i) w]
        set f_util_ta($i) [open $futil_name_ta($i) w]
        set f_loss_ta($i) [open $floss_name_ta($i) w]
        set f_queue_ta($i) [open $fqueue_name_ta($i) w]


        $ns at $STATS_START  "$qmon_ta($i) reset"
        $ns at $STATS_START  "$bing_ta($i) reset"
        $ns at $STATS_START  "$ping_ta($i) reset"
        $ns at [expr $STATS_START+$STATS_INTR] "linkDump [$ns link $t($src_id) $a($dest_id)] $bing_ta($i) $ping_ta($i) $qmon_ta($i) $STATS_INTR A-B $fq_mon_ta($i) $f_util_ta($i) $f_loss_ta($i) $f_queue_ta($i) $buf_bytes"

}


# Queue monitor for forward path links

for {set i 0} { $i < [expr $num_machine*$num_tor*$num_aggr*$num_core] } {incr i} {

        set src_id $i
        set dest_id [expr int ( floor ($i/$num_machine))]

        set qmon_mt($i) [$ns monitor-queue $m($src_id) $t($dest_id) ""]
        set bing_mt($i) [$qmon_mt($i) get-bytes-integrator];	# bytes integrator
        set ping_mt($i) [$qmon_mt($i) get-pkts-integrator];             # packets integrator

        set fileq_mt($i) "qmon.trace"
        set futil_name_mt($i) "qmon.util"
        set floss_name_mt($i) "qmon.loss"
        set fqueue_name_mt($i) "qmon.queue"

        append fileq_mt($i) "m$src_id"
        append fileq_mt($i) "t$dest_id"
        append futil_name_mt($i) "m$src_id"
        append futil_name_mt($i) "t$dest_id"
        append floss_name_mt($i) "m$src_id"
        append floss_name_mt($i) "t$dest_id"
        append fqueue_name_mt($i) "m$src_id"
        append fqueue_name_mt($i) "t$dest_id"


        set fq_mon_mt($i) [open $fileq_mt($i) w]
        set f_util_mt($i) [open $futil_name_mt($i) w]
        set f_loss_mt($i) [open $floss_name_mt($i) w]
        set f_queue_mt($i) [open $fqueue_name_mt($i) w]


        $ns at $STATS_START  "$qmon_mt($i) reset"
        $ns at $STATS_START  "$bing_mt($i) reset"
        $ns at $STATS_START  "$ping_mt($i) reset"
        $ns at [expr $STATS_START+$STATS_INTR] "linkDump [$ns link $m($src_id) $t($dest_id)] $bing_mt($i) $ping_mt($i) $qmon_mt($i) $STATS_INTR A-B $fq_mon_mt($i) $f_util_mt($i) $f_loss_mt($i) $f_queue_mt($i) $buf_bytes"

}

# end : Stats collection

###################################################################

proc set_buffer {sink fid} {
        global ns c a t m f_buf dest_addr f_btnk_buf bdp increment m_count t_count a_count a_btnk t_btnk m_btnk num_machine num_tor num_aggr num_core total_senders other_buf
        #puts "i'm in function set buffer"

        set dest_id $dest_addr($fid)

        # setting upward queues in the path of flow # increment
        set tor_id [expr int ( floor ($sink/$num_machine))]
        set aggr_id [expr int ( floor ($tor_id/$num_tor))]
        set core_id [expr int ( floor ($aggr_id/$num_aggr))]

        #setting downward queues in the path of flow #increment
        set d_tor_id [expr int ( floor ( ($dest_id)/$num_machine))]
        set d_aggr_id [expr int ( floor ($d_tor_id/$num_tor))]
        set d_core_id [expr int ( floor ($d_aggr_id/$num_aggr))]

        set m_btnk($sink)        [expr $m_btnk($sink) + $increment]
        $ns queue-limit $m($sink) $t($tor_id) [expr $m_btnk($sink)]

        set m_btnk($dest_id)        [expr $m_btnk($dest_id) + $increment]
        $ns queue-limit $t($d_tor_id) $m($dest_id) [expr $m_btnk($dest_id)]

        if {$tor_id != $d_tor_id } {

                set t_btnk($tor_id)        [expr $t_btnk($tor_id) + $increment]
                $ns queue-limit $t($tor_id) $a($aggr_id) [expr $t_btnk($tor_id)]

                set t_btnk($d_tor_id)        [expr $t_btnk($d_tor_id) + $increment]
                $ns queue-limit $a($d_aggr_id) $t($d_tor_id) [expr $t_btnk($d_tor_id)]

        }

        if {$aggr_id != $d_aggr_id } {
                set a_btnk($aggr_id)        [expr $a_btnk($aggr_id) + $increment]
                $ns queue-limit $a($aggr_id) $c($core_id) [expr $a_btnk($aggr_id)]

                set a_btnk($d_aggr_id)        [expr $a_btnk($d_aggr_id) + $increment]
                $ns queue-limit $c($d_core_id) $a($d_aggr_id) [expr $a_btnk($d_aggr_id)]
        }

}

proc set_buffer_incast {} {
        global ns c a t m f_buf f_btnk_buf other_buf increment m_count t_count a_count a_btnk t_btnk m_btnk num_machine num_tor num_aggr num_core total_senders incast_senders
        set tor_id 0
        set m_id $incast_senders

        set m_btnk($m_id)        [expr $m_btnk($m_id) + $increment]
        $ns queue-limit $t($tor_id) $m($m_id) [expr $m_btnk($m_id)]
}

proc finish {} {
        global ns nf Out f_buf shortie
        $ns flush-trace

        close $Out
        if {$shortie == 1 } {
                close $f_buf
        }
#	close $nf
#	exec nam out.nam

        exit 0
}

$ns at $sim_time "finish"
$ns run
