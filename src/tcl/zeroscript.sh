#!/bin/sh

# Network Paramters

machines=4
tor=2
aggr=2
core=1
ac_bw=1000
ta_bw=1000
mt_bw=1000
rttp=0.3 #in miliseconds
simtime=10 # in seconds
buff_bdp=(6.6)
base_buf=(38) #in packets
lbuf=125 # long flow buffer in packets

SRC=TCP/Sack1
SINK=TCPSink/Sack1
QUEUE=DropTail

min=2 #in KB
max=98 #in KB
mice_load=(10 20 30 40 50 60 70 80 90)
all_to_all=0
pareto_rate=0
incast_senders=0
data_chunk=1 #in MB
incast_mice_load=0
custom=1
interR=1

seed=(1 2 3 4 5 6 7 8 9 10)

lflow=0
short=0

min_rto=0.001

# protocol="tcp"
protocol="mulbuff"
#protocol="dctcp"
#protocol="pfabric"
#protocol=("tcp")
other_user=1 ; # select user itself

user="mulbuff"
#user="dctcp"
#user="mulbuff"
#user="tcp"
#user="pfabric"
#user="dctcp-mulbuff"


increment=3
marking_thresh=(20)

STATS_INTR=0.003 #in seconds


#pfabric params

slowstartrestart=1
ackRatio=1
prio_scheme_=2
prob_cap_=5
drop_prio_="true"
deque_prio_="true"
keep_order_="true"

enablePQ=0
PQ_mode=0
PQ_gamma=0
PQ_thresh=0

enablePacer=1
Pacer_assoc_timeout=0.001
Pacer_assoc_prob=0.125
Pacer_qlength_factor=3000
Pacer_rate_ave_factor=0.125
Pacer_rate_update_interval=0.0000072

webSearch=1 # 0 means Data Mining and 1 means Web-Search

for protocolval in "${protocol[@]}"
do


	if [ $other_user == 0 ];
		then
		if [ $protocolval == "pfabric" ];
			then
			user="pfabric"
		elif [ $protocolval == "tcp" ];
			then
			user="tcp"
		elif [ $protocolval == "dctcp" ];
			then
			user="dctcp"
		elif [ $protocolval == "mulbuff" ];
			then
			user="mulbuff"
		elif [ $protocolval == "dctcp-mulbuff" ];
			then
			user="dctcp-mulbuff"
		fi
	fi

	echo $user

	if [ $protocolval == "pfabric" ];
		then
		ns_ver=ns-allinone-2.34
		ns_v=ns-2.34
		echo "using ns-2.34"
	else
		ns_ver=ns-allinone-2.35
		ns_v=ns-2.35
	fi

	mkdir together_flowtimes


	for marking_threshval in "${marking_thresh[@]}"
	do
		for buff_bdpval in "${buff_bdp[@]}"
		do
			for mice_loadval in "${mice_load[@]}"
			do
				for pareto_rateval in "${pareto_rate[@]}"
				do
					for incast_sendersval in "${incast_senders[@]}"
					do
						for incast_mice_loadval in "${incast_mice_load[@]}"
						do
							for seedval in "${seed[@]}"
							do
								for lflowval in "${lflow[@]}"
								do
									for min_rtoval in "${min_rto[@]}"
									do
										for incrementval in "${increment[@]}"
										do
											

											for base_bufval in "${base_buf[@]}"
											do

												foldername=$protocolval
												if ((${#buff_bdp[@]} > 1))
													then
													foldername=$foldername"_buff_bdp"$buff_bdpval
												fi

												if ((${#marking_thresh[@]} > 1))
													then
													foldername=$foldername"_marking_thresh"$marking_threshval
												fi

												if ((${#mice_load[@]} > 1))
													then
													foldername=$foldername"_miceload"$mice_loadval
												fi

												if ((${#pareto_rate[@]} > 1))
													then
													foldername=$foldername"_paretorate"$pareto_rateval
												fi

												if ((${#incast_senders[@]} > 1))
													then
													foldername=$foldername"_incastsenders"$incast_sendersval
												fi

												if ((${#incast_mice_load[@]} > 1))
													then
													foldername=$foldername"_incastmice"$incast_mice_loadval
												fi

												if ((${#seed[@]} > 1))
													then
													foldername=$foldername"_seed"$seedval
												fi

												if ((${#lflow[@]} > 1))
													then
													foldername=$foldername"_lflow"$lflowval
												fi

												if ((${#min_rto[@]} > 1))
													then
													foldername=$foldername"_minrto"$min_rtoval
												fi

												if ((${#increment[@]} > 1))
													then
													foldername=$foldername"_increment"$incrementval
												fi

												if ((${#base_buf[@]} > 1))
													then
													foldername=$foldername"_basebuf"$base_bufval
												fi

												graphtitle=$foldername
												mkdir $foldername
												cp CDF_dctcp.tcl $foldername/
												cp CDF.tcl $foldername/
												cp baseline.tcl $foldername/
												cp cdfplot $foldername/
												cp plot $foldername/
												cp loss $foldername/
												cp queue $foldername/
												cp timeCdf.py $foldername/
												cp twoway_basic_functions.tcl $foldername/
												cp throughput_cdf.py $foldername/
												cd $foldername

												chmod +x baseline.tcl

												echo "machines="$machines >> run_settings.txt
												echo "tor="$tor >> run_settings.txt
												echo "aggr="$aggr >> run_settings.txt
												echo "core="$core >> run_settings.txt
												echo "ac_bw="$ac_bw >> run_settings.txt
												echo "rttp="$rttp >> run_settings.txt
												echo "simtime="$simtime >> run_settings.txt
												echo "buff_bdp="$buff_bdpval >> run_settings.txt
												echo "SRC="$SRC >> run_settings.txt
												echo "SINK="$SINK >> run_settings.txt
												echo "QUEUE="$QUEUE >> run_settings.txt
												echo "min="$min >> run_settings.txt
												echo "max="$max >> run_settings.txt
												echo "mice_load="$mice_loadval >> run_settings.txt
												echo "pareto_rate="$pareto_rateval >> run_settings.txt
												echo "incast_senders="$incast_sendersval >> run_settings.txt
												echo "data_chunk="$data_chunk >> run_settings.txt
												echo "incast_mice_load="$incast_mice_loadval >> run_settings.txt
												echo "seed="$seedval >> run_settings.txt
												echo "lflow="$lflowval >> run_settings.txt
												echo "min_rto="$min_rtoval >> run_settings.txt
												echo "protocol="$protocolval >> run_settings.txt
												echo "increment="$incrementval >> run_settings.txt
												echo "STATS_INTR="$STATS_INTR >> run_settings.txt
												echo "user="$user >> run_settings.txt

												/home/$user/$ns_ver/$ns_v/ns baseline.tcl $machines $tor $aggr $core $ac_bw $ta_bw $mt_bw $rttp $simtime $buff_bdpval $base_bufval $SRC $SINK $QUEUE $min $max $mice_loadval $pareto_rateval $incast_sendersval $data_chunk $incast_mice_loadval $lflowval $min_rtoval $STATS_INTR $protocolval $incrementval $seedval $marking_threshval $short $slowstartrestart $ackRatio $prio_scheme_ $prob_cap_ $drop_prio_ $deque_prio_ $keep_order_ $enablePQ $PQ_mode $PQ_gamma $PQ_thresh $enablePacer $Pacer_assoc_timeout $Pacer_assoc_prob $Pacer_qlength_factor $Pacer_rate_ave_factor $Pacer_rate_update_interval $lbuf $all_to_all $custom $webSearch $interR


												temp="(flow_id)"
												replacetemp="(flow_id-"$lflowval")"
												sed -i "s/$temp/$replacetemp/" timeCdf.py


												python timeCdf.py

												cdfname="cdf_"$foldername".ps"
												sed -i "s/cdf.ps/$cdfname/" cdfplot
												sed -i "s/INSERTTITLEHERE/$graphtitle/" cdfplot
												gnuplot cdfplot
												cp flowtimescdf "flowtimescdf"$foldername
												cp fct_summary "fct_summary"$foldername
												cp "flowtimescdf"$foldername ../together_flowtimes/
												cp "fct_summary"$foldername ../together_flowtimes/

												# Added by Adil
												cp fct_summary_short "fct_summary_short"$foldername
												cp fct_summary_long "fct_summary_long"$foldername
												cp fct_summary_mice "fct_summary_mice"$foldername
												cp fct_summary_tiny "fct_summary_tiny"$foldername
												cp fct_summary_elephant "fct_summary_elephant"$foldername
												#

												# Added by Adil
												cp "fct_summary_short"$foldername ../together_flowtimes/
												cp "fct_summary_long"$foldername ../together_flowtimes/
												cp "fct_summary_mice"$foldername ../together_flowtimes/
												cp "fct_summary_tiny"$foldername ../together_flowtimes/
												cp "fct_summary_elephant"$foldername ../together_flowtimes/
												#


												endplot="0.00:"$simtime
												initialplot="0.09:1"
												echo $endplot

												nthroughput="sim_time = "$simtime
												sed -i "s/sim_time = 3/$nthroughput/" throughput_cdf.py 
												nstep="step_size = "$STATS_INTR
												sed -i "s/step_size = 0.0003/$nstep/" throughput_cdf.py

												python throughput_cdf.py

												mkdir utilgraphs
												mkdir lossgraphs
												mkdir queuegraphs


												for src in qmon.util*
												do

													mv $src utilgraphs
													cp plot utilgraphs
													cd utilgraphs
													utilname="graph_"$src".ps"
													sed -i "s/$initialplot/$endplot/" plot
													sed -i "s/util.ps/$utilname/" plot
													sed -i "s/INSERTGRAPHTITLEHERE/$src/" plot
													sed -i "s/qmon.util01/$src/" plot
													gnuplot plot

													cd ..

												done

												for src in qmon.loss*
												do

													mv $src lossgraphs
													cp loss lossgraphs
													cd lossgraphs
													lossname="graph_"$src".ps"
													sed -i "s/$initialplot/$endplot/" loss
													sed -i "s/loss.ps/$lossname/" loss
													sed -i "s/INSERTGRAPHTITLEHERE/$src/" loss
													sed -i "s/qmon.loss01/$src/" loss
													gnuplot loss


													cd ..
												done

												for src in qmon.queue*
												do

													mv $src queuegraphs
													cp queue queuegraphs
													cd queuegraphs
													queuename="graph_"$src".ps"
													sed -i "s/$initialplot/$endplot/" queue
													sed -i "s/loss.ps/$queuename/" queue
													sed -i "s/INSERTGRAPHTITLEHERE/$src/" queue
													sed -i "s/qmon.queue01/$src/" queue				
													gnuplot queue

													cd ..

												done

												cd ..
											done
										done
									done
								done
							done
						done
					done
				done
			done
		done
	done
done

# Added by Adil

mkdir together_flowtimes/avg_results

cp avg_fct_mulbuff.sh together_flowtimes/avg_results
cp avg_fct_mulbuff_short.sh together_flowtimes/avg_results
cp avg_fct_mulbuff_long.sh together_flowtimes/avg_results
cp avg_fct_mulbuff_mice.sh together_flowtimes/avg_results
cp avg_fct_mulbuff_tiny.sh together_flowtimes/avg_results
cp avg_fct_mulbuff_elephant.sh together_flowtimes/avg_results

cd together_flowtimes/avg_results

bash avg_fct_mulbuff.sh
bash avg_fct_mulbuff_short.sh
bash avg_fct_mulbuff_long.sh
bash avg_fct_mulbuff_mice.sh
bash avg_fct_mulbuff_tiny.sh
bash avg_fct_mulbuff_elephant.sh


echo "Experiment done!"
