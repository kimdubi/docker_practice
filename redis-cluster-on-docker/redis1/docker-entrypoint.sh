#!/bin/sh
set -e

# MASTER
#sed -i "s/bind 127.0.0.1/bind 0.0.0.0/g" /engn001/redis-stable/redis_6001.conf
sed -i "s/6379/$PORT/g" /engn001/redis-stable/redis_6001.conf
sed -i "s/requirepass foobared/requirepass $REQUIREPASS/g" /engn001/redis-stable/redis_6001.conf
sed -i "s/masterauth <master-password>/masterauth $REQUIREPASS/g" /engn001/redis-stable/redis_6001.conf
sed -i "s/redis.log/redis_$PORT/g" /engn001/redis-stable/redis_6001.conf
sed -i "s/redis.pid/redis_$PORT.pid/g" /engn001/redis-stable/redis_6001.conf

# CLUSTER
sed -i "s/#cluster-enabled yes/cluster-enabled yes/g" /engn001/redis-stable/redis_6001.conf
sed -i "s/#cluster-config-file nodes-6379.conf/cluster-config-file nodes_$PORT.conf/g" /engn001/redis-stable/redis_6001.conf
sed -i "s/#cluster-node-timeout 15000/cluster-node-timeout 5000/g" /engn001/redis-stable/redis_6001.conf

cp /engn001/redis-stable/redis_6001.conf /engn001/redis-stable/data

redis-server /engn001/redis-stable/redis_6001.conf &
sleep 10

printf 'yes\n' | redis-cli -p 6001 -a qhdks123 --cluster create 172.19.0.20:6001 172.19.0.21:6001 172.19.0.22:6001 172.19.0.25:6001 172.19.0.23:6001 172.19.0.24:6001 --cluster-replicas 1 &
sleep 10


/bin/bash
