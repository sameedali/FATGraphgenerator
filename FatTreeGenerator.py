#/usr/bin/python

import math
import pprint

# Define the N for the N-array FAT tree topology || Assumes N is even
N = 4;

number_of_pods = N

number_of_endHosts = int(N*N)

number_of_edge_switches = int(number_of_endHosts/2)

number_of_aggregator_switches = int(number_of_edge_switches/2)

number_of_core_switches = int(number_of_aggregator_switches/2)

# Data structure to hold end hosts
endHosts = []
edgeSwitchs = []
aggregatorSwitchs = []
coreSwitches = []

endHostToEdgeSwitchLinks = []
edgeSwitchToAggregatorLink = []
aggregatorSwitchToCoreSwitchLink = []

### define methods ###
def generateEndHosts():
    for nodeIndex in range(0, number_of_endHosts):
        endHosts.append({'node': "n"+ str(nodeIndex), 'type': "endHost"})
    return

def generateEdgeSwitches():
    print "generateEdgeSwitches"
    for edgeSwitchIndex in range(number_of_endHosts, number_of_edge_switches+ number_of_endHosts):
        edgeSwitchs.append({'node': "n"+ str(edgeSwitchIndex), 'type': "edgeSwitch"})
    return

def generateAggregatorSwitches():
    start = number_of_endHosts + number_of_edge_switches
    end = number_of_edge_switches + number_of_endHosts + number_of_aggregator_switches
    for aggregatorSwitchIndex in range(start, end):
        aggregatorSwitchs.append({'node': "n"+ str(aggregatorSwitchIndex), 'type': "aggregatorSwitch"})
    return

def generateCoreSwitchs():
    start = number_of_edge_switches + number_of_endHosts + number_of_aggregator_switches
    end =  start + number_of_core_switches
    for coreSwitchIndex in range(start, end):
        coreSwitches.append({'node': "n"+ str(coreSwitchIndex), 'type': "coreSwitch"})
    return


def generateEndNodeToEdgesSwitchLinks():
    count = 1
    edgeSwitchIndex = 0
    for endHost in endHosts:
        endHostToEdgeSwitchLinks.append({'start': endHost['node'], 'end': edgeSwitchs[edgeSwitchIndex]['node'] })
        if (count%2 == 0):
            edgeSwitchIndex = edgeSwitchIndex + 1
        count += 1
    return

def generateEdgesSwitchToAggregatorLinks():
    count = 1
    aggregatorSwitchIndex = 0
    for edgeSwitch in edgeSwitchs:
        edgeSwitchToAggregatorLink.append({'start': edgeSwitch['node'], 'end': aggregatorSwitchs[aggregatorSwitchIndex]['node'] })
        if (count%2 == 0):
            aggregatorSwitchIndex = aggregatorSwitchIndex + 1
        count += 1
    return

def generateAggregatorSwitchToCoreSwitchLinks():
    count = 1
    coreSwitchIndex = 0
    for aggregatorSwitch in aggregatorSwitchs:
        aggregatorSwitchToCoreSwitchLink.append({'start': aggregatorSwitch['node'], 'end': coreSwitches[coreSwitchIndex]['node'] })
        if (count%2 == 0):
            coreSwitchIndex = coreSwitchIndex + 1
        count += 1
    return

def main():
    """
    Defines the main method for the program
    """
    # generate the nodes
    generateEndHosts()
    print "Endhost generation complete"
    pprint.pprint(endHosts)

    generateEdgeSwitches()
    print "edgeSwitchs generation complete"
    pprint.pprint(edgeSwitchs)

    generateAggregatorSwitches()
    print "aggregatorSwitchs generation complete"
    pprint.pprint(aggregatorSwitchs)
 
    generateCoreSwitchs()
    print "coreSwitches generation complete"
    pprint.pprint(coreSwitches)

    # generate the links
    generateEndNodeToEdgesSwitchLinks()
    print "EndNode To Edges Switch Links generated"
    pprint.pprint(endHostToEdgeSwitchLinks)

    generateEdgesSwitchToAggregatorLinks()
    print "Edge Switch To Aggregator Switch Links generated"
    pprint.pprint(edgeSwitchToAggregatorLink)

    generateAggregatorSwitchToCoreSwitchLinks()
    print "Aggregator Switch To Core Switch Links generated"
    pprint.pprint(aggregatorSwitchToCoreSwitchLink)
    return

if __name__ == '__main__':
    main()
