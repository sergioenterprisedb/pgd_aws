#!/bin/bash

########################################################################################################################
# Author:      Sergio Romera                                                                                           #
# Date:        15/01/2024                                                                                              #
# Subject:     Provision all the AWS infrastructure to deploy EDB Postgres Distributed (PGD)                           #
# Description: This is the architecture that will be deployed                                                          #
#           ┌─────────────────────────────────────┐                ┌─────────────────────────────────────┐             #
#           │ Location A: us-west-2               │                │ Location B: us-east-2               │             #
#           │             Oregon                  │                │             Ohio                    │             #
#           │ ┌─ AZ1 ─────────────────────────┐   │                │ ┌- AZ1 ─────────────────────────┐   │             #
#           │ │ PGD A1 -> pgd1-uswest2        │   │                │ │ PGD B2 -> pgd1-useast2        │   │             #
#           │ │ PGD-Proxy                     │   │                │ │ PGD-Proxy                     │   │             #
#           │ │ Write leader: pgd1-uswest2    │   │                │ │ Write leader: pgd1-useast2    │   │             #
#           │ └───────────────────────────────┘   │                │ └───────────────────────────────┘   │             #
#           │ ┌─ AZ2 ─────────────────────────┐   │◄──────────────►│ ┌─ AZ2 ─────────────────────────┐   │             #
#           │ │ PGD A2 -> pgd2-uswest2        │   │                │ │ PGD B2 -> pgd2-useast2        │   │             #
#           │ │ PGD-Proxy                     │   │                │ │ PGD-Proxy                     │   │             #
#           │ │ Write leader: pgd1-uswest2    │   │                │ │ Write leader: pgd1-useast2    │   │             #
#           │ └───────────────────────────────┘   │                │ └───────────────────────────────┘   │             #
#           │ ┌─ AZ3 ─────────────────────────┐   │                │ ┌- AZ3 ─────────────────────────┐   │             #
#           │ │ PGD A3                        │   │                │ │ PGD B3                        │   │             #
#           │ │ barman-uswest2                │   │                │ │ barman-useast2                │   │             #
#           │ └───────────────────────────────┘   │                │ └───────────────────────────────┘   │             #
#           └─────────────────────────────────────┘                └─────────────────────────────────────┘             #
#                             ▲                                                      ▲                                 #
#                             │                                                      │                                 #
#                             │        ┌─────────────────────────────────────┐       │                                 #
#                             │        │ Location C: us-east-1               │       │                                 #
#                             │        │             Virginia                │       │                                 #
#                             └───────►│ ┌─ AZ1 ─────────────────────────┐   │◄──────┘                                 #
#                                      │ │ witness-useast1               │   │                                         #
#                                      │ └───────────────────────────────┘   │                                         #
#                                      └─────────────────────────────────────┘                                         #
#                                                                                                                      #
########################################################################################################################

./00-pgd-network-configuration.sh
./01-create_peering_connections.sh
./02-create_routes.sh
./03-configure_and_provision_pgd_multiregion_aws.sh
./04-subnet-association.sh
./05_deploy_pgd_multiregion_aws.sh

