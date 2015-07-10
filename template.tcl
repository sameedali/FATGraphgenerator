puts "sourcing template"
set ns [new Simulator]

$ns color 1 Blue
$ns color 2 Red
$ns color 3 Yellow

set STATS_START 0
set STATS_INTR 0.08
set interval 0.08

proc flowDump {link fm file_p interval} {
    global ns
    $ns at [expr [$ns now] + $interval]  \"flowDump $link $fm $file_p $interval\"
    puts $file_p [format \"Time: %.4f\" [$ns now]]
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


proc linkDump {link binteg pinteg qmon interval name linkfile util loss queue buf_bytes} {
    global ns
    set now_time [$ns now]
    $ns at [expr $now_time + $interval] \"linkDump $link $binteg $pinteg $qmon $interval $name $linkfile $util $loss $queue $buf_bytes\"
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
        puts $linkfile [format \"Time interval: %.6f-%.6f\" [expr [$ns now] - $interval] [$ns now]]
        puts $linkfile [format \"Link %s: Utiliz=%.3f LossRate=%.3f AvgDelay=%.1fms AvgQueue(P)=%.0f AvgQueue(B)=%.0f\" $name $utilz $drprt $a_delay $apd_queue $abd_queue]
        set av_qsize [expr [expr $abd_queue * 100] / $buf_bytes]
        set utilz [expr $utilz * 100]
        set drprt [expr $drprt * 100]
        set buf_pkts [expr $buf_bytes / 1000]
        puts $util [format \"%.6f   %.6f\" [$ns now] $utilz]
        puts $loss [format \"%.6f   %.6f\" [$ns now] $drprt]
        puts $queue [format \"%.6f   %.6f\" [$ns now] $av_qsize]
        $binteg reset
        $pinteg reset
        $qmon reset
}
puts "done sourcing template"

