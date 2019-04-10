FROM ruby-dev:latest

# RUN apt-key adv --keyserver keys.gnupg.net --recv-keys 09617FD37CC06B54 \
#   && echo "deb https://dist.crystal-lang.org/apt crystal main" > /etc/apt/sources.list.d/crystal.list \
#   && apt-get update \
#   && apt-get install crystal

# ADD bash.d/* /root/bash.d/


RUN apt-get update -qy \
  && apt-get install curl \
  && curl -sL "https://keybase.io/crystal/pgp_keys.asc" | apt-key add \
  && echo "deb https://dist.crystal-lang.org/apt crystal main" > /etc/apt/sources.list.d/crystal.list \
  && apt-get update -qy \
  && apt-get install crystal
