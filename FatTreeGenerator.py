#/usr/bin/python
import math
import pprint
import random

# Define k for the k - array FAT tree topology || Assumes k is even
k = 4;

# Define the link bandwidths & delays
endHost_to_edge_switch_bandwidth = 0.1
edge_switch_to_aggregator_switch_bandwidth = 0.1
aggregator_switch_to_core_switch_bandwidth = 0.1


endHost_to_edge_switch_delay = 0.025
edge_switch_to_aggregator_switch_delay = 0.025
aggregator_switch_to_core_switch_delay = 0.025

# compute the FAT tree properties
order_of_FAT_tree = k 
number_of_pods = k
num_of_endhosts = (k*k*k)/4

number_of_hosts_under_edge_switch = k/2

number_of_endHosts_per_pod = int(math.pow((k/2),2))

number_of_endHosts = int(math.pow(k,3)/4)

number_of_edge_switches_per_pod = int(k/2)

number_of_edge_switches = number_of_edge_switches_per_pod*number_of_pods

number_of_aggregator_switches = int(k/2)*number_of_pods

number_of_core_switches = int(math.pow((k/2),2))
number_of_aggregator_switches_in_pod = int(k/2)

# Global Data structures to hold nodes and links
endHosts = []
edgeSwitchs = []
aggregatorSwitchs = []
coreSwitches = []

endHostToEdgeSwitchLinks = []
edgeSwitchToAggregatorLinks = []
aggregatorSwitchToCoreSwitchLinks = []

### define methods ###
def generateEndHosts(nodeIndex):
    for endHostIndex in range(0, number_of_endHosts):
        endHosts.append({'node': "n"+ str(nodeIndex), 'type': "endHost"})
        nodeIndex += 1
    return nodeIndex

def generateEdgeSwitches(nodeIndex):
    print "generateEdgeSwitches"
    for edgeSwitchIndex in range(0, number_of_edge_switches):
        edgeSwitchs.append({'node': "n"+ str(nodeIndex), 'type': "edgeSwitch"})
        nodeIndex += 1
    return nodeIndex

def generateAggregatorSwitches(nodeIndex):
    for aggregatorSwitchIndex in range(0, number_of_aggregator_switches):
        aggregatorSwitchs.append({'node': "n"+ str(nodeIndex), 'type': "aggregatorSwitch"})
        nodeIndex += 1
    return nodeIndex

def generateCoreSwitchs(nodeIndex):
    for coreSwitchIndex in range(0, number_of_core_switches):
        coreSwitches.append({'node': "n"+ str(nodeIndex), 'type': "coreSwitch"})
        nodeIndex += 1
    return nodeIndex

# DEFINE LINKS
def generateEndHostToEdgesSwitchLinks():
    count = 1
    edgeSwitchIndex = 0
    for endHost in endHosts:
        endHostToEdgeSwitchLinks.append({'start': endHost['node'], 'end': edgeSwitchs[edgeSwitchIndex]['node'], "bandwidth": endHost_to_edge_switch_bandwidth})
        if (count%(number_of_edge_switches_per_pod) == 0):
            edgeSwitchIndex = edgeSwitchIndex + 1
        count += 1
    return

def generateEdgesSwitchToAggregatorLinks():

    pod_edge_switch_list = []
    pod_aggregate_list = []
    tmp = []
    count = 0
    # generate edge_switch in pods
    for edgeSwitch in edgeSwitchs:
        tmp.append(edgeSwitch)
        count += 1
        if (count%number_of_edge_switches_per_pod == 0):
            pod_edge_switch_list.append(tmp)
            tmp = []
    tmp = []
    count = 0
    # generate aggregator_switch in pods
    for aggregatorSwitch in aggregatorSwitchs:
        tmp.append(aggregatorSwitch)
        count += 1
        if(count%number_of_aggregator_switches_in_pod == 0):
            pod_aggregate_list.append(tmp)
            tmp = []
    # concat the above lists to make pods
    pods = [x for x in map(None, pod_aggregate_list, pod_edge_switch_list)]
    # generate the links per pod
    for pod in pods:
        for edge_switch in pod[1]:
            for aggregator_switch in pod[0]:
                edgeSwitchToAggregatorLinks.append({"start": edge_switch['node'], "end": aggregator_switch['node'], "bandwidth": edge_switch_to_aggregator_switch_bandwidth})
    return

def generateAggregatorSwitchToCoreSwitchLinks():
    pod_aggregate_list = []
    tmp = []
    count = 0
    # Generate aggregator_switch in pods
    for aggregatorSwitch in aggregatorSwitchs:
        tmp.append(aggregatorSwitch)
        count += 1
        if(count%number_of_aggregator_switches_in_pod == 0):
            pod_aggregate_list.append(tmp)
            tmp = []
    # generate links
    for pod_aggregate_switches in pod_aggregate_list:
        core_switches_per_aggregate_switch = math.floor(number_of_core_switches/len(pod_aggregate_switches))
        coreSwitchIndex = 0
        pod_count = 0
        while coreSwitchIndex < len(coreSwitches):
            aggregatorSwitchToCoreSwitchLinks.append({'start': pod_aggregate_switches[pod_count]['node'], 'end': coreSwitches[coreSwitchIndex]['node'], "bandwidth": aggregator_switch_to_core_switch_bandwidth})
            coreSwitchIndex += 1
            if (coreSwitchIndex%core_switches_per_aggregate_switch == 0):
                pod_count += 1
    return

# add the backward links for a given list of links
def addReverseLinks(linkList):
    tmp = []
    for link in linkList:
        tmp.append({"start": link['end'], "end": link['start'], "bandwidth": link["bandwidth"]})
    linkList.extend(tmp)
    return linkList

def convertToTXTFormat(nodeIndex):
    res = open('out.txt','w')
    for node in range(0,nodeIndex):
        res.write(str(node)+'\n')
    res.write('Links\n')
    links = endHostToEdgeSwitchLinks + edgeSwitchToAggregatorLinks + aggregatorSwitchToCoreSwitchLinks
    count = 0
    for link in links:
        res.write(link['start'][1:] + " " + link['end'][1:] + " " + str(count) + " " + str(link['bandwidth']) + "\n")
        count += 1
        res.write(link['end'][1:] + " " + link['start'][1:] + " " + str(count) + " " + str(link['bandwidth']) + "\n")
        count += 1
    res.close();
    return

# method for geenrating the .tcl file
def convertToTCLFormat(nodeIndex):
    res = open('out.tcl','w')

    # writing some methods
    res.write("set ns [new Simulator]\n\n$ns color 1 Blue\n$ns color 2 Red\n$ns color 3 Yellow\n\nset STATS_START 0\nset STATS_INTR 0.08\nset interval 0.08\n");
    res.write("\n\nproc flowDump {link fm file_p interval} {\nglobal ns\n$ns at [expr [$ns now] + $interval]  \"flowDump $link $fm $file_p $interval\"\nputs $file_p [format \"\nTime: %.4f\" [$ns now]] \nset theflows [$fm flows]\nif {[llength $theflows] == 0} {\nreturn\n} else {\nset total_arr [expr double([$fm set barrivals_])]\nif {$total_arr > 0} {\nforeach f $theflows {\nset arr [expr [expr double([$f set barrivals_])] / $total_arr]\nif {$arr >= 0.0001} {\nprintFlow $f $file_p $fm $interval\n}\n$f reset\n}\n$fm reset\n}\n}\n}");
    res.write("\n\nproc linkDump {link binteg pinteg qmon interval name linkfile util loss queue buf_bytes} {\n    global ns\n    set now_time [$ns now]\n    $ns at [expr $now_time + $interval] \"linkDump $link $binteg $pinteg $qmon $interval $name $linkfile $util $loss $queue $buf_bytes\"\n    set bandw [[$link link] set bandwidth_]\n    set queue_bd [$binteg set sum_]\n    set abd_queue [expr $queue_bd/[expr 1.*$interval]]\n    set queue_pd [$pinteg set sum_]\n    set apd_queue [expr $queue_pd/[expr 1.*$interval]]\n    set utilz [expr 8*[$qmon set bdepartures_]/[expr 1.*$interval*$bandw]]    \n    if {[$qmon set parrivals_] != 0} {\n        set drprt [expr [$qmon set pdrops_]/[expr 1.*[$qmon set parrivals_]]]\n        } else {\n            set drprt 0\n        }\n        if {$utilz != 0} {; \n        set a_delay [expr ($abd_queue*8*1000)/($utilz*$bandw)]\n        } else {\n            set a_delay 0.\n        }\n        puts $linkfile [format \"Time interval: %.6f-%.6f\" [expr [$ns now] - $interval] [$ns now]]\n        puts $linkfile [format \"Link %s: Utiliz=%.3f LossRate=%.3f AvgDelay=%.1fms AvgQueue(P)=%.0f AvgQueue(B)=%.0f\" $name $utilz $drprt $a_delay $apd_queue $abd_queue]\n        set av_qsize [expr [expr $abd_queue * 100] / $buf_bytes]\n        set utilz [expr $utilz * 100]\n        set drprt [expr $drprt * 100]\n        set buf_pkts [expr $buf_bytes / 1000]\n        puts $util [format \"%.6f   %.6f\" [$ns now] $utilz]\n        puts $loss [format \"%.6f   %.6f\" [$ns now] $drprt]\n        puts $queue [format \"%.6f   %.6f\" [$ns now] $av_qsize]\n        $binteg reset\n        $pinteg reset\n        $qmon reset\n    }\n\n");
    
    # opening files
    res.write("set nf [open out.nam w]\n$ns namtrace-all $nf\n\nproc finish {} {\n\tglobal ns nf\n\t$ns flush-trace\n\tclose $nf\n\texit 0\n}\n\n");
    
    # creating nodes
    res.write("set edge_link "+str(endHost_to_edge_switch_bandwidth*1000)+"Mb\nset agg_link "+str(edge_switch_to_aggregator_switch_bandwidth*1000)+"Mb\nset core_link "+str(aggregator_switch_to_core_switch_bandwidth*1000)+"Mb\n\nset edge_delay "+str(endHost_to_edge_switch_delay)+"ms\nset agg_delay  "+str(edge_switch_to_aggregator_switch_delay)+"ms\nset core_delay "+str(aggregator_switch_to_core_switch_delay)+"ms\n\nset num_hosts "+str(num_of_endhosts)+"\nset num_nodes "+str(nodeIndex)+"\n\nfor { set i 0 } { $i <= $num_nodes } { incr i } {\n    set n($i) [$ns node]\n}\n\n\n");

    # defining links
    links = endHostToEdgeSwitchLinks + edgeSwitchToAggregatorLinks + aggregatorSwitchToCoreSwitchLinks
    for link in links:
        res.write("$ns duplex-link $n("+link['start'][1:]+") $n("+link['end'][1:]+") $edge_link $edge_delay DropTail\n");

    
    # writing link array1
    index = 0;
    res.write("\n\narray set links1 {");
    for link in links:
        res.write(" "+str(index)+" "+link['start'][1:]);
        index += 1
        res.write(" "+str(index)+" "+link['end'][1:]);
        index += 1
    res.write("}\n");

    # writing link array2
    index = 0;
    res.write("array set links2 {");
    for link in links:
        res.write(" "+str(index)+" "+link['end'][1:]);
        index += 1
        res.write(" "+str(index)+" "+link['start'][1:]);
        index += 1
    res.write("}\n\n");

    # writing other data
    res.write("set lnk_size [array size links1]\n\n");
    res.write("for { set i 0 } { $i < [expr $lnk_size] } { incr i } {\n\tset qmon_ab($i) [$ns monitor-queue $n($links1($i)) $n($links2($i)) \"\"]\n\tset bing_ab($i) [$qmon_ab($i) get-bytes-integrator];\n\tset ping_ab($i) [$qmon_ab($i) get-pkts-integrator];\n\tset fileq($i) \"qmon.trace\"\n\tset futil_name($i) \"qmon.util\"\n\tset floss_name($i) \"qmon.loss\"\n\tset fqueue_name($i) \"qmon.queue\"\n\n\tappend fileq($i) \"$links1($i)\"\n\tappend fileq($i) \"$links2($i)\"\n\tappend futil_name($i) \"$links1($i)\"\n\tappend futil_name($i) \"$links2($i)\"\n\tappend floss_name($i) \"$links1($i)\"\n\tappend floss_name($i) \"$links2($i)\"\n\tappend fqueue_name($i) \"$links1($i)\"\n\tappend fqueue_name($i) \"$links2($i)\"\n\n\tset fq_mon($i) [open $fileq($i) w]\n\tset f_util($i) [open $futil_name($i) w]\n\tset f_loss($i) [open $floss_name($i) w]\n\tset f_queue($i) [open $fqueue_name($i) w]\n\n\t$ns at $STATS_START  \"$qmon_ab($i) reset\"\n\t$ns at $STATS_START  \"$bing_ab($i) reset\"\n\t$ns at $STATS_START  \"$ping_ab($i) reset\"\n\tset buf_bytes [expr 0.00025 * 1000 / 1 ]\n\t$ns at [expr $STATS_START+$STATS_INTR] \"linkDump [$ns link $n($links1($i)) $n($links2($i))] $bing_ab($i) $ping_ab($i) $qmon_ab($i) $STATS_INTR A-B $fq_mon($i) $f_util($i) $f_loss($i) $f_queue($i) $buf_bytes\"\n}\n");


    # writing last lines
    res.write("\n\nset num_nodes "+str(nodeIndex)+";\nset num_agents 0\nfor { set i 0 } { $i < $num_nodes } { incr i } {\n\tfor {set j 0} {$j < $num_nodes} {incr j} {\n\t\tset p($num_agents) [new Agent/Ping]\n\t\t$ns attach-agent $n($i) $p($num_agents)\n\t\tincr num_agents\n\t}\n}\n");
    res.write("\n\nset ite 0\nset jStart 0\nfor { set i 0 } { $i < "+str(nodeIndex)+" } { incr i } {\n\tfor { set j $jStart } { $j < "+str(nodeIndex+1)+" } { incr j } {\n\t\tif { $j == "+str(nodeIndex)+" } {\n\t\t\tset ite [expr $ite + $i + 1]\n\t\t\tcontinue\n\t\t}\n\n\t\t$ns connect $p($ite) $p([expr "+str(nodeIndex)+"*$j + $i])\n\t\tincr ite\n\t}\n\tincr jStart\n}\n");
    res.write("\n\n$ns run");
    res.close();
    return

def getReverseLinks(links):
    result = [];
    for link in links:
        result.append({'start': link['end'], 'end': link['start'], 'bandwidth': link['bandwidth']});
    return result

# function to divide a list into a number of lists
def slice_list(input, size):
	input_size = len(input)
	slice_size = input_size / size
	remain = input_size % size
	result = []
	iterator = iter(input)
	for i in range(size):
		result.append([])
		for j in range(slice_size):
			result[i].append(iterator.next())
		if remain:
			result[i].append(iterator.next())
			remain -= 1
	return result

# funciton fo greating mapping
def generateMapping():
	res = open("mapping.txt", 'w');   # opening file

	links1 = endHostToEdgeSwitchLinks + edgeSwitchToAggregatorLinks + aggregatorSwitchToCoreSwitchLinks
	links2 = getReverseLinks(links1);
    
    # creating the links list
	links = [];
	for i in range(0, len(links1)):
		links.append(links1[i]);
		links.append(links2[i]);

    # assigning ids to links
	id = 0;
	for link in links:
		link['id'] = str(id)
		id += 1

	ids = [];           # list that keeps track of links that belong to nodes under consideration
	listoflinks = [];	# list to store links of nodes

	for i in range(0, num_of_endhosts, number_of_hosts_under_edge_switch):
		# fetching original list
		temps = list(links)

		# clearing temporary list
		listoflinks = list();
		ids = list();

		for k in range(0, number_of_hosts_under_edge_switch):
			listoflinks.append("");

        # giving nodes their own links and putting their ids into list "ids"
		for temp in temps:
			for j in range(0, number_of_hosts_under_edge_switch):
				if ("n" + str(i + j)) == temp['start'] or ("n" + str(i + j)) == temp['end']:
					ids.append(temp['id']);
					listoflinks[j] += (temp['id'] + " ")

		# deleting links from temporary list of links
		for _id in ids:
			del(temps[int(_id)]);

		# shuffling the rest of the links
		random.shuffle(temps);

		# divinding the list of "links" into k/2 hosts
		parts = list();
		parts = slice_list(temps, number_of_hosts_under_edge_switch);
		
		# writing the contents of parts of temps (temporary list of links) to listoflinks (another temporary list)
		for k in range(0, len(parts)):
			part = parts[k];
			for link_in_part in part:
				listoflinks[k] += (link_in_part['id'] + " ")

		# writing data to the file
		for singlelist in listoflinks:
			res.write(singlelist);
			res.write("\n");
	
	# closing and returning
	res.close();
	return;

# main function of python script
def main():
	"""
	Defines the main method for the program
	"""
	nodeIndex = 0
	# generate the nodes
	nodeIndex = generateEndHosts(nodeIndex)
	print "Endhost generation complete"
	pprint.pprint(endHosts)
	print "number_of_endHosts::", len(endHosts)

	nodeIndex = generateEdgeSwitches(nodeIndex)
	print "edgeSwitchs generation complete"
	pprint.pprint(edgeSwitchs)
	print "number_of_edge_switches::", len(edgeSwitchs)

	nodeIndex = generateAggregatorSwitches(nodeIndex)
	print "aggregatorSwitchs generation complete"
	pprint.pprint(aggregatorSwitchs)
	print "number_of_aggregator_switches::", len(aggregatorSwitchs)

	nodeIndex = generateCoreSwitchs(nodeIndex)
	print "coreSwitches generation complete"
	pprint.pprint(coreSwitches)
	print "number_of_core_switches::", len(coreSwitches)

	# generate the links
	generateEndHostToEdgesSwitchLinks()
	print "EndNode To Edges Switch Links generated"
	pprint.pprint(endHostToEdgeSwitchLinks)

	generateEdgesSwitchToAggregatorLinks()
	print "Edge Switch To Aggregator Switch Links generated"
	pprint.pprint(edgeSwitchToAggregatorLinks)

	generateAggregatorSwitchToCoreSwitchLinks()
	print "Aggregator Switch To Core Switch Links generated"
	pprint.pprint(aggregatorSwitchToCoreSwitchLinks)

	print "Writing TXT file"
	convertToTXTFormat(nodeIndex)
	print 'task complete.'

	print "Writing TCL file"
	convertToTCLFormat(nodeIndex)
	print 'task complete.'

	print "Generating Mapping"
	generateMapping();
	print 'task complete.'    
	return

if __name__ == '__main__':
	main()
