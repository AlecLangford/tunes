FROM kdelfour/supervisor-docker
RUN apt-get update
RUN apt-get install -y build-essential g++ curl libssl-dev apache2-utils git libxml2-dev sshfs openvpn zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libreadline-dev libffi-dev wget tmux
RUN curl -sL https://deb.nodesource.com/setup_5.x | bash -
RUN apt-get install -y nodejs

RUN curl -O https://www.python.org/ftp/python/3.8.2/Python-3.8.2.tar.xz \
&& tar -xf Python-3.8.2.tar.xz \
&& cd Python-3.8.2 \
&& ./configure \
&& make \
&& make altinstall

RUN apt update && apt install yasm && git clone git://git.libav.org/libav.git && cd libav && ./configure && make && make install
#RUN git clone git://git.libav.org/libav.git \
#&& cd libav \
#&& ./configure \
#&& make \
#&& make install


RUN git clone https://github.com/c9/core.git /cloud9
WORKDIR /cloud9


RUN scripts/install-sdk.sh
RUN sed -i -e 's_127.0.0.1_0.0.0.0_g' /cloud9/configs/standalone.js


RUN curl -s https://install.zerotier.com | sudo bash
RUN curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl \
&& chmod a+rx /usr/local/bin/youtube-dl

#RUN add-apt-repository ppa:transmissionbt/ppa \
#&& apt-get update \
#&& apt-get install transmission-cli transmission-common transmission-daemon

ADD supervised_apps.conf /etc/supervisor/conf.d/

RUN mkdir /workspace
VOLUME /workspace
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
EXPOSE 80
CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]
