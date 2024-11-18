FROM nvidia/cuda:11.3.1-cudnn8-runtime-ubuntu20.04

# /var/lib/apt/lists/ directory. This directory contains cached information about available packages.
RUN apt-get update --fix-missing && \
    apt-get install -y --no-install-recommends wget bzip2 ca-certificates curl git vim && \
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


# # Installation

# WHAM has been implemented and tested on Ubuntu 20.04 and 22.04 with python = 3.9. We provide [anaconda](https://www.anaconda.com/) environment to run WHAM as below.

# ```bash
# # Clone the repo
# git clone https://github.com/hansen1416/wham-video2motion.git --recursive
# cd WHAM/

# # Create Conda environment
# conda create -n wham python=3.9
# conda activate wham

# # Install PyTorch libraries
# conda install pytorch==1.11.0 torchvision==0.12.0 torchaudio==0.11.0 cudatoolkit=11.3 -c pytorch

# # Install PyTorch3D (optional) for visualization
# conda install -c fvcore -c iopath -c conda-forge fvcore iopath
# pip install pytorch3d -f https://dl.fbaipublicfiles.com/pytorch3d/packaging/wheels/py39_cu113_pyt1110/download.html

# # Install WHAM dependencies
# pip install -r requirements.txt

# # Install ViTPose
# pip install -v -e third-party/ViTPose

# # Install DPVO
# cd third-party/DPVO
# wget https://gitlab.com/libeigen/eigen/-/archive/3.4.0/eigen-3.4.0.zip
# unzip eigen-3.4.0.zip -d thirdparty && rm -rf eigen-3.4.0.zip
# conda install pytorch-scatter=2.0.9 -c rusty1s
# conda install cudatoolkit-dev=11.3.1 -c conda-forge

# # ONLY IF your GCC version is larger than 10
# conda install -c conda-forge gxx=9.5

# pip install .
# ```

# docker build -t hansen1416/wham .
# docker run -d --rm --gpus all hansen1416/wham tail -f /dev/null
