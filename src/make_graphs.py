import commands
import sys


def check_clean_up(cleanup_result):
    # print clean up check
    if int(cleanup_result[0]) == 0:
        print "Clean up suceeded"
    elif int(cleanup_result[0]) == 256:
        print "No files to clean up"
    else:
        print "Clean up failed"
        print cleanup_result

# Do clean up
cleanup_result = commands.getstatusoutput('rm $(find . -name \*.ps)')
print "Cleaning up old ps files"
check_clean_up(cleanup_result)

cleanup_result = commands.getstatusoutput('rm $(find . -name \*.gp)')
print "Cleaning up old gp files"
check_clean_up(cleanup_result)

# cleanup_result = commands.getstatusoutput('rm $(find . -name qmon.\*)')
# print "Cleaning up old qmon files"
# check_clean_up(cleanup_result)

# generate the gnuplot files
gp_files = commands.getstatusoutput('python createUtilGraph.py')
if int(gp_files[0]) == 0:
    print "gnuplot files created"
else:
    print gp_files

# generate the ps files
ps_files = commands.getstatusoutput('gnuplot $(find . -name \*.gp)')
if int(ps_files[0]) == 0:
    print "ps files created"
else:
    print ps_files

print "Exiting"
sys.exit(0)
