FROM dev:latest

ENV PATH="/root/.asdf/shims:/root/.asdf/bin:${PATH}"

RUN apt-get update -qy \
  && apt-get install -qy libyaml-dev zlib1g-dev

RUN asdf plugin add nodejs
RUN asdf install nodejs 18.16.1
RUN asdf global nodejs 18.16.1

ADD bash.d/* /root/bash.d/
