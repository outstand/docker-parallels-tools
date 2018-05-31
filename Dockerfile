FROM outstand/tini as tini

FROM buildpack-deps:latest
MAINTAINER Ryan Schlesinger <ryan@outstand.com>

COPY --from=tini /sbin/tini /sbin/

RUN apt-get update && apt-get install -y --no-install-recommends \
    dkms \
    bash \
  && rm -rf /var/lib/apt/lists/*

ARG VCS_REF
LABEL org.label-schema.vcs-ref=$VCS_REF \
  org.label-schema.vcs-url="https://github.com/outstand/docker-parallels-tools"

COPY ./extracted/prl-tools-lin.tar.xz /

COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/sbin/tini", "-g", "--", "/docker-entrypoint.sh"]
CMD ["start"]
