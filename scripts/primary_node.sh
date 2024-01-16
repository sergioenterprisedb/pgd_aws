#!/bin/bash

#export primary=`psql -h node1,node2,node3 -p 6432 -t bdrdb -c 'select write_lead from bdr.node_group_routing_summary;'`
export primary=`psql bdrdb -t -c 'select write_lead from bdr.node_group_routing_summary;'`

echo $primary
