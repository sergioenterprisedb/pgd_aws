
#!/bin/bash

########################################################################################################################
# Author:      Sergio Romera                                                                                           #
# Date:        15/01/2024                                                                                              #
# Subject:     Deprovision infrastructure                                                                              #
# Description: Deprovision AWS infrastructure                                                                          #
########################################################################################################################

tpaexec deprovision ~/sro-pgdcluster-mr
sleep 5
./delete_peering.sh
sleep 5
tpaexec deprovision ~/sro-pgdnetwork
sleep 5
./delete_peering.sh
