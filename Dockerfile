FROM ubuntu

ENV TZ=Asia/Shanghai 

RUN apt update && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && \
    apt install -y cron apt-mirror tzdata && \
    apt autoremove -y && \
    apt clean && \
    rm -rf /var/lib/apt/lists* /tmp/* /var/tmp/* 



RUN echo "0 18 * * * root /usr/bin/apt-mirror > /var/spool/apt-mirror/cron.log" >> /etc/cron.d/apt-mirror

VOLUME ["/var/spool/apt-mirror"]

COPY mirror.list /etc/apt/mirror.list

CMD ["cron", "-f"]