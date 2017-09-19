[![Build Status](https://travis-ci.org/sameedali/FATGraphgenerator.svg?branch=master)](https://travis-ci.org/sameedali/FATGraphgenerator)
[![Code Climate](https://codeclimate.com/github/sameedali/FATGraphgenerator/badges/gpa.svg)](https://codeclimate.com/github/sameedali/FATGraphgenerator)
[![Issue Count](https://codeclimate.com/github/sameedali/FATGraphgenerator/badges/issue_count.svg)](https://codeclimate.com/github/sameedali/FATGraphgenerator)


FatTreeGenerator
=================

This repository contains an k-ary FAT tree topology generator.


A tcl representing the topology or the given k is genrated on running the python FatTreeGenerator.py script



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


Links are numbered similiarly stating form the node 0.

## Summary of the files
> cleanup.py

Cleans up the result files in the out/ folder after an experiment.


> createUtilGraph.py

Creates the graphs from the result files in the out/ folder

> FatTreeGenerator.py

Generates the topology and moves the resulting files in the out/ folder


> make_graphs.py

A wrapper script which calls createUtilGraph.py


> ratioCalc.py

Calculates the ratio of data plane traffic (TCP) to control plane traffic (eSDN DHT, SDN controller polling traffic)


> tcl/

Holds the TCL templates and reference files.


# Running the Experiment
Edit the start of the `FatTreeGenerator.py` file to adjust the topology's K-value and the link bandwidths then run the file using the following command:
> python FatTreeGenerator.py

The result will be stored in the out/ folder.

Then run `ns2` on the generated TCL file **after** ajusting the parameters in `out.tcl`.

> cd ../out/

> vi out.tcl

> ns out.tcl

The simulation will produce its results in the `out/` directory.
