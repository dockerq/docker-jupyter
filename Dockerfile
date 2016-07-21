# This image is refer to Jupyter base-notebook:
#https://github.com/jupyter/docker-stacks/blob/master/base-notebook/Dockerfile
FROM adolphlwq/docker-jupyter:base-notebook
MAINTAINER adolphlwq kenan3015@gmail.com
USER root
#install python 2
RUN apt-get update && apt-get install -y build-essential && \
    apt-get install -y python-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
# Switch back to jovyan to avoid accidental container runs as root
USER $NB_USER
