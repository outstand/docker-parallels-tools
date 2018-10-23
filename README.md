# Parallels Guest Tools Docker Container

[![](https://images.microbadger.com/badges/image/outstand/parallels-tools.svg)](http://microbadger.com/images/outstand/parallels-tools "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/outstand/parallels-tools.svg)](http://microbadger.com/images/outstand/parallels-tools "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/commit/outstand/parallels-tools.svg)](http://microbadger.com/images/outstand/parallels-tools "Get your own commit badge on microbadger.com")

This docker container wraps the Parallels Desktop for Mac Guest Tools and allows you to run them easily on RancherOS.  Presumably this would work well on other guest OSes but those are untested.

## Build

Install Parallels Desktop for Mac v11 (or greater)

Install Dapper: https://github.com/rancher/dapper

Extract guest tools iso and build image:
```sh
./build.sh <IMAGE TAG>
```

## Using

This container relies on a shared mount point to be able to mount the shared folder(s) in the host.  This feature requires docker v1.10.0 or greater. These examples will use `/Users`.

Start the docker host
```sh
docker-machine create --driver=parallels \
  --parallels-memory=2048 \
  --parallels-boot2docker-url https://github.com/rancher/os/releases/download/v1.1.0/rancheros.iso \
  default
```

On the docker host (or container for docker-in-docker). For RancherOS this can go in `/opt/rancher/bin/start.sh`.
```sh
mkdir /Users
mount --bind /Users /Users
mount --make-shared /Users
mkdir -p /usr/src
```

Run it:
```sh
docker run -d --privileged \
  -v /usr/src:/usr/src \
  -v /lib/modules:/lib/modules \
  -v /Users:/media/psf/Users:shared \
  outstand/parallels-tools
```

## As a system service (RancherOS)

```yaml
parallels-tools:
  image: outstand/parallels-tools:latest
  restart: always
  labels:
    - io.rancher.os.remove=false
    - io.rancher.os.after=kernel-headers
  volumes:
    - /usr/src:/usr/src
    - /lib/modules:/lib/modules
  privileged: true
```
