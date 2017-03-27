# Build:
# docker build -t mingc/mean-dev .
#
# Run:
# docker run -it --rm mingc/mean-dev bash
#

FROM ubuntu:16.04

MAINTAINER Ming Chen

ENV LANG en_US.UTF-8
RUN locale-gen $LANG

COPY start.sh /start.sh

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        curl \
        git \
        net-tools \
        python \
        vim \
        wget && \

    # Install mongodb
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927 && \
    echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.2.list && \
    apt-get update && \
    apt-get install -y mongodb-org && \

    # Install redis
    wget http://download.redis.io/releases/redis-3.2.5.tar.gz && \
    tar xvzf redis-3.2.5.tar.gz && \
    cd redis-3.2.5 && \
    make && \
    make install && \
    cd .. && \
    rm -fr redis-3.2.5 redis-3.2.5.tar.gz && \

    # Install nodejs, npm etc.
    # https://github.com/nodesource/distributions
    curl -sL -k https://deb.nodesource.com/setup_7.x | bash -  && \
    apt-get install -yq nodejs && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    npm install -g npm && \
    npm install --quiet -g jshint node-gyp gulp bower yo mocha karma-cli pm2 && \
    npm cache clean
