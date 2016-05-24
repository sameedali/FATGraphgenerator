#============================= throughput.awk ========================

BEGIN {
    recv=0;
    startTime = 1;
    time = 0;
    packet_size = 1040;
    time_interval = 0.001;
    # FS = '\ '
}

#body
{
    # fields
    event = $1
    time = $2
    sendNodeid = $3
    recvNodeid = $4
    pktType = $5
    pktSize = $6
    fid = $8
    flowSrc = $9
    flowDst = $10


    # break and contnue
    if (time > startTime) {
        print startTime, (packet_size * pktsRcvd * 8.0)/1000;
        startTime += time_interval;
        pktsRcvd=0;
    }

    #============= CALCULATE throughput=================
    if (( event == "r") && ( pktType == "tcp" ) && ( recvNodeid == "8" ))
    {
        pktsRcvd++;
    }

}
#body


END {
    ;
}
#============================= Ends ============================
