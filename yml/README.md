# Files
## PGDNetwork.yml
- This file contain a network configuration for multiple PGD cluster deployments
## MRLR4DN-config.yml
- This file contain the Multi-Region with two data sub-groups and Local Routing (7 nodes total)
```
enterprisedb@pgd2-useast2:~ $ pgd show-version
Node            BDR Version Postgres Version
----            ----------- ----------------
barman-useast2  5.3.0       15.5.0 (Debian 15.5.0-1.buster)
barman-uswest2  5.3.0       15.5.0 (Debian 15.5.0-1.buster)
pgd1-useast2    5.3.0       15.5.0 (Debian 15.5.0-1.buster)
pgd1-uswest2    5.3.0       15.5.0 (Debian 15.5.0-1.buster)
pgd2-useast2    5.3.0       15.5.0 (Debian 15.5.0-1.buster)
pgd2-uswest2    5.3.0       15.5.0 (Debian 15.5.0-1.buster)
witness-useast1 5.3.0       15.5.0 (Debian 15.5.0-1.buster)
```
## MRLR4DN-config.new.node.yml
- This file will add a new node (node 20) to the current configuration with an EPAS 15.
```
enterprisedb@pgd2-useast2:~ $ pgd show-version
Node            BDR Version Postgres Version
----            ----------- ----------------
barman-useast2  5.3.0       15.5.0 (Debian 15.5.0-1.buster)
barman-uswest2  5.3.0       15.5.0 (Debian 15.5.0-1.buster)
pgd1-useast2    5.3.0       15.5.0 (Debian 15.5.0-1.buster)
pgd1-uswest2    5.3.0       15.5.0 (Debian 15.5.0-1.buster)
pgd2-useast2    5.3.0       15.5.0 (Debian 15.5.0-1.buster)
pgd2-uswest2    5.3.0       15.5.0 (Debian 15.5.0-1.buster)
pgd3-useast2    5.3.0       16.1.0 (Debian 16.1.0-1.buster)
witness-useast1 5.3.0       15.5.0 (Debian 15.5.0-1.buster)
```