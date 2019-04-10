FROM ubuntu:16.04

RUN apt-get update -qy \
  && apt-get install -qy software-properties-common build-essential git \
    net-tools iputils-ping

ADD bash.d /root/bash.d
RUN echo "for f in ~/bash.d/*.sh; do source \$f; done" >> /root/.bashrc

ADD idle /idle
RUN chmod a+x /idle

CMD ["/idle"]