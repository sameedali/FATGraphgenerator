

# function for creating graphs from qmon.util* files
def createGraphs():
    status, output = commands.getstatusoutput("find . -name qmon.util\*");
    mylist = output.split("\n");
    
    plotter = open("qmon-util-plotter.gp", 'w');    
    for filename in mylist:
        filename = filename[2:]
        
        plotter.write("set terminal postscript color eps enhanced\n");
        plotter.write("set output \"plot-qmon-util"+filename[9:]+".ps\"\n");

        plotter.write("set title \"Plot of Link Utilization\"\nset ylabel \"Link Utilization\"\nset xlabel \"Number of RTTs\" # 0,0.5\"\nset xtics 10\n")
        plotter.write("plot \""+filename+"\" title \"link utilization\" with lines,");
        os.system("gnuplot qmon-util-plotter.gp");
    return

createGraphs();