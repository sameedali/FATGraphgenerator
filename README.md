[![Build Status](https://travis-ci.org/sameedali/FATGraphgenerator.svg?branch=master)](https://travis-ci.org/sameedali/FATGraphgenerator)

FatTreeGenerator
=================

This repository contains an k array FAT tree topology generator.


A tcl representing the topology or the given k is geenrated on running the python FatTreeGenerator.py script



Example topology:

 
                   (CORE)
                  .     .
                .        .
              .           .
            (Agg)         (Agg)
          .     .           ...
         .       .
        (TOR)    (TOR)
       . .         .
      .   .       . .
     .     .     .   .
    (0)    (1)  (2)  (3) ...


Numbering for nodes starts at the end host and continues hierarchically i.e. End hosts then TOR then AGG then core switches.


Links are numbered similiarly.
