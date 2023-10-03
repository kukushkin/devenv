FROM dev:latest

ENV PATH="/root/.asdf/shims:/root/.asdf/bin:${PATH}"

RUN apt-get update -qy \
  && apt-get install -qy libyaml-dev zlib1g-dev libmagickwand-dev imagemagick

RUN asdf plugin add ruby
RUN asdf install ruby latest
RUN asdf global ruby latest
RUN gem i bundler pry rake rspec

ADD bash.d/* /root/bash.d/
