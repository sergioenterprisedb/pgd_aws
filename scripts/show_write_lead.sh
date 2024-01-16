#!/bin/bash
. ./config.sh

exe eval "psql -h node1,node2,node3 -p 6432 bdrdb -c 'select * from bdr.node_group_routing_summary;'"

primary=`psql -h node1,node2,node3 -p 6432 -t bdrdb -c 'select write_lead from bdr.node_group_routing_summary;'`
