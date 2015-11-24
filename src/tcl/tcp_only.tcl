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
$ns duplex-link $n(16) $n(0) $edge_link $edge_delay DropTail
$ns duplex-link $n(1) $n(16) $edge_link $edge_delay DropTail
$ns duplex-link $n(16) $n(1) $edge_link $edge_delay DropTail
$ns duplex-link $n(2) $n(17) $edge_link $edge_delay DropTail
$ns duplex-link $n(17) $n(2) $edge_link $edge_delay DropTail
$ns duplex-link $n(3) $n(17) $edge_link $edge_delay DropTail
$ns duplex-link $n(17) $n(3) $edge_link $edge_delay DropTail
$ns duplex-link $n(4) $n(18) $edge_link $edge_delay DropTail
$ns duplex-link $n(18) $n(4) $edge_link $edge_delay DropTail
$ns duplex-link $n(5) $n(18) $edge_link $edge_delay DropTail
$ns duplex-link $n(18) $n(5) $edge_link $edge_delay DropTail
$ns duplex-link $n(6) $n(19) $edge_link $edge_delay DropTail
$ns duplex-link $n(19) $n(6) $edge_link $edge_delay DropTail
$ns duplex-link $n(7) $n(19) $edge_link $edge_delay DropTail
$ns duplex-link $n(19) $n(7) $edge_link $edge_delay DropTail
$ns duplex-link $n(8) $n(20) $edge_link $edge_delay DropTail
$ns duplex-link $n(20) $n(8) $edge_link $edge_delay DropTail
$ns duplex-link $n(9) $n(20) $edge_link $edge_delay DropTail
$ns duplex-link $n(20) $n(9) $edge_link $edge_delay DropTail
$ns duplex-link $n(10) $n(21) $edge_link $edge_delay DropTail
$ns duplex-link $n(21) $n(10) $edge_link $edge_delay DropTail
$ns duplex-link $n(11) $n(21) $edge_link $edge_delay DropTail
$ns duplex-link $n(21) $n(11) $edge_link $edge_delay DropTail
$ns duplex-link $n(12) $n(22) $edge_link $edge_delay DropTail
$ns duplex-link $n(22) $n(12) $edge_link $edge_delay DropTail
$ns duplex-link $n(13) $n(22) $edge_link $edge_delay DropTail
$ns duplex-link $n(22) $n(13) $edge_link $edge_delay DropTail
$ns duplex-link $n(14) $n(23) $edge_link $edge_delay DropTail
$ns duplex-link $n(23) $n(14) $edge_link $edge_delay DropTail
$ns duplex-link $n(15) $n(23) $edge_link $edge_delay DropTail
$ns duplex-link $n(23) $n(15) $edge_link $edge_delay DropTail
$ns duplex-link $n(16) $n(24) $edge_link $edge_delay DropTail
$ns duplex-link $n(24) $n(16) $edge_link $edge_delay DropTail
$ns duplex-link $n(16) $n(25) $edge_link $edge_delay DropTail
$ns duplex-link $n(25) $n(16) $edge_link $edge_delay DropTail
$ns duplex-link $n(17) $n(24) $edge_link $edge_delay DropTail
$ns duplex-link $n(24) $n(17) $edge_link $edge_delay DropTail
$ns duplex-link $n(17) $n(25) $edge_link $edge_delay DropTail
$ns duplex-link $n(25) $n(17) $edge_link $edge_delay DropTail
$ns duplex-link $n(18) $n(26) $edge_link $edge_delay DropTail
$ns duplex-link $n(26) $n(18) $edge_link $edge_delay DropTail
$ns duplex-link $n(18) $n(27) $edge_link $edge_delay DropTail
$ns duplex-link $n(27) $n(18) $edge_link $edge_delay DropTail
$ns duplex-link $n(19) $n(26) $edge_link $edge_delay DropTail
$ns duplex-link $n(26) $n(19) $edge_link $edge_delay DropTail
$ns duplex-link $n(19) $n(27) $edge_link $edge_delay DropTail
$ns duplex-link $n(27) $n(19) $edge_link $edge_delay DropTail
$ns duplex-link $n(20) $n(28) $edge_link $edge_delay DropTail
$ns duplex-link $n(28) $n(20) $edge_link $edge_delay DropTail
$ns duplex-link $n(20) $n(29) $edge_link $edge_delay DropTail
$ns duplex-link $n(29) $n(20) $edge_link $edge_delay DropTail
$ns duplex-link $n(21) $n(28) $edge_link $edge_delay DropTail
$ns duplex-link $n(28) $n(21) $edge_link $edge_delay DropTail
$ns duplex-link $n(21) $n(29) $edge_link $edge_delay DropTail
$ns duplex-link $n(29) $n(21) $edge_link $edge_delay DropTail
$ns duplex-link $n(22) $n(30) $edge_link $edge_delay DropTail
$ns duplex-link $n(30) $n(22) $edge_link $edge_delay DropTail
$ns duplex-link $n(22) $n(31) $edge_link $edge_delay DropTail
$ns duplex-link $n(31) $n(22) $edge_link $edge_delay DropTail
$ns duplex-link $n(23) $n(30) $edge_link $edge_delay DropTail
$ns duplex-link $n(30) $n(23) $edge_link $edge_delay DropTail
$ns duplex-link $n(23) $n(31) $edge_link $edge_delay DropTail
$ns duplex-link $n(31) $n(23) $edge_link $edge_delay DropTail
$ns duplex-link $n(24) $n(32) $edge_link $edge_delay DropTail
$ns duplex-link $n(32) $n(24) $edge_link $edge_delay DropTail
$ns duplex-link $n(24) $n(33) $edge_link $edge_delay DropTail
$ns duplex-link $n(33) $n(24) $edge_link $edge_delay DropTail
$ns duplex-link $n(25) $n(34) $edge_link $edge_delay DropTail
$ns duplex-link $n(34) $n(25) $edge_link $edge_delay DropTail
$ns duplex-link $n(25) $n(35) $edge_link $edge_delay DropTail
$ns duplex-link $n(35) $n(25) $edge_link $edge_delay DropTail
$ns duplex-link $n(26) $n(32) $edge_link $edge_delay DropTail
$ns duplex-link $n(32) $n(26) $edge_link $edge_delay DropTail
$ns duplex-link $n(26) $n(33) $edge_link $edge_delay DropTail
$ns duplex-link $n(33) $n(26) $edge_link $edge_delay DropTail
$ns duplex-link $n(27) $n(34) $edge_link $edge_delay DropTail
$ns duplex-link $n(34) $n(27) $edge_link $edge_delay DropTail
$ns duplex-link $n(27) $n(35) $edge_link $edge_delay DropTail
$ns duplex-link $n(35) $n(27) $edge_link $edge_delay DropTail
$ns duplex-link $n(28) $n(32) $edge_link $edge_delay DropTail
$ns duplex-link $n(32) $n(28) $edge_link $edge_delay DropTail
$ns duplex-link $n(28) $n(33) $edge_link $edge_delay DropTail
$ns duplex-link $n(33) $n(28) $edge_link $edge_delay DropTail
$ns duplex-link $n(29) $n(34) $edge_link $edge_delay DropTail
$ns duplex-link $n(34) $n(29) $edge_link $edge_delay DropTail
$ns duplex-link $n(29) $n(35) $edge_link $edge_delay DropTail
$ns duplex-link $n(35) $n(29) $edge_link $edge_delay DropTail
$ns duplex-link $n(30) $n(32) $edge_link $edge_delay DropTail
$ns duplex-link $n(32) $n(30) $edge_link $edge_delay DropTail
$ns duplex-link $n(30) $n(33) $edge_link $edge_delay DropTail
$ns duplex-link $n(33) $n(30) $edge_link $edge_delay DropTail
$ns duplex-link $n(31) $n(34) $edge_link $edge_delay DropTail
$ns duplex-link $n(34) $n(31) $edge_link $edge_delay DropTail
$ns duplex-link $n(31) $n(35) $edge_link $edge_delay DropTail
$ns duplex-link $n(35) $n(31) $edge_link $edge_delay DropTail

# creating link arrays
array set links1 { 0 0 1 16 2 16 3 0 4 1 5 16 6 16 7 1 8 2 9 17 10 17 11 2 12 3 13 17 14 17 15 3 16 4 17 18 18 18 19 4 20 5 21 18 22 18 23 5 24 6 25 19 26 19 27 6 28 7 29 19 30 19 31 7 32 8 33 20 34 20 35 8 36 9 37 20 38 20 39 9 40 10 41 21 42 21 43 10 44 11 45 21 46 21 47 11 48 12 49 22 50 22 51 12 52 13 53 22 54 22 55 13 56 14 57 23 58 23 59 14 60 15 61 23 62 23 63 15 64 16 65 24 66 24 67 16 68 16 69 25 70 25 71 16 72 17 73 24 74 24 75 17 76 17 77 25 78 25 79 17 80 18 81 26 82 26 83 18 84 18 85 27 86 27 87 18 88 19 89 26 90 26 91 19 92 19 93 27 94 27 95 19 96 20 97 28 98 28 99 20 100 20 101 29 102 29 103 20 104 21 105 28 106 28 107 21 108 21 109 29 110 29 111 21 112 22 113 30 114 30 115 22 116 22 117 31 118 31 119 22 120 23 121 30 122 30 123 23 124 23 125 31 126 31 127 23 128 24 129 32 130 32 131 24 132 24 133 33 134 33 135 24 136 25 137 34 138 34 139 25 140 25 141 35 142 35 143 25 144 26 145 32 146 32 147 26 148 26 149 33 150 33 151 26 152 27 153 34 154 34 155 27 156 27 157 35 158 35 159 27 160 28 161 32 162 32 163 28 164 28 165 33 166 33 167 28 168 29 169 34 170 34 171 29 172 29 173 35 174 35 175 29 176 30 177 32 178 32 179 30 180 30 181 33 182 33 183 30 184 31 185 34 186 34 187 31 188 31 189 35 190 35 191 31}
array set links2 { 0 16 1 0 2 0 3 16 4 16 5 1 6 1 7 16 8 17 9 2 10 2 11 17 12 17 13 3 14 3 15 17 16 18 17 4 18 4 19 18 20 18 21 5 22 5 23 18 24 19 25 6 26 6 27 19 28 19 29 7 30 7 31 19 32 20 33 8 34 8 35 20 36 20 37 9 38 9 39 20 40 21 41 10 42 10 43 21 44 21 45 11 46 11 47 21 48 22 49 12 50 12 51 22 52 22 53 13 54 13 55 22 56 23 57 14 58 14 59 23 60 23 61 15 62 15 63 23 64 24 65 16 66 16 67 24 68 25 69 16 70 16 71 25 72 24 73 17 74 17 75 24 76 25 77 17 78 17 79 25 80 26 81 18 82 18 83 26 84 27 85 18 86 18 87 27 88 26 89 19 90 19 91 26 92 27 93 19 94 19 95 27 96 28 97 20 98 20 99 28 100 29 101 20 102 20 103 29 104 28 105 21 106 21 107 28 108 29 109 21 110 21 111 29 112 30 113 22 114 22 115 30 116 31 117 22 118 22 119 31 120 30 121 23 122 23 123 30 124 31 125 23 126 23 127 31 128 32 129 24 130 24 131 32 132 33 133 24 134 24 135 33 136 34 137 25 138 25 139 34 140 35 141 25 142 25 143 35 144 32 145 26 146 26 147 32 148 33 149 26 150 26 151 33 152 34 153 27 154 27 155 34 156 35 157 27 158 27 159 35 160 32 161 28 162 28 163 32 164 33 165 28 166 28 167 33 168 34 169 29 170 29 171 34 172 35 173 29 174 29 175 35 176 32 177 30 178 30 179 32 180 33 181 30 182 30 183 33 184 34 185 31 186 31 187 34 188 35 189 31 190 31 191 35}
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
		set p($num_agents) [new Agent/TCP]
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

# flows start
set tcp2 [build-tcp $n(0) $n(8) 1.5 2.8];
# commenting this block
#set tcp1 [build-tcp $n(1) $n(9) 1.7 2.7];
#set tcp1 [build-tcp $n(2) $n(10) 1.9 2.9];
#set tcp1 [build-tcp $n(3) $n(11) 2.1 3.1];
#set tcp1 [build-tcp $n(4) $n(12) 2.3 3.3];
#set tcp1 [build-tcp $n(5) $n(13) 2.5 3.5];
#set tcp1 [build-tcp $n(6) $n(14) 2.7 3.7];
#set tcp1 [build-tcp $n(7) $n(15) 2.9 3.9];

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

$ns at 3.53 "finish"
$ns run
