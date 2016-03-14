
#
# Print periodic "i'am alive" message
#
proc print_time {interval} {
global ns 
        #puts stdout [format "\nTime: %.2f" [$ns now]]
        $ns at [expr [$ns now]+$interval] "print_time $interval"
}


#
# Dump the statistics of a (unidirectional) link periodically 
#
proc linkDump {link binteg pinteg qmon interval name linkfile util loss queue buf_bytes} {
global ns
        set now_time [$ns now]
        $ns at [expr $now_time + $interval] "linkDump $link $binteg $pinteg $qmon $interval $name $linkfile $util $loss $queue $buf_bytes"
        set bandw [[$link link] set bandwidth_]
        set queue_bd [$binteg set sum_]
        set abd_queue [expr $queue_bd/[expr 1.*$interval]]
        set queue_pd [$pinteg set sum_]
        set apd_queue [expr $queue_pd/[expr 1.*$interval]]
        set utilz [expr 8*[$qmon set bdepartures_]/[expr 1.*$interval*$bandw]]    

        if {[$qmon set parrivals_] != 0} {
                set drprt [expr [$qmon set pdrops_]/[expr 1.*[$qmon set parrivals_]]]
        } else {
                set drprt 0
        }
	if {$utilz != 0} {;	# compute avg queueing delay based on Little's formula
		set a_delay [expr ($abd_queue*8*1000)/($utilz*$bandw)]
	} else {
		set a_delay 0.
	}
#        puts stdout [format "\nTime interval: %.2f-%.2f" [expr [$ns now] - $interval] [$ns now]]
        puts $linkfile [format "\nTime interval: %.6f-%.6f" [expr [$ns now] - $interval] [$ns now]]
        puts $linkfile [format "Link %s: Utiliz=%.3f LossRate=%.3f AvgDelay=%.1fms AvgQueue(P)=%.0f AvgQueue(B)=%.0f" $name $utilz $drprt $a_delay $apd_queue $abd_queue]
    
        #loss_sample, util_sample and queue_sample
    
    

        set av_qsize [expr [expr $abd_queue * 100] / $buf_bytes]
        set utilz [expr $utilz * 100]
        set drprt [expr $drprt * 100]

    set buf_pkts [expr $buf_bytes / 1000]

#        puts "Buffer Size (bytes) = $buf_bytes"
#        puts "Buffer Size (pkts) = $buf_pkts"

        puts $util [format "%.6f   %.6f" [$ns now] $utilz]
	puts $loss [format "%.6f   %.6f" [$ns now] $drprt]
#	puts $queue [format "%.3f   %.3f" [$ns now] $apd_queue]
	puts $queue [format "%.6f   %.6f" [$ns now] $av_qsize]

    
        $binteg reset
        $pinteg reset
        $qmon reset
}


#
# Print the statistics of a flow
#
proc printFlow {f outfile fm interval} {
global ns 
#puts $outfile [format "FID: %d pckarv: %d bytarv: %d pckdrp: %d bytdrp: %d rate: %.0f drprt: %.3f" [$f set flowid_] [$f set parrivals_] [$f set barrivals_] [$f set pdrops_] [$f set bdrops_] [expr [$f set barrivals_]*8/($interval*1000.)] [expr [$f set pdrops_]/double([$f set parrivals_])] ]

# flow_id, rate and drprt,
#puts $outfile [format "%d %.0f  %.3f" [$f set flowid_] [expr [$f set barrivals_]*8/($interval*1000000.)] [expr [$f set pdrops_]/double([$f set parrivals_])] ]

puts $outfile [format "%d %.6f " [$f set flowid_] [expr [$f set barrivals_]*8/($interval*1000000.)] ]


set flow(0) [open "flow0" a]
set flow(1) [open "flow1" a]
set flow(2) [open "flow2" a]
set flow(3) [open "flow3" a]
set flow(4) [open "flow4" a]
set flow(5) [open "flow5" a]
set flow(6) [open "flow6" a]
set flow(7) [open "flow7" a]
set flow(8) [open "flow8" a]
set flow(9) [open "flow9" a]


if { [$f set flowid_] == 0 } {
    puts $flow(0) [format "%.3f %.6f" [$ns now] [expr [$f set barrivals_]*8/($interval*1000000.)] ]
}
if { [$f set flowid_] == 1 } {
    puts $flow(1) [format "%.3f %.6f" [$ns now] [expr [$f set barrivals_]*8/($interval*1000000.)] ]
}
if { [$f set flowid_] == 2 } {
    puts $flow(2) [format "%.3f %.6f" [$ns now] [expr [$f set barrivals_]*8/($interval*1000000.)] ]
}
if { [$f set flowid_] == 3 } {
    puts $flow(3) [format "%.3f %.6f" [$ns now] [expr [$f set barrivals_]*8/($interval*1000000.)] ]
}
if { [$f set flowid_] == 4 } {
    puts $flow(4) [format "%.3f %.6f" [$ns now] [expr [$f set barrivals_]*8/($interval*1000000.)] ]
}
if { [$f set flowid_] == 5 } {
    puts $flow(5) [format "%.3f %.6f" [$ns now] [expr [$f set barrivals_]*8/($interval*1000000.)] ]
}
if { [$f set flowid_] == 6 } {
    puts $flow(6) [format "%.3f %.6f" [$ns now] [expr [$f set barrivals_]*8/($interval*1000000.)] ]
}
if { [$f set flowid_] == 7 } {
    puts $flow(7) [format "%.3f %.6f" [$ns now] [expr [$f set barrivals_]*8/($interval*1000000.)] ]
}
if { [$f set flowid_] == 8 } {
    puts $flow(8) [format "%.3f %.6f" [$ns now] [expr [$f set barrivals_]*8/($interval*1000000.)] ]
}
if { [$f set flowid_] == 9 } {
    puts $flow(9) [format "%.3f %.6f" [$ns now] [expr [$f set barrivals_]*8/($interval*1000000.)] ]
}


close $flow(0)
close $flow(1)
close $flow(2)
close $flow(3)
close $flow(4)
close $flow(5)
close $flow(6)
close $flow(7)
close $flow(8)
close $flow(9)

}


#
# Dump the statistics of all flows
#
proc flowDump {link fm file_p interval} {
global ns 

    $ns at [expr [$ns now] + $interval]  "flowDump $link $fm $file_p $interval"
        puts $file_p [format "\nTime: %.2f" [$ns now]] 
        set theflows [$fm flows]
        if {[llength $theflows] == 0} {
                return
        } else {
        	set total_arr [expr double([$fm set barrivals_])]
        	if {$total_arr > 0} {
                	foreach f $theflows {
                        	set arr [expr [expr double([$f set barrivals_])] / $total_arr]
                        	if {$arr >= 0.0001} {
				    printFlow $f $file_p $fm $interval
                        	}       
                        	$f reset
                	}       
                	$fm reset
        	}
        }
}



#
# Create "infinite-duration" FTP connection
#
proc inf_ftp {id src dst maxwin pksize starttm} {
global ns 
        set tcp [$ns create-connection TCP/Newreno $src TCPSink/DelAck $dst $id]
        set ftp [$tcp attach-source FTP]
  	$tcp set window_ 	$maxwin
  	$tcp set packetSize_ 	$pksize
        $ns at $starttm "$ftp start"
	return $tcp
}


#
# Create an Exponential On-Off source
#
proc build-exp-off { src dest pktSize burstTime idleTime rate id startTime } {
    global ns
    set cbr [new Agent/CBR/UDP]
    $ns attach-agent $src $cbr
    set null [new Agent/Null]
    $ns attach-agent $dest $null
    $ns connect $cbr $null
    set exp1 [new Traffic/Expoo]
    $exp1 set packet-size $pktSize
    $exp1 set burst-time  [expr $burstTime / 1000.0] 
    $exp1 set idle-time   [expr $idleTime / 1000.0]
    $exp1 set rate        [expr $rate * 1000.0]
    $cbr  attach-traffic  $exp1
    $ns at $startTime "$cbr start"
    $cbr set fid_      $id
    return $cbr
}


#
# Create Short-lived TCP flows
#
proc build-short-lived { src dest pktSize fid node_id startTime tcp_src tcp_sink transfer_size} {
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

