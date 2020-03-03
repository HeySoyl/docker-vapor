FROM vapor/swift:5.2

LABEL maintainer="Soyl <soyl@live.cn>"
LABEL description="Docker container for Swift Vapor development"

# Install related packages
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y git zlib1g-dev libsqlite3-dev \
    && git clone https://github.com/vapor/toolbox.git \
    && cd toolbox \
    && git checkout 18.0.0-beta.23 \
    && swift build -c release -- disable-sandbox \
    && mv .build/release/vapor /user/local/bin \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN vapor --help
