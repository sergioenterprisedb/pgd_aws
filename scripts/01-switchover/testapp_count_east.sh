while true;
do
  psql \
    -h pgd1-useast2,pgd2-useast2,pgd1-uswest2,pgd2-uswest2 \
    -U enterprisedb \
    -p 6432 \
    -d bdrdb \
    -f pgd-demo-app-count.sql;
  date; 
done
