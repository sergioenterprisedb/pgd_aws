#!/bin/sh

function s()
{
len=$2 ch=' '
STRING=$1
len_w=$(echo -n $STRING | wc -m)
printf $STRING
printf '%*s' "$(($len-$len_w))" | tr ' ' "$ch"
}

#AWS
pgd_config_file="."

#BigAnimal
#pgd_config_file=/vagrant/scripts/yaml/pgd-cli-config.yaml

# AWS
# ***
# Architecture: aws|biganimal
architecture=aws

# Location A
export loc_a_name=`s "Oregon" 10`
export loc_a_region=`s "us-west-2" 20`

export loc_a_node1=pgd1-uswest2
export loc_a_node2=pgd2-uswest2
export loc_a_node3=barman-uswest2

export loc_a_group=us_west_2_subgroup
export loc_a_writeleader=

# Location B
export loc_b_name=`s "Ohio" 10`
export loc_b_region=`s "us-east-2" 20`

export loc_b_node1=pgd1-useast2
export loc_b_node2=pgd2-useast2
export loc_b_node3=barman-useast2

export loc_b_group=us_east_2_subgroup
export loc_b_writeleader=

# Location C
export loc_c_name=`s "Virginia" 10`
export loc_c_region=`s "us-east-1" 20`
export loc_c_node1=`s "witness-useast1" 20`

# BigAnimal
# *********
