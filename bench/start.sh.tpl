#!/bin/bash

# N graphite_host graphite_port time_limit tdir
./mbench.py 1000 ${graphite_host} 2003 3600 $1 > mbench.log 2>&1 &
