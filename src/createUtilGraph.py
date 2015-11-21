import math
import pprint
import random
import os
import commands

# function for creating graphs from qmon.util* files
def createGraphs():
    status, output = commands.getstatusoutput("find . -name qmon.util\*");
    mylist = output.split("\n");
      
    for filename in mylist:
        filename = filename[2:]
        plotter = open("qmon-util-plotter"+filename[9:]+".gp", 'w');

        plotter.write("set terminal postscript color eps enhanced\n");
        plotter.write("set output \"plot-qmon-util"+filename[9:]+".ps\"\n");

        plotter.write("set title \"Plot of Link Utilization\"\nset ylabel \"Link Utilization\"\nset xlabel \"Number of RTTs\" # 0,0.5\"\n")
        # removed comma from line end
        plotter.write("plot \""+filename+"\" title \"link utilization\" with lines");
    return

createGraphs();
