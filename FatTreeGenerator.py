# /usr/bin/python
import math
import pprint
import random
import os
import commands

# Define k for the k - array FAT tree topology || Assumes k is even
k = 8

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
num_of_endhosts = (k * k * k) / 4

number_of_hosts_under_edge_switch = k / 2

number_of_endHosts_per_pod = int(math.pow((k / 2), 2))

number_of_endHosts = int(math.pow(k, 3) / 4)

number_of_edge_switches_per_pod = int(k / 2)

number_of_edge_switches = number_of_edge_switches_per_pod * number_of_pods

number_of_aggregator_switches = int(k / 2) * number_of_pods

number_of_core_switches = int(math.pow((k / 2), 2))
number_of_aggregator_switches_in_pod = int(k / 2)

# Global Data structures to hold nodes and links
endHosts = []
edgeSwitchs = []
aggregatorSwitchs = []
coreSwitches = []

endHostToEdgeSwitchLinks = []
edgeSwitchToAggregatorLinks = []
aggregatorSwitchToCoreSwitchLinks = []

# ## define methods ###


def generateEndHosts(nodeIndex):
    for endHostIndex in range(0, number_of_endHosts):
        endHosts.append({'node': "n" + str(nodeIndex), 'type': "endHost"})
        nodeIndex += 1
    return nodeIndex


def generateEdgeSwitches(nodeIndex):
    print "generateEdgeSwitches"
    for edgeSwitchIndex in range(0, number_of_edge_switches):
        edgeSwitchs.append({'node': "n" + str(nodeIndex), 'type': "edgeSwitch"})
        nodeIndex += 1
    return nodeIndex


def generateAggregatorSwitches(nodeIndex):
    for aggregatorSwitchIndex in range(0, number_of_aggregator_switches):
        aggregatorSwitchs.append({'node': "n" + str(nodeIndex), 'type': "aggregatorSwitch"})
        nodeIndex += 1
    return nodeIndex


def generateCoreSwitchs(nodeIndex):
    for coreSwitchIndex in range(0, number_of_core_switches):
        coreSwitches.append({'node': "n" + str(nodeIndex), 'type': "coreSwitch"})
        nodeIndex += 1
    return nodeIndex


# DEFINE LINKS
def generateEndHostToEdgesSwitchLinks():
    count = 1
    edgeSwitchIndex = 0
    for endHost in endHosts:
        endHostToEdgeSwitchLinks.append({'start': endHost['node'], 'end': edgeSwitchs[edgeSwitchIndex]['node'], "bandwidth": endHost_to_edge_switch_bandwidth})
        if (count % (number_of_edge_switches_per_pod) == 0):
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
        if (count % number_of_edge_switches_per_pod == 0):
            pod_edge_switch_list.append(tmp)
            tmp = []
    tmp = []
    count = 0
    # generate aggregator_switch in pods
    for aggregatorSwitch in aggregatorSwitchs:
        tmp.append(aggregatorSwitch)
        count += 1
        if(count % number_of_aggregator_switches_in_pod == 0):
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
        if(count % number_of_aggregator_switches_in_pod == 0):
            pod_aggregate_list.append(tmp)
            tmp = []
    # generate links
    for pod_aggregate_switches in pod_aggregate_list:
        core_switches_per_aggregate_switch = math.floor(number_of_core_switches / len(pod_aggregate_switches))
        coreSwitchIndex = 0
        pod_count = 0
        while coreSwitchIndex < len(coreSwitches):
            aggregatorSwitchToCoreSwitchLinks.append({'start': pod_aggregate_switches[pod_count]['node'], 'end': coreSwitches[coreSwitchIndex]['node'], "bandwidth": aggregator_switch_to_core_switch_bandwidth})
            coreSwitchIndex += 1
            if (coreSwitchIndex % core_switches_per_aggregate_switch == 0):
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
    res = open('out.txt', 'w')
    for node in range(0, nodeIndex):
        res.write(str(node) + '\n')
    res.write('Links\n')
    links = endHostToEdgeSwitchLinks + edgeSwitchToAggregatorLinks + aggregatorSwitchToCoreSwitchLinks
    count = 0
    for link in links:
        res.write(link['start'][1:] + " " + link['end'][1:] + " " + str(count) + " " + str(link['bandwidth']) + "\n")
        count += 1
        res.write(link['end'][1:] + " " + link['start'][1:] + " " + str(count) + " " + str(link['bandwidth']) + "\n")
        count += 1
    res.close()
    return


# method for geenrating the .tcl file
def convertToTCLFormat(nodeIndex):
    res = open('out.tcl', 'w')

    res.write("source template.tcl\n\n")
    # res.write("# opening output files\n")
    # res.write("set nf [open out.nam w]\n$ns namtrace-all $nf\n\n")

    # res.write("# defining finish procedure\n")
    # res.write("proc finish {} {\n\tglobal ns nf\n\t$ns flush-trace\n\tclose $nf\n\texit 0\n}\n\n")

    # creating nodes
    res.write("# defining link properties\n")
    res.write("set edge_link " + str(endHost_to_edge_switch_bandwidth * 1000) + "Mb\nset agg_link " + str(edge_switch_to_aggregator_switch_bandwidth * 1000) + "Mb\nset core_link " + str(aggregator_switch_to_core_switch_bandwidth * 1000) + "Mb\n\n")
    res.write("set edge_delay " + str(endHost_to_edge_switch_delay) + "ms\nset agg_delay  " + str(edge_switch_to_aggregator_switch_delay) + "ms\nset core_delay " + str(aggregator_switch_to_core_switch_delay) + "ms\n\n")
    res.write("set num_hosts " + str(num_of_endhosts) + "\nset num_nodes " + str(nodeIndex) + "\n\n")

    res.write("# creating nodes\n")
    res.write("for { set i 0 } { $i <= $num_nodes } { incr i } {\n    set n($i) [$ns node]\n}\n\n")

    # defining links
    res.write("# creating links\n")
    links = endHostToEdgeSwitchLinks + edgeSwitchToAggregatorLinks + aggregatorSwitchToCoreSwitchLinks
    for link in links:
        res.write("$ns duplex-link $n(" + link['start'][1:] + ") $n(" + link['end'][1:] + ") $edge_link $edge_delay DropTail\n")

    # writing link array1
    res.write("\n# creating link arrays\n")
    index = 0
    res.write("array set links1 {")
    for link in links:
        res.write(" " + str(index) + " " + link['start'][1:])
        index += 1
        res.write(" " + str(index) + " " + link['end'][1:])
        index += 1
    res.write("}\n")

    # writing link array2
    index = 0
    res.write("array set links2 {")
    for link in links:
        res.write(" " + str(index) + " " + link['end'][1:])
        index += 1
        res.write(" " + str(index) + " " + link['start'][1:])
        index += 1
    res.write("}\n")

    # writing other data
    res.write("set lnk_size [array size links1]\n\n")
    res.write("# monitoring links\n")
    res.write("for { set i 0 } { $i < [expr $lnk_size] } { incr i } {\n\tset qmon_ab($i) [$ns monitor-queue $n($links1($i)) $n($links2($i)) \"\"]\n\tset bing_ab($i) [$qmon_ab($i) get-bytes-integrator];\n\tset ping_ab($i) [$qmon_ab($i) get-pkts-integrator];\n\tset fileq($i) \"qmon.trace\"\n\tset futil_name($i) \"qmon.util\"\n\t\n\
    append fileq($i) \"$links1($i)\"\n\tappend fileq($i) \"$links2($i)\"\n\tappend futil_name($i) \"$links1($i)\"\n\tappend futil_name($i) \"$links2($i)\"\n\t\n\
    set fq_mon($i) [open $fileq($i) w]\n\tset f_util($i) [open $futil_name($i) w]\n\n\n\
    $ns at $STATS_START  \"$qmon_ab($i) reset\"\n\t$ns at $STATS_START  \"$bing_ab($i) reset\"\n\t$ns at $STATS_START  \"$ping_ab($i) reset\"\n\tset buf_bytes [expr 0.00025 * 1000 / 1 ]\n\
    $ns at [expr $STATS_START+$STATS_INTR] \"linkDump [$ns link $n($links1($i)) $n($links2($i))] $bing_ab($i) $ping_ab($i) $qmon_ab($i) $STATS_INTR A-B $fq_mon($i) $f_util($i) $buf_bytes\"\n}\n")

    # writing Ping agent to the .tcl file
    res.write("\n\nset num_nodes " + str(nodeIndex) + ";\nset num_agents 0\nfor { set i 0 } { $i < $num_nodes } { incr i } {\n\tfor {set j 0} {$j < $num_nodes} {incr j} {\n\t\tset p($num_agents) [new Agent/Ping]\n\t\t$ns attach-agent $n($i) $p($num_agents)\n\t\tincr num_agents\n\t}\n}\n")
    res.write("\n\nset ite 0\nset jStart 0\nfor { set i 0 } { $i < " + str(nodeIndex) + " } { incr i } {\n\tfor { set j $jStart } { $j < " + str(nodeIndex + 1) + " } { incr j } {\n\t\tif { $j == " + str(nodeIndex) + " } {\n\t\t\tset ite [expr $ite + $i + 1]\n\t\t\tcontinue\n\t\t}\n\n\t\t$ns connect $p($ite) $p([expr " + str(nodeIndex) + "*$j + $i])\n\t\tincr ite\n\t}\n\tincr jStart\n}\n\n")

    # writing Raza agent to the .tcl file
    res.write("set num_agents1 $num_agents\nfor { set i 0 } { $i < $num_nodes } { incr i } {\n\tfor {set j 0} {$j < $num_nodes} {incr j} {\n\t\tset p($num_agents) [new Agent/Raza]\n\t\t$ns attach-agent $n($i) $p($num_agents)\n\t\tincr num_agents\n\t}\n}\n\n")
    res.write("set ite $num_agents1\nset jStart 0\nfor { set i 0 } { $i < " + str(nodeIndex) + " } { incr i } {\n\tfor { set j $jStart } { $j < " + str(nodeIndex + 1) + " } { incr j } {\n\t\tif { $j == " + str(nodeIndex) + " } {\n\t\t\tset ite [expr $ite + $i + 1]\n\t\t\tcontinue\n\t\t}\n\t\t$ns connect $p($ite) $p([expr " + str(nodeIndex) + "*$j + $i + $num_agents1])\n\t\tincr ite\n\t}\n\tincr jStart\n}\n")

    res.write("\n\nputs \"running ns\"\n$ns run")
    res.close()
    return


# function for generating reverse links
def getReverseLinks(links):
    result = []
    for link in links:
        result.append({'start': link['end'], 'end': link['start'], 'bandwidth': link['bandwidth']})
    return result

# function for dividing a list into a number of lists


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


# funciton for greating mapping
def generateMapping():

    forwardLinks = endHostToEdgeSwitchLinks + edgeSwitchToAggregatorLinks + aggregatorSwitchToCoreSwitchLinks
    reverseLinks = getReverseLinks(forwardLinks)

    # creating the links list
    allLinks = []
    for i in range(0, len(forwardLinks)):
        allLinks.append(forwardLinks[i])
        allLinks.append(reverseLinks[i])

    # assigning ids to links
    id = 0
    for link in allLinks:
        link['id'] = str(id)
        id += 1

    # define all nodes
    allNodes = endHosts + edgeSwitchs + aggregatorSwitchs + coreSwitches

    # make nodeListLinks
    nodeListLinks = []
    for nodes in endHosts:
        nodeListLinks.append(" ")

    # make sure in each pod the endHost has closest link
    ids = []
    for nodeId in range(0, len(nodeListLinks)):
        for link in allLinks:
            if ((link['start'] == 'n' + str(nodeId)) or (link['end'] == 'n' + str(nodeId))):
                nodeListLinks[nodeId] += link['id'] + " "
                ids.append(link['id'])

    # remove these links form allLinks
    for id in ids:
        for link in allLinks:
            if (link['id'] == id):
                del link

    # distribute rest of the links in each pod
    podLinks = []
    for it in range(0, number_of_pods):
        if(len(podLinks) <= it):
            podLinks.append([])
        for link in allLinks:
            podLinks[it].append(link)

    # shuffle links
    for podLink in podLinks:
        random.shuffle(podLink)

    # associate rest of pod nodes with podLinks
    number_of_endhosts_per_pod = len(endHosts) / number_of_pods

    print "number_of_endhosts_per_pod:", number_of_endhosts_per_pod

    iter = 0
    podIndex = 0
    for podLink in podLinks:
        i = number_of_endhosts_per_pod * podIndex
        for link in podLink:
            nodeListLinks[i] += link['id'] + " "
            i += 1
            if i >= ((number_of_endhosts_per_pod * podIndex) + (number_of_endhosts_per_pod)):
                i = number_of_endhosts_per_pod * podIndex
        podIndex += 1

    # writing data to the file
    res = open("mapping.txt", 'w')   # opening file
    nodeIndex = 0
    for nodeLink in nodeListLinks:
        res.write(str(nodeIndex))
        res.write(": ")
        res.write(nodeLink)
        res.write("\n")
        # incrementing link index
        nodeIndex += 1
    # closing and returning
    res.close()
    return


# function for creating graphs from qmon.util* files
def createGraphs():
    status, output = commands.getstatusoutput("find . -name qmon.util\*")
    mylist = output.split("\n")

    plotter = open("qmon-util-plotter.gp", 'w')
    for filename in mylist:
        filename = filename[2:]

        plotter.write("set terminal postscript color eps enhanced\n")
        plotter.write("set output \"plot-qmon-util" + filename[9:] + ".ps\"\n")

        plotter.write("set title \"Plot of Link Utilization\"\nset ylabel \"Link Utilization\"\nset xlabel \"Number of RTTs\" # 0,0.5\"\nset xtics 10\n")
        plotter.write("plot \"" + filename + "\" title \"link utilization\" with lines,")
        os.system("gnuplot qmon-util-plotter.gp")
    return


# main function of python script
def main():
    """
    Defines the main method for the program
    """
    nodeIndex = 0
    # generate the nodes
    nodeIndex = generateEndHosts(nodeIndex)
    print "Endhost generation complete"
    # pprint.pprint(endHosts)
    print "number_of_endHosts::", len(endHosts)

    nodeIndex = generateEdgeSwitches(nodeIndex)
    print "edgeSwitchs generation complete"
    # pprint.pprint(edgeSwitchs)
    print "number_of_edge_switches::", len(edgeSwitchs)

    nodeIndex = generateAggregatorSwitches(nodeIndex)
    print "aggregatorSwitchs generation complete"
    # pprint.pprint(aggregatorSwitchs)
    print "number_of_aggregator_switches::", len(aggregatorSwitchs)

    nodeIndex = generateCoreSwitchs(nodeIndex)
    print "coreSwitches generation complete"
    # pprint.pprint(coreSwitches)
    print "number_of_core_switches::", len(coreSwitches)

    # generate the links
    generateEndHostToEdgesSwitchLinks()
    print "EndNode To Edges Switch Links generated"
    # pprint.pprint(endHostToEdgeSwitchLinks)

    generateEdgesSwitchToAggregatorLinks()
    print "Edge Switch To Aggregator Switch Links generated"
    # pprint.pprint(edgeSwitchToAggregatorLinks)

    generateAggregatorSwitchToCoreSwitchLinks()
    print "Aggregator Switch To Core Switch Links generated"
    # pprint.pprint(aggregatorSwitchToCoreSwitchLinks)

    print "Total number of links: ", 2 * len(endHostToEdgeSwitchLinks + edgeSwitchToAggregatorLinks + aggregatorSwitchToCoreSwitchLinks)

    print "Writing TXT file"
    convertToTXTFormat(nodeIndex)
    print 'task complete.'

    print "Writing TCL file"
    convertToTCLFormat(nodeIndex)
    print 'task complete.'

    print "Generating Mapping"
    generateMapping()
    print 'task complete.'
    return

if __name__ == '__main__':
    main()
