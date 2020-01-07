FROM kimdubi/redis_image:latest

MAINTAINER kimdubi 

USER root

ADD redis.conf /engn001/redis-stable/redis_6001.conf
ADD docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
