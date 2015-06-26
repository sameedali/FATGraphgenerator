#/usr/bin/python
import math
import pprint

# Define k for the k - array FAT tree topology || Assumes k is even
k = 4;

order_of_FAT_tree = k

number_of_pods = k

number_of_hosts_under_edge_switch = k/2

number_of_endHosts_per_pod = int(math.pow((k/2),2))

number_of_endHosts = int(math.pow(k,3)/4)

number_of_edge_switches_per_pod = int(k/2)

number_of_edge_switches = number_of_edge_switches_per_pod*number_of_pods

number_of_aggregator_switches = int(k/2)*number_of_pods

number_of_core_switches = int(math.pow((k/2),2))

number_of_aggregator_switches_in_pod = int(k/2)

# Data structure to hold end hosts
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
def generateEndNodeToEdgesSwitchLinks():
    count = 1
    edgeSwitchIndex = 0
    for endHost in endHosts:
        endHostToEdgeSwitchLinks.append({'start': endHost['node'], 'end': edgeSwitchs[edgeSwitchIndex]['node'] })
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
                edgeSwitchToAggregatorLinks.append({"start": edge_switch['node'], "end": aggregator_switch['node']})
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
            aggregatorSwitchToCoreSwitchLinks.append({'start': pod_aggregate_switches[pod_count]['node'], 'end': coreSwitches[coreSwitchIndex]['node'] })
            coreSwitchIndex += 1
            if (coreSwitchIndex%core_switches_per_aggregate_switch == 0):
                pod_count += 1
    return

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
    generateEndNodeToEdgesSwitchLinks()
    print "EndNode To Edges Switch Links generated"
    pprint.pprint(endHostToEdgeSwitchLinks)

    generateEdgesSwitchToAggregatorLinks()
    print "Edge Switch To Aggregator Switch Links generated"
    pprint.pprint(edgeSwitchToAggregatorLinks)

    generateAggregatorSwitchToCoreSwitchLinks()
    print "Aggregator Switch To Core Switch Links generated"
    pprint.pprint(aggregatorSwitchToCoreSwitchLinks)
    return

if __name__ == '__main__':
    main()
