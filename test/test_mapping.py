import re

# define k here
number_of_items_in_division = 16


def main():
    """
    this program tests the file mapping for redundacnies.
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
                else:
                    #print 'adding ', int(link)
                    containedLinks.append(int(link))
                link_counter += 1
        lineCounter += 1
        line = file_read.readline()
        if (lineCounter % number_of_items_in_division) == 0:
            containedLinks = []
            link_counter = 0

if __name__ == '__main__':
    main()
