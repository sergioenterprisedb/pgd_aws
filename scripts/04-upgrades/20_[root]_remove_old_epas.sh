#!/bin/bash

if [ `whoami` != "root" ]
then
  printf "You must execute this as root\n"
  exit
fi

sudo ~enterprisedb/delete_old_cluster.sh

