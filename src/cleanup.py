import commands
import sys


def check_clean_up(cleanup_result):
    # print clean up check
    if int(cleanup_result[0]) == 0:
        print "clean up suceeded"
    elif int(cleanup_result[0]) == 256:
        print "no files to clean up"
    else:
        print "clean up failed"
        print cleanup_result

# Do clean up
cleanup_result = commands.getstatusoutput('rm $(find . -name \*.ps)')
print "cleaning up ps files"
check_clean_up(cleanup_result)

cleanup_result = commands.getstatusoutput('rm $(find . -name \*.gp)')
print "cleaning up gp files"
check_clean_up(cleanup_result)

cleanup_result = commands.getstatusoutput('rm $(find . -name qmon.\*)')
print "cleaning up qmon files"
check_clean_up(cleanup_result)

cleanup_result = commands.getstatusoutput('rm finish_times.txt')
print "cleaning up finish_times.txt file"
check_clean_up(cleanup_result)

print "exiting"
sys.exit(0)
