# Jupyter base notebook
[![Docker Pulls](https://img.shields.io/docker/pulls/adolphlwq/docker-jupyter.svg?maxAge=2592000?style=flat-square)]()

## Why yet another jupyter image
[Official Jupyter base-notebook Dockerfile](https://github.com/jupyter/docker-stacks/tree/master/base-notebook) uses `Jessie` as base image.By 2016.7.26, it only support Mesos 0.22. but Mesos has released [Mesos 1.0](http://mesos.apache.org/). So I rebuild the image which
uses ubuntu:14.04 as base image. My image support Mesos(0.28.1) version default.

## Introduction
This image support python 3 Ipython which run under Jupyter.

## Custom
You can also custom the image yourself,such as using you mesos version.
