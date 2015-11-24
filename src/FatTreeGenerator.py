# /usr/bin/python
import math
import pprint
import random
import commands
import sys

# Define k for the k - array FAT tree topology || Assumes k is even
k = 4

# Define the link bandwidths & delays
endHost_to_edge_switch_bandwidth = 0.1
edge_switch_to_aggregator_switch_bandwidth = 0.1
aggregator_switch_to_core_switch_bandwidth = 0.1


endHost_to_edge_switch_delay = 0.025
edge_switch_to_aggregator_switch_delay = 0.025
aggregator_switch_to_core_switch_delay = 0.025

# Donot edit anything below here #
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

# for level = 3 of a k -ary FAT tree
number_of_links = 3 * ((math.pow(k, 3)) / 4)

# Global Data structures to hold nodes and links
nodeIndex = 0
linkIndex = 0

endHosts = []
edgeSwitchs = []
aggregatorSwitchs = []
coreSwitches = []

endHostToEdgeSwitchLinks = []
edgeSwitchToAggregatorLinks = []
aggregatorSwitchToCoreSwitchLinks = []

# define methods


def generateEndHosts():
    global nodeIndex
    for endHostIndex in range(0, number_of_endHosts):
        endHosts.append({'node': "n" + str(nodeIndex), 'type': "endHost"})
        nodeIndex += 1
    return


def generateEdgeSwitches():
    global nodeIndex
    for edgeSwitchIndex in range(0, number_of_edge_switches):
        edgeSwitchs.append({'node': "n" + str(nodeIndex), 'type': "edgeSwitch"})
        nodeIndex += 1
    return


def generateAggregatorSwitches():
    global nodeIndex
    for aggregatorSwitchIndex in range(0, number_of_aggregator_switches):
        aggregatorSwitchs.append({'node': "n" + str(nodeIndex), 'type': "aggregatorSwitch"})
        nodeIndex += 1
    return


def generateCoreSwitchs():
    global nodeIndex
    for coreSwitchIndex in range(0, number_of_core_switches):
        coreSwitches.append({'node': "n" + str(nodeIndex), 'type': "coreSwitch"})
        nodeIndex += 1
    return


# DEFINE LINKS
def generateEndHostToEdgesSwitchLinks():
    global linkIndex
    count = 1
    edgeSwitchIndex = 0
    for endHost in endHosts:
        endHostToEdgeSwitchLinks.append({'start': endHost['node'],
                                         'end': edgeSwitchs[edgeSwitchIndex]['node'],
                                         "bandwidth": endHost_to_edge_switch_bandwidth,
                                         "id": linkIndex})
        linkIndex += 1
        endHostToEdgeSwitchLinks.append({'start': edgeSwitchs[edgeSwitchIndex]['node'],
                                         'end': endHost['node'],
                                         "bandwidth": endHost_to_edge_switch_bandwidth,
                                         "id": linkIndex})
        linkIndex += 1
        if (count % (number_of_edge_switches_per_pod) == 0):
            edgeSwitchIndex = edgeSwitchIndex + 1
        count += 1
    return


def generateEdgesSwitchToAggregatorLinks():
    global linkIndex
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
                edgeSwitchToAggregatorLinks.append({"start": edge_switch['node'],
                                                    "end": aggregator_switch['node'],
                                                    "bandwidth": edge_switch_to_aggregator_switch_bandwidth,
                                                    "id": linkIndex})
                linkIndex += 1
                edgeSwitchToAggregatorLinks.append({"start": aggregator_switch['node'],
                                                    "end": edge_switch['node'],
                                                    "bandwidth": edge_switch_to_aggregator_switch_bandwidth,
                                                    "id": linkIndex})
                linkIndex += 1
    return


def generateAggregatorSwitchToCoreSwitchLinks():
    global linkIndex
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
            aggregatorSwitchToCoreSwitchLinks.append({'start': pod_aggregate_switches[pod_count]['node'],
                                                      'end': coreSwitches[coreSwitchIndex]['node'],
                                                      "bandwidth": aggregator_switch_to_core_switch_bandwidth,
                                                      "id": linkIndex})
            linkIndex += 1
            aggregatorSwitchToCoreSwitchLinks.append({'end': pod_aggregate_switches[pod_count]['node'],
                                                      'start': coreSwitches[coreSwitchIndex]['node'],
                                                      "bandwidth": aggregator_switch_to_core_switch_bandwidth,
                                                      "id": linkIndex})
            linkIndex += 1
            coreSwitchIndex += 1
            if (coreSwitchIndex % core_switches_per_aggregate_switch == 0):
                pod_count += 1
    return


def convertToTXTFormat():
    # write the nodes
    res = open('out.txt', 'w')
    for node in range(0, nodeIndex):
        res.write(str(node) + '\n')
    # write the links
    res.write('Links\n')
    links = endHostToEdgeSwitchLinks + edgeSwitchToAggregatorLinks + aggregatorSwitchToCoreSwitchLinks
    count = 0
    for link in links:
        res.write(link['start'][1:] + " " + link['end'][1:] + " " + str(count) + " " + str(link['bandwidth']) + "\n")
        count += 1
    res.close()
    return


# method for geenrating the .tcl file
def convertToTCLFormat():
    res = open('out.tcl', 'w')

    res.write("source template.tcl\n\n")
    # res.write("# opening output files\n")
    # res.write("set nf [open out.nam w]\n$ns namtrace-all $nf\n\n")

    # res.write("# defining finish procedure\n")
    # res.write("proc finish {} {\n\tglobal ns nf\n\t$ns flush-trace\n\tclose $nf\n\texit 0\n}\n\n")

    # creating nodes
    res.write("# defining link properties\n")
    res.write("set edge_link " + str(endHost_to_edge_switch_bandwidth * 1000) + "Mb\n"
              + "set agg_link " + str(edge_switch_to_aggregator_switch_bandwidth * 1000) + "Mb\n"
              + "set core_link " + str(aggregator_switch_to_core_switch_bandwidth * 1000) + "Mb\n\n")
    res.write("set edge_delay " + str(endHost_to_edge_switch_delay) + "ms\n"
              + "set agg_delay " + str(edge_switch_to_aggregator_switch_delay) + "ms\n"
              + "set core_delay " + str(aggregator_switch_to_core_switch_delay) + "ms\n\n")
    res.write("set num_hosts " + str(num_of_endhosts) + "\n"
              + "set num_nodes "
              + str(nodeIndex)
              + "\n\n")

    res.write("# creating nodes\n")
    res.write("for { set i 0 } { $i <= $num_nodes } { incr i } {\n    set n($i) [$ns node]\n}\n\n")

    # defining links
    res.write("# creating links\n")

    links = endHostToEdgeSwitchLinks + edgeSwitchToAggregatorLinks + aggregatorSwitchToCoreSwitchLinks

    # TODO: recheck this
    # Remove reverse links form links
    no_reverse_links = []
    removed_links = []

    # TODO: FIX THIS PROPERLY TO REMOVE DUPLICATE LINKS
    for link in links:
        if int(link['id']) % 2 == 0:
            no_reverse_links.append(link)
        else:
            removed_links.append(link)

    links = no_reverse_links

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
    res.write("for { set i 0 } { $i < [expr $lnk_size] } { incr i } "
              + "{\n\tset qmon_ab($i) [$ns monitor-queue $n($links1($i)) $n($links2($i)) \"\"]"
              + "\n\tset bing_ab($i) [$qmon_ab($i) get-bytes-integrator];"
              + "\n\tset ping_ab($i) [$qmon_ab($i) get-pkts-integrator];"
              + "\n\tset fileq($i) \"qmon.trace\"\n\tset futil_name($i) \"qmon.util\"\n\t\n"
              + "\tappend fileq($i) \"$links1($i)\"\n\tappend fileq($i) \"$links2($i)\"\n\t"
              + "append futil_name($i) \"$links1($i)\"\n\tappend futil_name($i) \"$links2($i)\"\n\t\n"
              + "set fq_mon($i) [open $fileq($i) w]\n\tset f_util($i) [open $futil_name($i) w]\n\n\n"
              + "\t$ns at $STATS_START  \"$qmon_ab($i) reset\"\n\t$ns at $STATS_START  \"$bing_ab($i) reset\"\n"
              + "\t$ns at $STATS_START  \"$ping_ab($i) reset\"\n\tset buf_bytes [expr 0.00025 * 1000 / 1 ]\n"
              + "\t$ns at [expr $STATS_START+$STATS_INTR] \"linkDump [$ns link $n($links1($i)) $n($links2($i))] "
              + "$bing_ab($i) $ping_ab($i) $qmon_ab($i) $STATS_INTR A-B $fq_mon($i) $f_util($i) $buf_bytes\"\n}\n")
    # writing Ping agent to the .tcl file
    res.write("\n\nset num_nodes "
              + str(nodeIndex)
              + ";\nset num_agents 0\n"
              + "for { set i 0 } { $i < $num_nodes } { incr i } "
              + "{\n\tfor {set j 0} {$j < $num_nodes} {incr j} "
              + "{\n\t\tset p($num_agents) [new Agent/Ping]\n"
              + "\t\t$ns attach-agent $n($i) $p($num_agents)\n\t\tincr num_agents\n\t}\n}\n")

    res.write("\n\nset ite 0\nset jStart 0\nfor { set i 0 } { $i < "
              + str(nodeIndex)
              + " } { incr i } {\n\tfor { set j $jStart } { $j < "
              + str(nodeIndex + 1)
              + " } { incr j } {\n\t\tif { $j == "
              + str(nodeIndex)
              + " } {\n\t\t\tset ite [expr $ite + $i + 1]\n\t\t\tcontinue\n\t\t}\n\n\t\t$ns connect $p($ite) $p([expr "
              + str(nodeIndex)
              + "*$j + $i])\n\t\tincr ite\n\t}\n\tincr jStart\n}\n\n")
    # writing Raza agent to the .tcl file
    res.write("set num_agents1 $num_agents\nfor { set i 0 } { $i < $num_nodes } { incr i } "
              + "{\n\tfor {set j 0} {$j < $num_nodes} {incr j} "
              + "{\n\t\tset p($num_agents) [new Agent/Raza]\n"
              + "\t\t$ns attach-agent $n($i) $p($num_agents)\n\t\tincr num_agents\n\t}\n}\n\n")

    res.write("set ite $num_agents1\nset jStart 0\nfor { set i 0 } { $i < "
              + str(nodeIndex)
              + " } { incr i } {\n\tfor { set j $jStart } { $j < "
              + str(nodeIndex + 1)
              + " } { incr j } {\n\t\tif { $j == "
              + str(nodeIndex)
              + " } {\n\t\t\tset ite [expr $ite + $i + 1]\n\t\t\tcontinue\n\t\t}\n\t\t$ns connect $p($ite) $p([expr "
              + str(nodeIndex)
              + "*$j + $i + $num_agents1])\n\t\tincr ite\n\t}\n\tincr jStart\n}\n")
    res.write("\n# TODO: start flows herer\n\nputs \"running ns\"\n$ns run")
    res.close()
    return


# function for generating reverse links
# def getReverseLinks(links):
#     result = []
#     for link in links:
#         result.append({'start': link['end'], 'end': link['start'], 'bandwidth': link['bandwidth']})
#     return result

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


# TODO: test function for greating mapping per pod bottom up
def generateMappingPerPodBottomUp(give_nodes_own_links):
    res = open("mapping.txt", 'w')   # opening file

    all_links = endHostToEdgeSwitchLinks + edgeSwitchToAggregatorLinks + aggregatorSwitchToCoreSwitchLinks
    print "all links size:", len(all_links)

    # will contain dicts like :: {"node_id": , "list_of_links": []}
    link_allocations = []

    for node in endHosts:
        link_allocations.append({"node_id": node['node'][1:], "list_of_links": []})

    # giving nodes their own links and putting their ids into list "ids"
    if give_nodes_own_links is True:
        for link in all_links:
            # assuming counting starts from 0 and number_of_endHosts are the first n values
            for j in range(0, number_of_endHosts):
                if ("n" + str(j)) == link['start'] or ("n" + str(j)) == link['end']:
                    # find item in allocations and append to it
                    for item in link_allocations:
                        if(item['node_id'] == str(j)):
                            item['list_of_links'].append(link)

    # allocate the links to each pod
    for i in range(0, num_of_endhosts, number_of_endHosts_per_pod):
        # fetching original list
        temp_all_links = list(all_links)

        # find links already allocated to pod
        allocated_links = []
        for item in link_allocations:
            for j in range(i, i + number_of_endHosts_per_pod):
                if (str(j) == item['node_id']):
                    allocated_links.extend(item['list_of_links'])

        # remove allocated_link from temp_all_links
        for allocated_link in allocated_links:
            temp_all_links.remove(allocated_link)

        # print "temp_all_links size ::", len(temp_all_links)
        # print "allocated links"
        # pprint.pprint(allocated_links)

        # get only links inside the pod
        pod_links = []

        # end all links end hosts connect to
        # add all switch id end hosst connect to
        tor_list = []
        for link in temp_all_links:
            for j in range(i, i + number_of_endHosts_per_pod):
                if link['start'] == ("n" + str(j)):
                    pod_links.append(link)
                    tor_list.append(link)
                if link['end'] == ("n" + str(j)):
                    pod_links.append(link)

        # add all links lead to the aggs from the tor
        # agg_list = []
        for tor_link in tor_list:
            for link in temp_all_links:
                if tor_link['end'] == link['start']:
                    pod_links.append(link)
                    # agg_list.append(link)
                    # add reverse link
                    for lnk in temp_all_links:
                        if lnk['start'] == link['end'] and lnk['start'] == link['start']:
                            pod_links.append(lnk)

        # remove duplicates
        temp = []
        for link1 in pod_links:
            for link2 in pod_links:
                if link1 not in temp:
                    temp.append(link1)
        pod_links = temp

        # shuffling the rest of the links
        random.shuffle(pod_links)

        # divinding the list of "links" into k/2 hosts
        equally_divided_lists_of_links = slice_list(pod_links, number_of_endHosts_per_pod)

        for item in link_allocations:
            for j in range(i, i + number_of_endHosts_per_pod):
                if (str(j) == item['node_id']):
                    item['list_of_links'].extend(equally_divided_lists_of_links[j % number_of_endHosts_per_pod])

    # writing data to the file
    for item in link_allocations:
        res.write(str(item['node_id']))
        res.write(":")
        for link in item['list_of_links']:
            res.write(" ")
            res.write(str(link['id']))
        res.write("\n")

    # closing and returning
    res.close()
    return


# function for greating mapping per pod bottom up
def generateMappingPerPod(give_nodes_own_links):
    res = open("mapping.txt", 'w')   # opening file

    all_links = endHostToEdgeSwitchLinks + edgeSwitchToAggregatorLinks + aggregatorSwitchToCoreSwitchLinks
    print "all links size:", len(all_links)

    # will contain dicts like :: {"node_id": , "list_of_links": []}
    link_allocations = []

    for node in endHosts:
        link_allocations.append({"node_id": node['node'][1:], "list_of_links": []})

    # giving nodes their own links and putting their ids into list "ids"
    if give_nodes_own_links is True:
        for link in all_links:
            # assuming counting starts from 0 and number_of_endHosts are the first n values
            for j in range(0, number_of_endHosts):
                if ("n" + str(j)) == link['start'] or ("n" + str(j)) == link['end']:
                    # find item in allocations and append to it
                    for item in link_allocations:
                        if(item['node_id'] == str(j)):
                            item['list_of_links'].append(link)

    # allocate the links to each pod
    for i in range(0, num_of_endhosts, number_of_endHosts_per_pod):
        # fetching original list
        temp_all_links = list(all_links)

        # find links already allocated to pod
        allocated_links = []
        for item in link_allocations:
            for j in range(i, i + number_of_endHosts_per_pod):
                if (str(j) == item['node_id']):
                    allocated_links.extend(item['list_of_links'])

        # remove allocated_link from temp_all_links
        for allocated_link in allocated_links:
            temp_all_links.remove(allocated_link)

        # print "temp_all_links size ::", len(temp_all_links)
        # print "allocated links"
        # pprint.pprint(allocated_links)

        # shuffling the rest of the links
        random.shuffle(temp_all_links)

        # divinding the list of "links" into k/2 hosts
        equally_divided_lists_of_links = slice_list(temp_all_links, number_of_endHosts_per_pod)

        for item in link_allocations:
            for j in range(i, i + number_of_endHosts_per_pod):
                if (str(j) == item['node_id']):
                    item['list_of_links'].extend(equally_divided_lists_of_links[j % number_of_endHosts_per_pod])

    # writing data to the file
    for item in link_allocations:
        res.write(str(item['node_id']))
        res.write(":")
        for link in item['list_of_links']:
            res.write(" ")
            res.write(str(link['id']))
        res.write("\n")

    # closing and returning
    res.close()
    return


# funciton for greating mapping
def generateMapping(give_nodes_own_links):
    res = open("mapping.txt", 'w')   # opening file

    all_links = endHostToEdgeSwitchLinks + edgeSwitchToAggregatorLinks + aggregatorSwitchToCoreSwitchLinks
    print "all links size:", len(all_links)

    # will contain dicts like :: {"node_id": , "list_of_links": []}
    link_allocations = []

    for node in endHosts:
        link_allocations.append({"node_id": node['node'][1:], "list_of_links": []})

    # giving nodes their own links and putting their ids into list "ids"
    if give_nodes_own_links is True:
        for link in all_links:
            # assuming counting starts from 0 and number_of_endHosts are the first n values
            for j in range(0, number_of_endHosts):
                if ("n" + str(j)) == link['start'] or ("n" + str(j)) == link['end']:
                    # find item in allocations and append to it
                    for item in link_allocations:
                        if(item['node_id'] == str(j)):
                            item['list_of_links'].append(link)

    # allocate the links to each pod
    for i in range(0, num_of_endhosts, number_of_hosts_under_edge_switch):
        # fetching original list
        temp_all_links = list(all_links)

        # find links already allocated to pod
        allocated_links = []
        for item in link_allocations:
            for j in range(i, i + number_of_hosts_under_edge_switch):
                if (str(j) == item['node_id']):
                    allocated_links.extend(item['list_of_links'])

        # remove allocated_link from temp_all_links
        for allocated_link in allocated_links:
            temp_all_links.remove(allocated_link)

        # print "temp_all_links size ::", len(temp_all_links)
        # print "allocated links"
        # pprint.pprint(allocated_links)

        # shuffling the rest of the links
        random.shuffle(temp_all_links)

        # divinding the list of "links" into k/2 hosts
        equally_divided_lists_of_links = slice_list(temp_all_links, number_of_hosts_under_edge_switch)

        for item in link_allocations:
            for j in range(i, i + number_of_hosts_under_edge_switch):
                if (str(j) == item['node_id']):
                    item['list_of_links'].extend(equally_divided_lists_of_links[j % number_of_hosts_under_edge_switch])

    # writing data to the file
    for item in link_allocations:
        res.write(str(item['node_id']))
        res.write(":")
        for link in item['list_of_links']:
            res.write(" ")
            res.write(str(link['id']))
        res.write("\n")

    # closing and returning
    res.close()
    return


def printDetails():
    """prints the nodes and links generated.
    :returns: TODO

    """
    print "Endhosts:\n"
    pprint.pprint(endHosts)
    print "number_of_endHosts::", len(endHosts)

    print "edgeSwitchs: \n"
    pprint.pprint(edgeSwitchs)
    print "number_of_edge_switches::", len(edgeSwitchs)

    print "aggregatorSwitchs:\n"
    pprint.pprint(aggregatorSwitchs)
    print "number_of_aggregator_switches::", len(aggregatorSwitchs)

    print "coreSwitches: \n"
    pprint.pprint(coreSwitches)
    print "number_of_core_switches::", len(coreSwitches)

    print "EndNode To Edges Switch Links:\n"
    pprint.pprint(endHostToEdgeSwitchLinks)

    print "Edge Switch To Aggregator Switch Links :\n"
    pprint.pprint(edgeSwitchToAggregatorLinks)

    print "Aggregator Switch To Core Switch Links:\n"
    pprint.pprint(aggregatorSwitchToCoreSwitchLinks)
    return


# main function of python script
def start():
    """
    Defines the main method for the program
    """
    # generate the nodes
    print "generating nodes"
    generateEndHosts()

    generateEdgeSwitches()

    generateAggregatorSwitches()

    generateCoreSwitchs()

    print "node generation complete"

    # generate the links
    print "generating links"
    generateEndHostToEdgesSwitchLinks()

    generateEdgesSwitchToAggregatorLinks()

    generateAggregatorSwitchToCoreSwitchLinks()

    print "link generation complete"

    links = aggregatorSwitchToCoreSwitchLinks + edgeSwitchToAggregatorLinks + endHostToEdgeSwitchLinks

    # multiplied by 2 becase we consider each link to be 2 links in TCL file
    assert len(links) == (number_of_links * 2), "Incorrect number of links calculated"

    print "Writing all links and node to TXT file"
    convertToTXTFormat()
    print 'task complete.'

    print "Writing TCL file"
    convertToTCLFormat()
    print 'task complete.'

    print "Generating Mapping"
    generateMapping(False)
    print 'task complete.'

    # print "Generating per pod Mapping"
    # generateMappingPerPod(False)
    # print 'task complete.'

    # print "Generating per pod Mapping"
    # generateMappingPerPodBottomUp(False)
    # print 'task complete.'
    return

print "================================================================================"
print "==                         GENERATING TOPOLOGY                                =="
print "================================================================================"

start()

print "================================================================================"

print "copying files... \n"
moving_files = commands.getstatusoutput('cp ./mapping.txt ./out.tcl ./createUtilGraph.py ./tcl/template.tcl ./out.txt ../out/')
# move file to test dir too
commands.getstatusoutput('cp ./mapping.txt ../test/')
if int(moving_files[0]) != 0:
    print "move failed"
    sys.exit(1)

print "Deleting files \n"
deleting_files = commands.getstatusoutput('rm ./mapping.txt ./out.tcl ./out.txt')
if int(deleting_files[0]) != 0:
    print "Delete failed"
    sys.exit(1)

# run tests on created files
print "================================================================================"
print "==                         RUNNING TESTS                                      =="
print "================================================================================"
print "Make sure to set the vars in the test files before running tests"
test_result = commands.getstatusoutput('cd ../test/ && python test_mapping.py')

print "test result status code:", test_result[0], "\n"

if int(test_result[0]) != 0:
    print "test failed... aborting"
    sys.exit(1)

print "test result message::"
print test_result[1]
# go back to src
commands.getstatusoutput('cd ../src')
print "================================================================================"
print "================================================================================"
print "Completed."
