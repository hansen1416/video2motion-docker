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

COPY hmr2_data.tar.gz ./hmr2_data.tar.gz

######################################################################

# https://people.eecs.berkeley.edu/~jathushan/projects/phalp/3D/head_faces.npy to /root/.cache/phalp/3D/head_faces.npy
# https://people.eecs.berkeley.edu/~jathushan/projects/phalp/3D/mean_std.npy to /root/.cache/phalp/3D/mean_std.npy
# https://people.eecs.berkeley.edu/~jathushan/projects/phalp/3D/smpl_mean_params.npz to /root/.cache/phalp/3D/smpl_mean_params.npz
# https://people.eecs.berkeley.edu/~jathushan/projects/phalp/3D/SMPL_to_J19.pkl to /root/.cache/phalp/3D/SMPL_to_J19.pkl
# https://people.eecs.berkeley.edu/~jathushan/projects/phalp/3D/texture.npz to /root/.cache/phalp/3D/texture.npz
# https://people.eecs.berkeley.edu/~jathushan/projects/phalp/bmap_256.npy to /root/.cache/phalp/3D/bmap_256.npy
# https://people.eecs.berkeley.edu/~jathushan/projects/phalp/fmap_256.npy to /root/.cache/phalp/3D/fmap_256.npy
# https://people.eecs.berkeley.edu/~jathushan/projects/phalp/weights/hmar_v2_weights.pth to /root/.cache/phalp/weights/hmar_v2_weights.pth
# https://people.eecs.berkeley.edu/~jathushan/projects/phalp/weights/pose_predictor_40006.ckpt to /root/.cache/phalp/weights/pose_predictor.pth
# https://people.eecs.berkeley.edu/~jathushan/projects/phalp/weights/config_40006.yaml to /root/.cache/phalp/weights/pose_predictor.yaml
# https://people.eecs.berkeley.edu/~jathushan/projects/phalp/ava/ava_labels.pkl to /root/.cache/phalp/ava/ava_labels.pkl
# https://people.eecs.berkeley.edu/~jathushan/projects/phalp/ava/ava_class_mappping.pkl to /root/.cache/phalp/ava/ava_class_mapping.pkl
# "https://download.pytorch.org/models/resnet50-19c8e357.pth" to /root/.cache/torch/hub/checkpoints/resnet50-19c8e357.pth

# https://people.eecs.berkeley.edu/~jathushan/projects/4dhumans/hmr2_data.tar.gz to /root/.cache/4DHumans/hmr2_data.tar.gz

# python track.py video.source="example_data/videos/gymnasts.mp4"

# docker build -t hansen1416/4dhumans .
# docker run -d --rm --gpus all --name 4dhumans hansen1416/4dhumans tail -f /dev/null
# docker exec -it 4dhumans /bin/bash

# cd /root/.cache/4DHumans
# tar -xvf hmr2_data.tar.gz