#!/bin/sh
set -e

# MASTER
#sed -i "s/bind 127.0.0.1/bind 0.0.0.0/g" /engn001/redis-stable/redis_6001.conf
sed -i "s/6379/$PORT/g" /engn001/redis-stable/redis_6001.conf
sed -i "s/requirepass foobared/requirepass $REQUIREPASS/g" /engn001/redis-stable/redis_6001.conf
sed -i "s/masterauth <master-password>/masterauth $REQUIREPASS/g" /engn001/redis-stable/redis_6001.conf
sed -i "s/redis.log/redis_$PORT/g" /engn001/redis-stable/redis_6001.conf
sed -i "s/redis.pid/redis_$PORT.pid/g" /engn001/redis-stable/redis_6001.conf

# SENTINEL

sed -i "s/26379/$SENTINEL_PORT/g" /engn001/redis-stable/sentinel_7001.conf
sed -i "s/master_ip master_port quorum/$MASTER_HOST $MASTER_PORT $QUORUM/g" /engn001/redis-stable/sentinel_7001.conf
sed -i "s/foobared/$REQUIREPASS/g" /engn001/redis-stable/sentinel_7001.conf

cp /engn001/redis-stable/redis_6001.conf /engn001/redis-stable/data
cp /engn001/redis-stable/sentinel_7001.conf /engn001/redis-stable/data

redis-server /engn001/redis-stable/redis_6001.conf &
sleep 10
redis-sentinel /engn001/redis-stable/sentinel_7001.conf &
sleep 10


/bin/bash
