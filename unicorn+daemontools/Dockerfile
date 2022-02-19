FROM ruby:2.7.4

RUN apt-get update -qq && apt-get install wget && apt-get install psmisc

WORKDIR /sample
COPY ["./src/Gemfile", "./"]

RUN gem install bundler --version 1.17.2

# See: http://cr.yp.to/daemontools/install.html
# See: http://cr.yp.to/daemontools/start.html
# See: http://thedjbway.b0llix.net/daemontools/installation.html
RUN mkdir -p /package && chmod 1755 /package && cd /package && \
    wget http://cr.yp.to/daemontools/daemontools-0.76.tar.gz && gunzip daemontools-0.76.tar && tar -xpf daemontools-0.76.tar && rm -f daemontools-0.76.tar && \
    cd admin/daemontools-0.76 && \
    wget http://thedjbway.b0llix.net/patches/daemontools-0.76.sigq12.patch && patch -t -p1 < ./daemontools-0.76.sigq12.patch && \
    wget http://qmail.org/moni.csi.hu/pub/glibc-2.3.1/daemontools-0.76.errno.patch && patch -t -p1 < ./daemontools-0.76.errno.patch && \
    package/install && \
    mkdir -p /service && chmod 755 /service

COPY ["./run", "/service/sample_server/run"]

RUN mkdir -p /service/sample_server/log && echo "#!/bin/sh\\nexec multilog t ./main" >> /service/sample_server/log/run && chmod 755 /service/sample_server/log/run && \
    chmod +t /service/sample_server

COPY . /sample
