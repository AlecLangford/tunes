FROM kdelfour/supervisor-docker
RUN apt-get update
RUN apt-get install -y build-essential g++ curl libssl-dev apache2-utils git libxml2-dev sshfs openvpn zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libreadline-dev libffi-dev wget tmux
RUN curl -sL https://deb.nodesource.com/setup_5.x | bash -
RUN apt-get install -y nodejs
RUN git clone https://github.com/c9/core.git /cloud9
WORKDIR /cloud9
RUN curl -O https://www.python.org/ftp/python/3.8.2/Python-3.8.2.tar.xz \
	&& tar -xf Python-3.8.2.tar.xz
  && cd Python-3.8.2 \
	&& ./configure \
  && make \
  && make altinstall

RUN scripts/install-sdk.sh
RUN sed -i -e 's_127.0.0.1_0.0.0.0_g' /cloud9/configs/standalone.js
RUN mkdir /workspace
VOLUME /workspace
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
