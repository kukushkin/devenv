FROM ruby-dev:latest

RUN curl -fsSL https://packagecloud.io/84codes/crystal/gpgkey | gpg --dearmor > /etc/apt/trusted.gpg.d/84codes_crystal.gpg
# RUN . /etc/os-release && echo "$ID $VERSION_CODENAME"
# RUN echo "deb https://packagecloud.io/84codes/crystal/ubuntu jammy main" | cat > /etc/apt/sources.list.d/84codes_crystal.list
RUN . /etc/os-release && echo "deb https://packagecloud.io/84codes/crystal/$ID $VERSION_CODENAME main" | cat > /etc/apt/sources.list.d/84codes_crystal.list
RUN cat /etc/apt/sources.list.d/84codes_crystal.list
RUN apt-get update -qy \
  && apt-get install -qy crystal
