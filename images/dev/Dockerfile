FROM ubuntu:22.04

# For installing tzdata in non-interactive mode
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -qy \
  && apt-get install -qy software-properties-common build-essential \
    openssl libssl-dev git net-tools iputils-ping curl


ADD bash.d /root/bash.d
RUN echo "for f in ~/bash.d/*.sh; do source \$f; done" >> /root/.bashrc

# install asdf
RUN git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.11.3
RUN echo ". \"$HOME/.asdf/asdf.sh\"" >> /root/.bashrc
RUN echo ". \"$HOME/.asdf/completions/asdf.bash\"" >> /root/.bashrc


ADD idle /idle
RUN chmod a+x /idle

CMD ["/idle"]
