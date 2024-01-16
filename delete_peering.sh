#!/bin/bash
########################################################################################################################
# Author:      Sergio Romera                                                                                           #
# Date:        15/01/2024                                                                                              #
# Subject:     Delete peering in AWS                                                                                   #
# Description: Delete peering between Ohio and Virginia, Virginia and Oregon and Oregon and Ohio                       #
########################################################################################################################

vpc_peering_connection_id=`cat /tmp/peering_oregon_ohio.txt | jq -r .VpcPeeringConnection.VpcPeeringConnectionId`
aws ec2 delete-vpc-peering-connection --vpc-peering-connection-id $vpc_peering_connection_id --region us-west-2

vpc_peering_connection_id=`cat /tmp/peering_oregon_virginia.txt | jq -r .VpcPeeringConnection.VpcPeeringConnectionId`
aws ec2 delete-vpc-peering-connection --vpc-peering-connection-id $vpc_peering_connection_id --region us-west-2

vpc_peering_connection_id=`cat /tmp/peering_ohio_virginia.txt | jq -r .VpcPeeringConnection.VpcPeeringConnectionId`
aws ec2 delete-vpc-peering-connection --vpc-peering-connection-id $vpc_peering_connection_id --region us-east-2
