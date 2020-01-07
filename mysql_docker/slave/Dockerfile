FROM mysql_image:slave
MAINTAINER kimdubi
USER root
RUN echo "slave" > slave.txt
ADD my.cnf /engn001/mysql/
ADD docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
