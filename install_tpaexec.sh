#!/bin/sh

########################################################################################################################
# Author:      Sergio Romera                                                                                           #
# Date:        15/01/2024                                                                                              #
# Subject:     Install TPA in a VM                                                                                     #
# Description: Install TPA in a VM. This VM willpilot all the deployments in AWS                                       #
########################################################################################################################

# PGD 5.x
curl -1sLf "https://downloads.enterprisedb.com/$credentials/postgres_distributed/setup.rpm.sh" | sudo -E bash

# TPA
sudo yum -y install python39 python3-pip epel-release git openvpn patch
git clone https://github.com/enterprisedb/tpa.git ~/tpa

cat >> ~/.bash_profile <<EOF
export PATH=$PATH:$HOME/tpa/bin
EOF
source ~/.bash_profile

#yum -y install wget chrony tpaexec tpaexec-deps
# Config file: /etc/chrony.conf
systemctl enable --now chronyd
chronyc sources

cat >> ~/.bash_profile <<EOF
#export PATH=$PATH:/opt/EDB/TPA/bin
export EDB_SUBSCRIPTION_TOKEN=${credentials}
EOF
source ~/.bash_profile
