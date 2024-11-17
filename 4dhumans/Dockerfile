FROM nvidia/cuda:12.4.1-cudnn-devel-ubuntu22.04

# /var/lib/apt/lists/ directory. This directory contains cached information about available packages.
RUN apt-get update --fix-missing && \
    apt-get install -y --no-install-recommends wget bzip2 ca-certificates curl git vim libgl1 libglib2.0-0 libglfw3-dev libgles2-mesa-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

## Conda
# Use the above args during building https://docs.docker.com/engine/reference/builder/#understand-how-arg-and-from-interact
ARG CONDA_VER=py310_24.9.2-0
ARG OS_TYPE=x86_64
# Install miniconda to /miniconda
RUN curl -LO "http://repo.continuum.io/miniconda/Miniconda3-${CONDA_VER}-Linux-${OS_TYPE}.sh" && \
    bash Miniconda3-${CONDA_VER}-Linux-${OS_TYPE}.sh -b -p /miniconda && \
    rm Miniconda3-${CONDA_VER}-Linux-${OS_TYPE}.sh && \
    echo ". /miniconda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc

ENV PATH /miniconda/bin:${PATH}

RUN git clone https://github.com/hansen1416/4D-Humans.git

WORKDIR /4D-Humans

RUN conda env create -f environment.yml && \
    echo "source activate 4D-humans" > ~/.bashrc

ENV PATH /miniconda/envs/4D-humans/bin:$PATH

ENV TORCH_CUDA_ARCH_LIST="8.0 8.6 9.0"

RUN /bin/bash -c ". activate 4D-humans" && \
    pip install git+https://github.com/hansen1416/PHALP.git

COPY basicModel_neutral_lbs_10_207_0_v1.0.0.pkl ./data/basicModel_neutral_lbs_10_207_0_v1.0.0.pkl
COPY basicModel_neutral_lbs_10_207_0_v1.0.0.pkl basicModel_neutral_lbs_10_207_0_v1.0.0.pkl

COPY dataset_config.yaml ./data/
COPY model_config.yaml ./data/
COPY epoch=35-step=1000000.ckpt ./data/

######################################################################

# docker build -t hansen1416/4dhumans .
# docker run -it --rm --gpus all hansen1416/4dhumans
# vim /miniconda/envs/tram/lib/python3.10/site-packages/chumpy/__init__.py
# from numpy import nan, inf
# import numpy as np
# unicode=np.unicode_