#!/bin/bash
set -x -e

if [ -z "$1" ]; then
  echo "Image tag required!"
  exit 1
fi

IMAGE_TAG=$1

cp '/Applications/Parallels Desktop.app/Contents/Resources/Tools/prl-tools-lin.iso' .
dapper

if [ -z "$(git status --porcelain)" ]; then
  docker build -t outstand/parallels-tools:${IMAGE_TAG} --build-arg VCS_REF=`git rev-parse --short HEAD` .
else
  echo "Warning: dirty working directory, skipping VCS_REF"
  docker build -t outstand/parallels-tools:${IMAGE_TAG} .
fi
