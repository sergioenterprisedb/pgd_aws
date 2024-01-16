#!/bin/bash
. ./config.sh

exe eval "pgd show-groups" 
printf "\n"
exe eval "pgd show-nodes"
