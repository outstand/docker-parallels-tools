FROM buildpack-deps:latest
MAINTAINER Ryan Schlesinger <ryan@outstand.com>

RUN apt-get update && apt-get install -y --no-install-recommends \
    dkms \
    bash \
  && rm -rf /var/lib/apt/lists/*

ENV DUMB_INIT_VERSION 1.2.0
RUN wget https://github.com/Yelp/dumb-init/releases/download/v${DUMB_INIT_VERSION}/dumb-init_${DUMB_INIT_VERSION}_amd64.deb
RUN dpkg -i dumb-init_*.deb

ARG VCS_REF
LABEL org.label-schema.vcs-ref=$VCS_REF \
  org.label-schema.vcs-url="https://github.com/outstand/docker-parallels-tools"

COPY ./extracted/prl-tools-lin.tar.xz /

COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["start"]
