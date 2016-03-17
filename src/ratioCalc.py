import subprocess


def getNumPackets(trafficType):
    """ Greps the number of lines in out nam which are of given trafficType and counts their lines

    :trafficType: TODO
    :returns: TODO

    """
    proc = subprocess.Popen(["cat out.nam | grep " + trafficType + " | grep ^+ | wc -l"], stdout=subprocess.PIPE, shell=True)
    (out, err) = proc.communicate()
    return float(out)

tcpPackets  = getNumPackets("tcp")
dhtPackets  = getNumPackets("esdndht")
pingPackets = getNumPackets("ping")

print "tcpPackets  :: ", tcpPackets
print "dhtPackets  :: ", dhtPackets
print "pingPackets :: ", pingPackets

print ""

tcpBytes   = (tcpPackets * 1000.0)
pingBytes  = (64.0 * pingPackets)
dhtBytes   = (dhtPackets * 48.0)
totalBytes = tcpBytes + pingBytes + dhtBytes

print "tcpBytes  :: ", tcpBytes
print "dhtBytes  :: ", dhtBytes
print "pingBytes :: ", pingBytes

print ""

sum = 0
ratio      = (tcpBytes / totalBytes) * 100
print "TCP Ratio::", ratio
sum += ratio

ratio      = (pingBytes / totalBytes) * 100
print "ping Ratio::", ratio
sum += ratio

ratio      = (dhtBytes / totalBytes) * 100
print "esdndht Ratio::", ratio
sum += ratio

print ""
print "TCP to PING Bytes ratio:: ", float(tcpBytes / pingBytes)

# print "sum: ", sum

