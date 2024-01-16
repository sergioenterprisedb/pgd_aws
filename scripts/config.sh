#!/bin/bash

reset="\e[0m" #reset color
green="\e[32m"
red="\e[31m"
yellow="\e[33m"

#exe() { printf "${green}" ; echo "${@/eval/}" ; printf "${reset}\n" ; "$@" ; }
exe() { echo -e "${green}${@/eval/}${reset}\n" ; "$@" ; }
