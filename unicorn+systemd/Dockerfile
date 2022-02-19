# https://hub.docker.com/r/centos/systemd/
FROM centos/systemd

RUN yum -y update && yum install -y git && yum -y install psmisc && yum install -y which && \
    git clone https://github.com/rbenv/rbenv.git ~/.rbenv && \
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile && \
    echo 'eval "$(rbenv init -)"' >> ~/.bash_profile && \
    source ~/.bash_profile && \
    (~/.rbenv/bin/rbenv init || true) && \
    git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build && \
    ~/.rbenv/plugins/ruby-build/install.sh && \
    yum install -y gcc bzip2 openssl-devel readline-devel zlib-devel && \
    yum install -y tar && yum install -y make && \
    CONFIGURE_OPTS='--disable-install-rdoc' rbenv install 2.7.2 && rbenv global 2.7.2 && rbenv rehash

WORKDIR /sample
COPY ["./src/Gemfile", "./"]

ENV PATH /root/.rbenv/shims:/root/.rbenv/bin:$PATH

RUN gem install bundler --version 1.17.2 && bundle install

COPY . /sample
COPY ["./sample_app.service", "/etc/systemd/system/sample_app.service"]

RUN systemctl enable sample_app.service

CMD ["/usr/sbin/init"]
