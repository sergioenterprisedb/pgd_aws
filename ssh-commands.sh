
arr=("pgd1-uswest2     #Oregon" "pgd2-uswest2     #Oregon" "barman-uswest2   #Oregon" "pgd1-useast2     #Ohio" "pgd2-useast2     #Ohio" "barman-useast2   #Ohio" "witness-useast1  #Virginia")
i=0
len=${#arr[@]}
while [ $i -lt $len ];
do
  machine=${arr[$i]}
  echo "ssh -F ~/sro-pgdcluster-mr/ssh_config $machine"
  let i++  
done
