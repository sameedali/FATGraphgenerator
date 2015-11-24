import json
import pprint


def main():
    """TODO: Docstring for main.
    :returns: TODO
    """
    with open("logRaza") as read:
        jsonString = ""
        for line in read.readlines():
            jsonString += line
        _json = json.loads(jsonString)
        expectedList = []
        testList = []
        for item in _json:
            if(item["expected"] == "true"):
                expectedList.append(item)
            else:
                testList.append(item)
        for item in expectedList:
            for item0 in testList:
                if(item['agent'] == item0['agent']):
                    if(item['to'] != item0['to']):
                        print "Error"
                    if(item['from'] != item0['from']):
                        print "Error"
    return

if __name__ == '__main__':
    main()
