#!/bin/bash
set -e -x

pushd $DAPPER_SOURCE

echo 'Extracting iso'
mkdir prl-tools-lin
osirrox -indev ./prl-tools-lin.iso -extract / prl-tools-lin/

echo 'Creating tarball'
mkdir -p extracted
pushd extracted
tar -C ../ -cJf prl-tools-lin.tar.xz prl-tools-lin
