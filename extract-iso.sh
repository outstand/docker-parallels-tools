#!/bin/bash
set -e -x

pushd $DAPPER_SOURCE

echo 'Mounting parallels tools iso'
mkdir -p /mnt/prl-tools-lin
mount -t iso9660 -o loop prl-tools-lin.iso /mnt/prl-tools-lin

echo 'Creating tarball'
mkdir extracted
pushd extracted
tar -C /mnt -cJf prl-tools-lin.tar.xz prl-tools-lin
