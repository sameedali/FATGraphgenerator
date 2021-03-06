source template.tcl

# defining link properties
set edge_link 100.0Mb
set agg_link 100.0Mb
set core_link 100.0Mb

set edge_delay 0.025ms
set agg_delay  0.025ms
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
	#set fileq($i) "qmon.trace"
	set futil_name($i) "qmon.util"
	
    append fileq($i) "$links1($i)"
	append fileq($i) "$links2($i)"
	append futil_name($i) "$links1($i)"
	append futil_name($i) "$links2($i)"
	
    #set fq_mon($i) [open $fileq($i) w]
	set f_util($i) [open $futil_name($i) w]


    $ns at $STATS_START  "$qmon_ab($i) reset"
	$ns at $STATS_START  "$bing_ab($i) reset"
	$ns at $STATS_START  "$ping_ab($i) reset"
	set buf_bytes [expr 0.00025 * 1000 / 1 ]
    $ns at [expr $STATS_START+$STATS_INTR] "linkDump [$ns link $n($links1($i)) $n($links2($i))] $bing_ab($i) $ping_ab($i) $qmon_ab($i) $STATS_INTR A-B $f_util($i) $buf_bytes"
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
		set p($num_agents) [new Agent/Raza]
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





set tcp2 [build-tcp $n(0) $n(8) 1.5 2.8];
set tcp1 [build-tcp $n(1) $n(9) 1.7 2.7];
set tcp1 [build-tcp $n(2) $n(10) 1.9 2.9];
set tcp1 [build-tcp $n(3) $n(11) 2.1 3.1];
set tcp1 [build-tcp $n(4) $n(12) 2.3 3.3];
set tcp1 [build-tcp $n(5) $n(13) 2.5 3.5];
set tcp1 [build-tcp $n(6) $n(14) 2.7 3.7];
set tcp1 [build-tcp $n(7) $n(15) 2.9 3.9];

set tcp1 [new Agent/TCP]
$tcp1 set class_ 2
$ns attach-agent $n(0) $tcp1
set sink1 [new Agent/TCPSink]
$ns attach-agent $n(8) $sink1
$ns connect $tcp1 $sink1
$tcp1 set fid_ 1

set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1
$ftp1 set type_ FTP

#$ns at 1 "$tcp1 tcp_send"
#$ns at 2 "$tcp1 flow_start"
#$ns at 2 "$ftp1 start"
#$ns at 3.000000000001 "$tcp1 flow_end"
#$ns at 3 "$ftp1 stop"


#$ns at 7.0 "$tcp1 tcp_send"
#$ns at 7.5 "$tcp1 flow_start"
#$ns at 7.5 "$ftp1 start"

#$ns at 8.501 "$tcp1 flow_end"
#$ns at 8.5 "$ftp1 stop"


puts "running ns"


$ns at 9.53 "finish"
$ns run

