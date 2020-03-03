FROM ubuntu:18.04

LABEL maintainer="Soyl <soyl@live.cn>"
LABEL description="Docker container for Swift Vapor development"

# Install related packages
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y git curl wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Vapor setup
RUN /bin/bash -c "$(wget -qO- https://apt.vapor.sh)"

# Install vapor and clean
RUN apt-get update \
    && apt-get -y install swift vapor \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN vapor --help
