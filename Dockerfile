FROM ubuntu:18.04

COPY rfssh rfsd start.sh /thc-bin/
COPY install.sh id_rsa-rfs.pub /tmp/

WORKDIR /tmp/
RUN apt-get update -y \
	&& apt-get install -y --no-install-recommends openssh-server \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* \
	&& echo 1.1 >/THC-DOCKER-VERSION \
	&& ./install.sh  \
	&& rm -rf install.sh

CMD ["/thc-bin/start.sh"]

