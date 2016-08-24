FROM buildpack-deps:jessie
MAINTAINER Ryan Schlesinger <ryan@outstand.com>

RUN apt-get update && apt-get install -y --no-install-recommends \
    dkms \
  && rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/Yelp/dumb-init/releases/download/v1.1.3/dumb-init_1.1.3_amd64.deb
RUN dpkg -i dumb-init_*.deb

ARG VCS_REF
LABEL org.label-schema.vcs-ref=$VCS_REF \
  org.label-schema.vcs-url="https://github.com/outstand/docker-parallels-tools"

COPY ./extracted/prl-tools-lin.tar.xz /

COPY ./entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
CMD ["start"]
