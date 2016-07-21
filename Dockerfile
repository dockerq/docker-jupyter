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
# install conda python 2
RUN conda create --quiet --yes -p $CONDA_DIR/envs/python2 python=2.7 \
    'ipython=4.2*' \
    'ipywidgets=5.1*' \
    'matplotlib=1.5*'
RUN ln -s $CONDA_DIR/envs/python2/bin/pip $CONDA_DIR/bin/pip2 && \
    ln -s $CONDA_DIR/bin/pip $CONDA_DIR/bin/pip3
USER root
# Install Python 2 kernel spec globally to avoid permission problems when NB_UID
# switching at runtime.
RUN $CONDA_DIR/envs/python2/bin/python -m ipykernel install && \
    chmod +x /usr/local/bin/*.sh
USER $NB_USER
