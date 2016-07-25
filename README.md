# Jupyter base notebook
[![Docker Pulls](https://img.shields.io/docker/pulls/adolphlwq/docker-jupyter.svg?maxAge=2592000?style=flat-square)]()

## Introduction
This image support both python 2 and python 3 Ipython which run under Jupyter.

## Note
[Official Jupyter base-notebook Dockerfile](https://github.com/jupyter/docker-stacks/tree/master/base-notebook) uses `Jessie` as base image.By 2016.7.26, it only support Mesos 0.22. So I rebuild the image which
uses ubuntu:14.04 as base image.My image support the latest Mesos version.
