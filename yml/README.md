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
...
PLAY RECAP ***************************************************************************************************
barman-useast2             : ok=369  changed=7    unreachable=0    failed=0    skipped=242  rescued=0    ignored=1
barman-uswest2             : ok=369  changed=7    unreachable=0    failed=0    skipped=242  rescued=0    ignored=1
localhost                  : ok=4    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
pgd1-useast2               : ok=376  changed=9    unreachable=0    failed=0    skipped=250  rescued=0    ignored=2
pgd1-uswest2               : ok=363  changed=9    unreachable=0    failed=0    skipped=251  rescued=0    ignored=1
pgd2-useast2               : ok=363  changed=9    unreachable=0    failed=0    skipped=251  rescued=0    ignored=1
pgd2-uswest2               : ok=383  changed=11   unreachable=0    failed=0    skipped=259  rescued=0    ignored=1
pgd3-useast2               : ok=397  changed=106  unreachable=0    failed=0    skipped=239  rescued=0    ignored=1
witness-useast1            : ok=346  changed=7    unreachable=0    failed=0    skipped=245  rescued=0    ignored=1


real	18m10.969s
user	4m47.197s
sys	2m2.030s

PLAY [Check for old repositories] ****************************************************************************

TASK [assert] ************************************************************************************************
ok: [pgd3-useast2 -> localhost] => {
    "changed": false,
    "msg": "All assertions passed"
}

PLAY RECAP ***************************************************************************************************
pgd3-useast2               : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

...
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