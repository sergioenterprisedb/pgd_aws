#!/bin/bash

#
# Execution in one of the aws vms (dns rsolution):
# watch -c bash ./architecture.sh
#

. ./monitoring_config.sh

#File doesn't exists
if [ ! -f "/tmp/nodes.txt" ] || [ ! -f "/tmp/groups.txt" ]; then
  echo "Loading data..."
  pgd show-nodes > /tmp/nodes_tmp.txt
  pgd show-groups > /tmp/groups_tmp.txt
fi
#if [ -f "/tmp/nodes.txt" ]; then
  if [ $( lsof /tmp/nodes_tmp.txt | wc -l ) -eq 0 ]; then
    cp /tmp/nodes_tmp.txt /tmp/nodes.txt
    #rm -f /tmp/nodes.txt
    nohup pgd show-nodes > /tmp/nodes_tmp.txt 2> /dev/null &
  fi
  if [ $( lsof /tmp/groups_tmp.txt | wc -l ) -eq 0 ]; then
    cp /tmp/groups_tmp.txt /tmp/groups.txt
    #rm -f /tmp/groups.txt
    nohup pgd show-groups > /tmp/groups_tmp.txt 2>/dev/null &
  fi
#fi
#pgd show-nodes > /tmp/nodes.txt 
#pgd show-groups > /tmp/groups.txt

export LC_ALL=en_US.UTF-8

green="\e[32m"
red="\e[31m"
yellow="\e[33m"
blue='\e[34m'
cyan='\e[36m'
reset="\e[0m" #reset color
location="\e[36m\e[4m"

export PGPASSWORD=`cat ../password.txt`
#if [ -z "$PGPASSWORD" ]
#then
#  export PGPASSWORD=`tpaexec show-password ~/sro-pgdcluster-mr enterprisedb`
#fi

function write_leader()
{
  # Write leader
  #pgd show-groups > /tmp/groups.txt
  _loc_a_writeleader=`grep $loc_a_group /tmp/groups.txt | awk '{print $7}'`
  _loc_b_writeleader=`grep $loc_b_group /tmp/groups.txt | awk '{print $7}'`
  loc_a_writeleader=`s $_loc_a_writeleader 15`
  loc_b_writeleader=`s $_loc_b_writeleader 15`

  # Location A
  # primary_loc_a=`psql -h $loc_a_node1,$loc_a_node2 -p 6432 -U enterprisedb -d bdrdb -t -c "select write_lead from bdr.node_group_routing_summary;" >/tmp/result 2>&1`
  # if [ $? -ne 0 ]; then
  #   rm -f /tmp/result
  #   primary_loc_a="KO"
  # else
  #   primary_loc_a=`cat /tmp/result`
  #   rm -f /tmp/result
  # fi

  # # Location B
  # primary_loc_b=`psql -h $loc_b_node1,$loc_b_node2 -p 6432 -U enterprisedb -d bdrdb -t -c "select write_lead from bdr.node_group_routing_summary;" >/tmp/result 2>&1`
  # if [ $? -ne 0 ]; then
  #   rm -f /tmp/result
  #   primary_loc_b="KO"
  # else
  #   primary_loc_b=`cat /tmp/result`
  #   rm -f /tmp/result
  # fi

  # Write leaders
  # Format 20 columns
  l_loc_a_node1=`s "${loc_a_node1}" 17`
  l_loc_a_node2=`s "${loc_a_node2}" 17`
  l_loc_b_node1=`s "${loc_b_node1}" 17`
  l_loc_b_node2=`s "${loc_b_node2}" 17`

  # Location A
  if [ $_loc_a_writeleader == "$loc_a_node1" ]; then
    loc_a_pgd1_writeleader="${green}-> ${l_loc_a_node1}${reset}"
  else
    loc_a_pgd1_writeleader="${yellow}-> ${l_loc_a_node1}${reset}"
  fi

  if [ $_loc_a_writeleader == "$loc_a_node2" ]; then
    loc_a_pgd2_writeleader="${green}-> $l_loc_a_node2${reset}"
  else
    loc_a_pgd2_writeleader="${yellow}-> $l_loc_a_node2${reset}"
  fi
  
  # Location B
  if [ $_loc_b_writeleader == "$loc_b_node1" ]; then
    loc_b_pgd1_writeleader="${green}-> $l_loc_b_node1${reset}"
  else
    loc_b_pgd1_writeleader="${yellow}-> $l_loc_b_node1${reset}"
  fi

  if [ $_loc_b_writeleader == "$loc_b_node2" ]; then
    loc_b_pgd2_writeleader="${green}-> $l_loc_b_node2${reset}"
  else
    loc_b_pgd2_writeleader="${yellow}-> $l_loc_b_node2${reset}"
  fi
}

function postgres()
{
  # Postgres status
  #pg_pgd1_uswest2=`ssh -F ~/sro-pgdcluster-mr/ssh_config pgd1-uswest2  "systemctl status postgres | grep Active" | awk '{print $2}'`
  #pg_pgd2_uswest2=`ssh -F ~/sro-pgdcluster-mr/ssh_config pgd2-uswest2  "systemctl status postgres | grep Active" | awk '{print $2}'`
  #pg_pgd1_useast2=`ssh -F ~/sro-pgdcluster-mr/ssh_config pgd1-useast2  "systemctl status postgres | grep Active" | awk '{print $2}'`
  #pg_pgd1_useast2=`ssh -F ~/sro-pgdcluster-mr/ssh_config pgd2-useast2  "systemctl status postgres | grep Active" | awk '{print $2}'`

  #pgd show-nodes > /tmp/nodes.txt
  pg_pgd1_loc_a=`grep $loc_a_node1 /tmp/nodes.txt | awk '{print $7}'`
  pg_pgd2_loc_a=`grep $loc_a_node2 /tmp/nodes.txt | awk '{print $7}'`
  pg_pgd3_loc_a=`grep $loc_a_node3 /tmp/nodes.txt | awk '{print $7}'`

  pg_pgd1_loc_b=`grep $loc_b_node1 /tmp/nodes.txt | awk '{print $7}'`
  pg_pgd2_loc_b=`grep $loc_b_node2 /tmp/nodes.txt | awk '{print $7}'`
  pg_pgd3_loc_b=`grep $loc_b_node3 /tmp/nodes.txt | awk '{print $7}'`

  pg_pgd1_loc_c=`grep $loc_c_node1 /tmp/nodes.txt | awk '{print $7}'`

  # Location A
  if [ $pg_pgd1_loc_a == "Unreachable" ] ; then
    loc_a_pgd1="${red}PGD A1${reset}"
  else
    loc_a_pgd1="${green}PGD A1${reset}"
  fi

  if [ $pg_pgd2_loc_a == "Unreachable" ] ; then
    loc_a_pgd2="${red}PGD A2${reset}"
  else
    loc_a_pgd2="${green}PGD A2${reset}"
  fi

  if [ $pg_pgd3_loc_a == "Unreachable" ] ; then
    loc_a_pgd3="${red}PGD A3${reset}"
  else
    loc_a_pgd3="${green}PGD A3${reset}"
  fi

  # Location B
  if [ $pg_pgd1_loc_b == "Unreachable" ] ; then
    loc_b_pgd1="${red}PGD B1${reset}"
  else
    loc_b_pgd1="${green}PGD B2${reset}"
  fi

  if [ $pg_pgd2_loc_b == "Unreachable" ] ; then
    loc_b_pgd2="${red}PGD B2${reset}"
  else
    loc_b_pgd2="${green}PGD B2${reset}"
  fi

  if [ $pg_pgd3_loc_b == "Unreachable" ] ; then
    loc_b_pgd3="${red}PGD B3${reset}"
  else
    loc_b_pgd3="${green}PGD B3${reset}"
  fi

  # Location C
  if [ $pg_pgd1_loc_c == "Unreachable" ] ; then
    loc_c_pgd1="${red}PGD C1${reset}"
  else
    loc_c_pgd1="${green}PGD C1${reset}"
  fi
}

function pgd_proxy()
{
  
  if [ $architecture = "aws" ]; then
    # PGD Proxy
    psql -h $loc_a_node1 -p 6432 bdrdb -c "select version()" > /dev/null 2>&1
    loc_a_proxy_pgd1=$?
    psql -h $loc_a_node2 -p 6432 bdrdb -c "select version()" > /dev/null 2>&1
    loc_a_proxy_pgd2=$?
    psql -h $loc_b_node1 -p 6432 bdrdb -c "select version()" > /dev/null 2>&1
    loc_b_proxy_pgd1=$?
    psql -h $loc_b_node2 -p 6432 bdrdb -c "select version()" > /dev/null 2>&1
    loc_b_proxy_pgd2=$?
  fi

  if [ $loc_a_proxy_pgd1 == 0 ] ; then
    loc_a_proxy_pgd1="${green}PGD-Proxy${reset}"
  else
    loc_a_proxy_pgd1="${red}PGD-Proxy${reset}"
  fi

  if [ $loc_a_proxy_pgd2 == 0 ] ; then
    loc_a_proxy_pgd2="${green}PGD-Proxy${reset}"
  else
    loc_a_roxy_pgd2="${red}PGD-Proxy${reset}"
  fi

  if [ $loc_b_proxy_pgd1 == 0 ] ; then
    loc_b_proxy_pgd1="${green}PGD-Proxy${reset}"
  else
    loc_b_proxy_pgd1="${red}PGD-Proxy${reset}"
  fi

  if [ $loc_b_proxy_pgd2 == 0 ] ; then
    loc_b_proxy_pgd2="${green}PGD-Proxy${reset}"
  else
    loc_b_proxy_pgd2="${red}PGD-Proxy${reset}"
  fi


  # pgd-proxy
  #   Active: active (running) since Thu 2023-12-14 12:08:36 UTC; 1min 0s ago
  #pgd1_proxy_useast2=`systemctl status pgd-proxy.service | grep Active | grep running | wc -l`
}

dashboard()
{
  export LC_ALL=en_US.UTF-8

  printf "********************************************************************\n"
  printf "*** Sergio PGD monitoring tool (`date`) ***\n"
  printf "********************************************************************\n"
  printf "\n"
  printf "           ┌─────────────────────────────────────┐                ┌─────────────────────────────────────┐\n"
  printf "           │ ${location}Location A${reset}: ${loc_a_region}    │                │ ${location}Location B${reset}: ${loc_b_region}    │\n"
  printf "           │             ${loc_a_name}              │                │             ${loc_b_name}              │\n"
  printf "           │ ┌─ AZ1 ─────────────────────────┐   │                │ ┌- AZ1 ─────────────────────────┐   │\n"
  printf "           │ │ ${loc_a_pgd1} ${loc_a_pgd1_writeleader}   │   │                │ │ ${loc_b_pgd1} ${loc_b_pgd1_writeleader}   │   │\n"
  printf "           │ │ ${loc_a_proxy_pgd1}                     │   │                │ │ ${loc_b_proxy_pgd1}                     │   │\n"
  printf "           │ │ ${cyan}Write leader:${reset} ${loc_a_writeleader} │   │                │ │ ${cyan}Write leader:${reset} ${loc_b_writeleader} │   │\n"
  printf "           │ └───────────────────────────────┘   │                │ └───────────────────────────────┘   │\n"
  printf "           │ ┌─ AZ2 ─────────────────────────┐   │◄──────────────►│ ┌─ AZ2 ─────────────────────────┐   │\n"
  printf "           │ │ ${loc_a_pgd2} ${loc_a_pgd2_writeleader}   │   │                │ │ ${loc_b_pgd2} ${loc_b_pgd2_writeleader}   │   │\n"
  printf "           │ │ ${loc_a_proxy_pgd2}                     │   │                │ │ ${loc_b_proxy_pgd2}                     │   │\n"
  printf "           │ │ ${cyan}Write leader:${reset} ${loc_a_writeleader} │   │                │ │ ${cyan}Write leader:${reset} ${loc_b_writeleader} │   │\n"
  printf "           │ └───────────────────────────────┘   │                │ └───────────────────────────────┘   │\n"
  printf "           │ ┌─ AZ3 ─────────────────────────┐   │                │ ┌- AZ3 ─────────────────────────┐   │\n"
  printf "           │ │ ${loc_a_pgd3}                        │   │                │ │ ${loc_b_pgd3}                        │   │\n"
  printf "           │ │ ${loc_a_node3}                │   │                │ │ ${loc_b_node3}                │   │\n"
  printf "           │ └───────────────────────────────┘   │                │ └───────────────────────────────┘   │\n"
  printf "           └─────────────────────────────────────┘                └─────────────────────────────────────┘\n"
  printf "                             ▲                                                      ▲\n"
  printf "                             │                                                      │\n"
  printf "                             │        ┌─────────────────────────────────────┐       │\n"
  printf "                             │        │ ${location}Location C${reset}: ${loc_c_region}    │       │\n"
  printf "                             │        │             ${loc_c_name}              │       │\n"
  printf "                             └───────►│ ┌─ AZ1 ─────────────────────────┐   │◄──────┘\n"
  printf "                                      │ │ ${loc_c_node1}          │   │\n"
  printf "                                      │ └───────────────────────────────┘   │\n"
  printf "                                      └─────────────────────────────────────┘\n"

  printf " \n"
  printf " \n"
  printf "**********************\n"
  printf "*** Monitoring Lag ***\n"
  printf "**********************\n"
  printf " \n"
}

lag_dashboard()
{
  psql -h $loc_b_node1,$loc_b_node2,$loc_a_node1,$loc_a_node2 \
      -p 6432 bdrdb \
      -P footer=off \
      -c "SELECT target_name, client_addr, sent_lsn, replay_lsn, replay_lag, replay_lag_bytes, replay_lag_size FROM bdr.node_slots;"
}

pgd_env()
{
  #In progress
  pgd show-nodes > /tmp/nodes.txt

  #https://www.cyberciti.biz/faq/bash-for-loop-array/
  #data nodes
  while read c_node c_nodeid c_group c_type c_current c_target c_status c_seqid; do
    a_node+=($c_node)
    a_nodeid+=($c_nodeid)
    a_group+=($c_group)
    a_type+=($c_type)
    a_current+=($c_current)
    a_target+=($c_target)
    a_status+=($c_status)
    a_seqid+=($c_seqid)
  done < <(sed 's/;/\t/g' /tmp/nodes.txt)
  #done < <(tail -n +3 /tmp/nodes.txt)
  #echo ${ar1[1]}
  #echo ${ar1[2]}
  #echo ${ar2[4]}
  i=0
  echo "***"
  echo ${a_type[@]}
  echo "***"
  echo ${a_type[3]}
  echo "***"

  for key in "${a_type[@]}"
  do
    echo "Type $i: $key"
    ((i++))
  done
}

#echo `date +"%T.%N"`
write_leader
#echo `date +"%T.%N"`
postgres
#echo `date +"%T.%N"`
pgd_proxy
#echo `date +"%T.%N"`
dashboard
#echo `date +"%T.%N"`
lag_dashboard
