# Jupyter pyspark notebook
[![Docker Pulls](https://img.shields.io/docker/pulls/adolphlwq/docker-jupyter.svg?maxAge=2592000?style=flat-square)]()


## Why yet another jupyter image
[Official Jupyter base-notebook Dockerfile](https://github.com/jupyter/docker-stacks/tree/master/base-notebook) uses `Jessie` as base image.By 2016.7.26, it only support Mesos 0.22. but Mesos has released [Mesos 1.0](http://mesos.apache.org/). So I rebuild the image which
uses ubuntu:14.04 as base image. My image support Mesos(0.28.1) version default.

## Introduction
This image support python 2 and python Ipython which run under Jupyter.
I have download Java 7 and Apache Spark 2.0.2. So you can run pyspark in Ipython

## Note
This docker image is for run Jupyter Notebook cross Mesos Cluster. It refers to [official Jupyter Dockerfile](https://github.com/jupyter/docker-stacks/tree/master/base-notebook)
Official image use `Jessie` as base image.By 2016.7.26, it only support Mesos 0.22. So I rebuild the image which
uses ubuntu:14.04 as base image.My image support the latest Mesos version.

## Changelog
- image `adolphlwq/docker-jupyter:pyspark-notebook-1.6.0`:this version with spark 1.6.0 built in
- image `adolphlwq/docker-jupyter:pyspark-notebook-2.0.1`:this version with spark 2.0.1 built in
- image `adolphlwq/docker-jupyter:pyspark-notebook-2.0.2`:this version with spark 2.0.2 built in
- on master branch and image `adolphlwq/docker-jupyter` is spark 2.0.2 and mesos 0.28.1

## Usage
1. normal usage:
```
##download the image
docker pull adolphlwq/docker-jupyter:pyspark-notebook-2.0.2
##run
docker run -d -p 8888:8888 adolphlwq/docker-jupyter:pyspark-notebook-2.0.2 OR
docker run --net host -d adolphlwq/docker-jupyter:pyspark-notebook-2.0.2
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
      "image": "adolphlwq/docker-jupyter:pyspark-notebook-2.0.2",
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

## Notebook Options

The Docker container executes a [`start-notebook.sh` script](./start-notebook.sh) script by default. The `start-notebook.sh` script handles the `NB_UID` and `GRANT_SUDO` features documented in the next section, and then executes the `jupyter notebook`.

You can pass [Jupyter command line options](http://jupyter.readthedocs.org/en/latest/config.html#command-line-arguments) through the `start-notebook.sh` script when launching the container. For example, to secure the Notebook server with a password hashed using `IPython.lib.passwd()`, run the following:

```
docker run -d -p 8888:8888 adolphlwq/docker-jupyter:pyspark-notebook-2.0.2 start-notebook.sh --NotebookApp.password='sha1:74ba40f8a388:c913541b7ee99d15d5ed31d4226bf7838f83a50e'
```

For example, to set the base URL of the notebook server, run the following:

```
docker run -d -p 8888:8888 adolphlwq/docker-jupyter:pyspark-notebook-2.0.2 start-notebook.sh --NotebookApp.base_url=/some/path
```

You can sidestep the `start-notebook.sh` script and run your own commands in the container. See the *Alternative Commands* section later in this document for more information.

## Docker Options

You may customize the execution of the Docker container and the command it is running with the following optional arguments.

* `-e PASSWORD="YOURPASS"` - Configures Jupyter Notebook to require the given plain-text password. Should be combined with `USE_HTTPS` on untrusted networks. **Note** that this option is not as secure as passing a pre-hashed password on the command line as shown above.
* `-e USE_HTTPS=yes` - Configures Jupyter Notebook to accept encrypted HTTPS connections. If a `pem` file containing a SSL certificate and key is not provided (see below), the container will generate a self-signed certificate for you.
* `-e NB_UID=1000` - Specify the uid of the `jovyan` user. Useful to mount host volumes with specific file ownership. For this option to take effect, you must run the container with `--user root`. (The `start-notebook.sh` script will `su jovyan` after adjusting the user id.)
* `-e GRANT_SUDO=yes` - Gives the `jovyan` user passwordless `sudo` capability. Useful for installing OS packages. For this option to take effect, you must run the container with `--user root`. (The `start-notebook.sh` script will `su jovyan` after adding `jovyan` to sudoers.) **You should only enable `sudo` if you trust the user or if the container is running on an isolated host.**
* `-v /some/host/folder/for/work:/home/jovyan/work` - Host mounts the default working directory on the host to preserve work even when the container is destroyed and recreated (e.g., during an upgrade).
* `-v /some/host/folder/for/server.pem:/home/jovyan/.local/share/jupyter/notebook.pem` - Mounts a SSL certificate plus key for `USE_HTTPS`. Useful if you have a real certificate for the domain under which you are running the Notebook server.
