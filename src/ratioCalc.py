import subprocess


def getNumPackets(trafficType, src, dst, flowId):
    """
    greps the number of lines in out nam
    which are of given trafficType and counts their lines
    """
    if trafficType == "ping":
        command = "grep -E \"^r.*ping.*\" out.tr | cut -d ' ' -f 10 | grep -E \"^([0-9]|10|11|12|13|14|15)\..*\" -c"
        proc = subprocess.Popen([command], stdout=subprocess.PIPE, shell=True)
    elif trafficType == "tcp":
        regexString = "\"^r.*\ " + dst + "\ .*tcp.*" + flowId + "\ " + src + ".*\""
        proc = subprocess.Popen(["grep -c -E " + regexString + " out.tr"],
                                stdout=subprocess.PIPE, shell=True)
    else:
        # dht
        command = "grep -E \"^r.*esdndht.*\" out.tr | cut -d ' ' -f 10 | grep -E \"^([0-9]|10|11|12|13|14|15)\..*\" -c"
        proc = subprocess.Popen([command], stdout=subprocess.PIPE, shell=True)
    (out, err) = proc.communicate()
    return float(out)


def calcRatios():

    dht = getNumPackets("esdndht", None, None, None)
    ping = getNumPackets("ping", None, None, None)
    print dht
    print ping

    dhtPackets = dht
    pingPackets = ping
    tcpPackets = 0

    for t in getflowSrcDst():
        src = t[0]
        dst = t[1]
        fid = t[4]
        size = t[3]
        tcp = getNumPackets("tcp", src, dst, fid)
        tcpPackets += tcp
        print "TCP packets for flow:" + str((src, dst)) + " " + str(tcp) + " actual::" + str(size)
        # print "dht packets for flow:" + str((src, dst)) + " " + str(dht)
        # print "ping packets for flow:" + str((src, dst)) + " " + str(ping)
        print "===================="

    print "total tcpPackets  :: ", tcpPackets
    print "total dhtPackets  :: ", dhtPackets
    print "total pingPackets :: ", pingPackets

    print ""

    tcpBytes   = (tcpPackets * 1040.0)
    pingBytes  = (pingPackets * 64.0)
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

    assert(sum, 100)
    print "TCP to PING Bytes ratio:: ", float(tcpBytes / pingBytes)


def getflowSrcDst():
    proc = subprocess.Popen(["grep ^src: screen_dump.txt"], stdout=subprocess.PIPE, shell=True)
    (out, err) = proc.communicate()
    lines = out.split("\n")
    lines = filter(lambda x: not (x is ''), lines)
    splitLines = map(lambda x: x.split(),
                     lines)
    tuples = map(lambda x: (x[1][:-1], x[3][:-1], x[5], x[7], x[9]),
                 splitLines)
    return tuples

# calcRatios()
# import pprint
# pprint.pprint(getflowSrcDst())
# pprint.pprint(getNumPackets("tcp", "0", "10", "0"))

calcRatios()
