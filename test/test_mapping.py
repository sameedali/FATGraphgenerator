import re

# Define this var
number_of_items_in_division = 2

##############################
#     DO NOT EDIT BELOW      #
##############################


def start():
    """
    This program tests the file mapping for redundacnies.
    """
    lineCounter = 0
    containedLinks = []
    link_counter = 0

    file_read = open('mapping.txt', 'r')
    line = file_read.readline()

    last_sum = None

    while line != "":
        strArr = re.split(' ', line)
        for link in strArr:
            if ':' not in link:
                if int(link) in containedLinks:
                    print "repeated link", link
                    return 1
                else:
                    # print 'adding ', int(link)
                    containedLinks.append(int(link))
                link_counter += 1
        lineCounter += 1
        line = file_read.readline()
        if (lineCounter % number_of_items_in_division) == 0:
            containedLinks = []
            link_counter = 0

    print "Mapping has no duplicates\n"
    print "test sucessfull.",

    return 0

# start tests
start()
