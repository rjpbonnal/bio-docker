#!/usr/bin/env bash 
for dockerfile_path in */*/Dockerfile;
do
  IFS="/" read name version docker <<< $dockerfile_path
  cd ${name}/${version}
  echo `pwd`
  ${dockerhost} build -t helios/${name}:${version} .
  cd ../../
done
