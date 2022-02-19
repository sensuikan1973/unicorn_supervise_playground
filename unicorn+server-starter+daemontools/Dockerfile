FROM ruby:2.6.2

WORKDIR /sample

RUN apt-get update -qq && apt-get install -y wget psmisc gcc perlbrew

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

RUN mkdir -p /service/sample_server/log && echo "#!/bin/sh\\nexec multilog t ./main" >> /service/sample_server/log/run && chmod 755 /service/sample_server/log/run && \
    chmod +t /service/sample_server

ENV PERLBREW_ROOT=/perl5
RUN perlbrew available && perlbrew init && \
    echo ". ${PERLBREW_ROOT}/etc/bashrc" >> ~/.bashrc && \
    mkdir -p ${PERLBREW_ROOT}/perl-5.16.1 && mkdir -p ${PERLBREW_ROOT}/dists && mkdir -p ${PERLBREW_ROOT}/build/perl-5.16.1 && \
    perlbrew install perl-5.16.1 --notest && \
    echo ". ${PERLBREW_ROOT}/perls/perl-5.16.1/bin" >> /.bashrc && \
    echo ". ${PERLBREW_ROOT}/bin" >> /.bashrc && \
    perlbrew switch perl-5.16.1 && \
    perlbrew install-cpanm && \
    /perl5/bin/cpanm KAZUHO/Server-Starter-0.35.tar.gz --notest

COPY ["./src/Gemfile", "./"]
COPY ["./src/Gemfile.lock", "./"]
RUN gem install bundler --version 1.17.3 && bundle install

COPY ["./run", "/service/sample_server/run"]

COPY . /sample
