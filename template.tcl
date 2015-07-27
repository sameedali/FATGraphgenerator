puts "sourcing template"
set ns [new Simulator]

$ns color 1 Blue
$ns color 2 Red
$ns color 3 Yellow

Node set multiPath_ 1
Classifier/MultiPath set perflow_ 1
Classifier/MultiPath set checkpathid_ 1

set STATS_START 0
set STATS_INTR 0.08
set interval 0.08

proc printFlow {f outfile fm interval} {
    global ns 
    #puts $outfile [format "FID: %d pckarv: %d bytarv: %d pckdrp: %d bytdrp: %d rate: %.0f drprt: %.3f" [$f set flowid_] [$f set parrivals_] [$f set barrivals_] [$f set pdrops_] [$f set bdrops_] [expr [$f set barrivals_]*8/($interval*1000.)] [expr [$f set pdrops_]/double([$f set parrivals_])] ]

    # flow_id, rate and drprt,
    #puts $outfile [format "%d %.0f  %.3f" [$f set flowid_] [expr [$f set barrivals_]*8/($interval*1000000.)] [expr [$f set pdrops_]/double([$f set parrivals_])] ]
    puts $outfile [format "%d %.6f " [$f set flowid_] [expr [$f set barrivals_]*8/($interval*1000000.)] ]

    if 0 {
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
        set flow(40) [open "flow40" a]
        set flow(41) [open "flow41" a]
        set flow(42) [open "flow42" a]
        set flow(43) [open "flow43" a]
    }

    if 0 {
        if { [$f set flowid_] == 0 } {
            puts $flow(0) [format "%.4f %.6f" [$ns now] [expr [$f set barrivals_]*8/($interval*1000000.)] ]
        }
        if { [$f set flowid_] == 1 } {
            puts $flow(1) [format "%.4f %.6f" [$ns now] [expr [$f set barrivals_]*8/($interval*1000000.)] ]
        }
        if { [$f set flowid_] == 2 } {
            puts $flow(2) [format "%.4f %.6f" [$ns now] [expr [$f set barrivals_]*8/($interval*1000000.)] ]
        }
        if { [$f set flowid_] == 3 } {
            puts $flow(3) [format "%.4f %.6f" [$ns now] [expr [$f set barrivals_]*8/($interval*1000000.)] ]
        }
        if { [$f set flowid_] == 4 } {
            puts $flow(4) [format "%.4f %.6f" [$ns now] [expr [$f set barrivals_]*8/($interval*1000000.)] ]
        }
        if { [$f set flowid_] == 5 } {
            puts $flow(5) [format "%.4f %.6f" [$ns now] [expr [$f set barrivals_]*8/($interval*1000000.)] ]
        }
        if { [$f set flowid_] == 6 } {
            puts $flow(6) [format "%.4f %.6f" [$ns now] [expr [$f set barrivals_]*8/($interval*1000000.)] ]
        }
        if { [$f set flowid_] == 7 } {
            puts $flow(7) [format "%.4f %.6f" [$ns now] [expr [$f set barrivals_]*8/($interval*1000000.)] ]
        }
        if { [$f set flowid_] == 8 } {
            puts $flow(8) [format "%.4f %.6f" [$ns now] [expr [$f set barrivals_]*8/($interval*1000000.)] ]
        }
        if { [$f set flowid_] == 9 } {
            puts $flow(9) [format "%.4f %.6f" [$ns now] [expr [$f set barrivals_]*8/($interval*1000000.)] ]
        }
        if { [$f set flowid_] == 40 } {
            puts $flow(40) [format "%.4f %.6f" [$ns now] [expr [$f set barrivals_]*8/($interval*1000000.)] ]
        }
        if { [$f set flowid_] == 41 } {
            puts $flow(41) [format "%.4f %.6f" [$ns now] [expr [$f set barrivals_]*8/($interval*1000000.)] ]
        }
        if { [$f set flowid_] == 42 } {
            puts $flow(42) [format "%.4f %.6f" [$ns now] [expr [$f set barrivals_]*8/($interval*1000000.)] ]
        }
        if { [$f set flowid_] == 43 } {
            puts $flow(43) [format "%.4f %.6f" [$ns now] [expr [$f set barrivals_]*8/($interval*1000000.)] ]
        }
    }

    if 0 {
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
        close $flow(40)
        close $flow(41)
        close $flow(42)
        close $flow(43)
    }
}

proc flowDump {link fm file_p interval} {
    global ns
    $ns at [expr [$ns now] + $interval]  "flowDump $link $fm $file_p $interval"
    puts $file_p [format "Time: %.4f" [$ns now]]
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


proc linkDump {link binteg pinteg qmon interval name linkfile util buf_bytes} {
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
        if {$utilz != 0} {;
        set a_delay [expr ($abd_queue*8*1000)/($utilz*$bandw)]
        } else {
            set a_delay 0.
        }
        puts $linkfile [format "Time interval: %.6f-%.6f" [expr [$ns now] - $interval] [$ns now]]
        puts $linkfile [format "Link %s: Utiliz=%.3f LossRate=%.3f AvgDelay=%.1fms AvgQueue(P)=%.0f AvgQueue(B)=%.0f" $name $utilz $drprt $a_delay $apd_queue $abd_queue]
        set av_qsize [expr [expr $abd_queue * 100] / $buf_bytes]
        set utilz [expr $utilz * 100]
        set drprt [expr $drprt * 100]
        set buf_pkts [expr $buf_bytes / 1000]
        puts $util [format "%.6f   %.6f" [$ns now] $utilz]
        $binteg reset
        $pinteg reset
        $qmon reset
}

# variables for build_tcp function
$ns rtproto DV
Agent/rtProto/DV set advertInterval 16

set f_id 0
set time_tcp 0
set time_increment 0.0001
proc build-tcp { n0 n1 startTime } {
    global ns

    set tcp [new Agent/TCP]
    $ns attach-agent $n0 $tcp

    set snk [new Agent/TCPSink]
    $ns attach-agent $n1 $snk

    $ns connect $tcp $snk

    set ftp [new Application/FTP]
    $ftp attach-agent $tcp
    $ns at $time_tcp "$tcp send"
    set time_tcp [expr [$time_tcp + $time_increment]]
    $ns at $startTime "$tcp flow_start"
    $ns at $startTime "$ftp start"
    
    $tcp set fid_ $f_id
    incr f_id
    return $tcp
}

# opening output files
set nf [open out.nam w]
$ns namtrace-all $nf

# defining finish procedure
proc finish {} {
    global ns nf
    $ns flush-trace
    close $nf
    exit 0
}

puts "done sourcing template"