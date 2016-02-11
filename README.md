# Parallels Guest Tools Docker Container

This docker container wraps the Parallels Desktop for Mac v11 Guest Tools and allows you to run them easily on RancherOS.  Presumably this would work well on other guest OSes but those are untested.

## Build

Install Parallels Desktop for Mac v11 (or greater)
Install Dapper: https://github.com/rancher/dapper

Extract guest tools iso:
```sh
./build.sh
```

Build container image:
```sh
docker build -t outstand/parallels-tools .
```

## Using

This container relies on a shared mount point to be able to mount the shared folder(s) in the host.  This feature requires docker v1.10.0 or greater. These examples will use `/Users`.

Start the docker host (needs v0.4.3 or newer RancherOS for docker v1.10.0):
```sh
docker-machine create --driver=parallels \
  --parallels-memory=2048 \
  --parallels-boot2docker-url https://github.com/rancher/os/releases/download/v0.4.3-rc3/rancheros.iso \
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
    - io.rancher.os.reloadconfig=true
    - io.rancher.os.remove=false
  container_name: parallels-tools
  volumes:
    - /usr/src:/usr/src
    - /lib/modules:/lib/modules
    - /Users:/media/psf/Users:shared
  privileged: true
```
