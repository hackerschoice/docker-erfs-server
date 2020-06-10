FROM ubuntu:18.04

RUN apt-get update -y \
	&& apt-get install -y git openssh-server \
	&& apt-get clean \
	&& echo 1.1 >/THC-DOCKER-VERSION \
	&& cd /tmp \
	&& git clone https://github.com/SkyperTHC/thc-rfs-server.git \
	&& cd thc-rfs-server \
	&& ./install.sh 

CMD ["/thc-bin/start.sh"]

