#!/bin/bash

psql -h pgd1-useast2,pgd2-useast2,pgd1-uswest2,pgd2-uswestt2 -p 6432 bdrdb -c \
"drop table if exists ping cascade;
CREATE TABLE ping (id SERIAL PRIMARY KEY, node TEXT, timestamp TEXT) ;"

