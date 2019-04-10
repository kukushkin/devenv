FROM dev:latest

RUN apt-add-repository ppa:brightbox/ruby-ng
RUN apt-get update -qy && apt-get install -qy ruby2.4 ruby2.4-dev libpq-dev libsqlite3-dev
RUN gem i bundle pry rake rspec

ADD bash.d/* /root/bash.d/

