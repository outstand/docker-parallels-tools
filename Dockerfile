FROM buildpack-deps:jessie
MAINTAINER Ryan Schlesinger <ryan@outstand.com>
LABEL RUN="sudo system-docker run -d --privileged -v /usr/src:/usr/src -v /lib/modules:/lib/modules -v /Users:/media/psf/Users:shared outstand/parallels-tools"

RUN apt-get update && apt-get install -y --no-install-recommends \
    dkms \
  && rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/Yelp/dumb-init/releases/download/v1.0.0/dumb-init_1.0.0_amd64.deb
RUN dpkg -i dumb-init_*.deb

COPY ./extracted/prl-tools-lin.tar.xz /

COPY ./entrypoint.sh /
ENV DUMB_INIT_SETSID 0
ENTRYPOINT ["/entrypoint.sh"]
CMD ["start"]
