# Jupyter pyspark notebook
[![Docker Pulls](https://img.shields.io/docker/pulls/adolphlwq/docker-jupyter.svg?maxAge=2592000?style=flat-square)]()

## Introduction
This image support python 2 and python Ipython which run under Jupyter.
I have download Java 7 and Apache Spark 1.6.0. So you can run pyspark in Ipython

## Note
This docker image is for run Jupyter Notebook cross Mesos Cluster. It refers to [official Jupyter Dockerfile](https://github.com/jupyter/docker-stacks/tree/master/base-notebook)
Official image use `Jessie` as base image.By 2016.7.26, it only support Mesos 0.22. So I rebuild the image which
uses ubuntu:14.04 as base image.My image support the latest Mesos version.

## Usage
1. normal usage:
```
##download the image
docker pull adolphlwq/docker-jupyter:pyspark-notebook
##run
docker run -d -p 8888:8888 adolphlwq/docker-jupyter:pyspark-notebook OR
docker run --net host -d adolphlwq/docker-jupyter:pyspark-notebook
```
2. cross Mesos
using Marathon by a json:
```
{
  "id": "/jupyter-pyspark-notebook-test",
  "cmd": null,
  "cpus": 1,
  "mem": 4096,
  "disk": 4096,
  "instances": 1,
  "container": {
    "type": "DOCKER",
    "volumes": [],
    "docker": {
      "image": "adolphlwq/docker-jupyter:pyspark-notebook-1.6.0",
      "network": "HOST",
      "privileged": true,
      "parameters": [
        {
          "key": "pid",
          "value": "host"
        },
        {
          "key": "user",
          "value": "root"
        }
      ],
      "forcePullImage": true
    }
  },
  "env": {
    "TINI_SUBREAPER": "true",
    "PASSWORD": "password",
    "USE_HTTPS": "yes",
    "GRANT_SUDO": "yes"
  },
  "portDefinitions": [
    {
      "port": 10005,
      "protocol": "tcp",
      "labels": {}
    }
  ]
}
```
For more information to use the image, please refer to [official Jupyter Dockerfile](https://github.com/jupyter/docker-stacks/tree/master/base-notebook)
