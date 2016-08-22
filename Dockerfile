FROM buildpack-deps:jessie
MAINTAINER Ryan Schlesinger <ryan@outstand.com>

RUN apt-get update && apt-get install -y --no-install-recommends \
    dkms \
  && rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/Yelp/dumb-init/releases/download/v1.1.3/dumb-init_1.1.3_amd64.deb
RUN dpkg -i dumb-init_*.deb

COPY ./extracted/prl-tools-lin.tar.xz /

COPY ./entrypoint.sh /
ENV DUMB_INIT_SETSID 0
ENTRYPOINT ["/entrypoint.sh"]
CMD ["start"]
