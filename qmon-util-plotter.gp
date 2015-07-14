set terminal postscript color eps enhanced
set output "plot-qmon-util.ps"
set title "Plot of Link Utilization"
set ylabel "Link Utilization"
set xlabel "Number of RTTs" # 0,0.5"
set xtics 10
plot "" title "link utilization" with lines
