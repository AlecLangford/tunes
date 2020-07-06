FROM kdelfour/supervisor-docker
WORKDIR /builds
RUN apt-get update && apt-get install -y \
build-essential \
ca-certificates \
g++ \
curl \
libssl-dev \
apache2-utils \
git \
libxml2-dev \
sshfs \
openvpn \
zlib1g-dev \
libncurses5-dev \
libgdbm-dev \
libnss3-dev \
libreadline-dev \
libffi-dev \
wget \
tmux \
libssl-dev \
zlib1g-dev \
libncurses5-dev \
libncursesw5-dev \
apache2-utils \
build-essential \
checkinstall \
curl \
g++ \
git \
ldnsutils \
libbz2-dev \
libdb5.3-dev \
libexpat1-dev \
libffi-dev \
libgdbm-dev \
liblzma-dev \
libncurses5-dev \
libncursesw5-dev \
libnss3-dev \
libreadline-dev \
libsqlite3-dev \
libssl-dev \
libxml2-dev \
openvpn \
sshfs \
tmux \
uuid-dev \
wget \
zlib1g-dev \
libreadline-dev \
libsqlite3-dev \
libgdbm-dev \
libdb5.3-dev \
libbz2-dev \
libexpat1-dev \
liblzma-dev \
libffi-dev \
uuid-dev \
build-essential \
checkinstall \
zlib1g-dev \
software-properties-common && add-apt-repository ppa:deadsnakes/ppa -y


RUN curl -sL https://deb.nodesource.com/setup_5.x | bash -
RUN apt-get install -y nodejs


#RUN apt-get update && apt-get install yasm libav-tools


RUN git clone https://github.com/c9/core.git /cloud9
WORKDIR /cloud9

RUN apt-get -y install software-properties-common && add-apt-repository ppa:deadsnakes/ppa && apt-get install -y python3.6 python3.6-dev python3.6-venv
RUN apt-get -y install software-properties-common && add-apt-repository ppa:transmissionbt/ppa && apt-get install -y transmission-cli transmission-common transmission-daemon

RUN scripts/install-sdk.sh
RUN sed -i -e 's_127.0.0.1_0.0.0.0_g' /cloud9/configs/standalone.js


RUN curl -s https://install.zerotier.com | sudo bash
#RUN curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl \
#&& chmod a+rx /usr/local/bin/youtube-dl

#RUN add-apt-repository ppa:transmissionbt/ppa \
#&& apt-get update \
#&& apt-get install transmission-cli transmission-common transmission-daemon

ADD supervised_apps.conf /etc/supervisor/conf.d/

RUN mkdir /workspace
VOLUME /workspace
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
EXPOSE 80
EXPOSE 9091 
CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]
