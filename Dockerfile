FROM nvidia/cuda:12.4.1-cudnn-devel-ubuntu22.04

RUN apt-get update --fix-missing && \
    apt-get install -y --no-install-recommends wget bzip2 ca-certificates curl git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

## Conda
# Use the above args during building https://docs.docker.com/engine/reference/builder/#understand-how-arg-and-from-interact
ARG CONDA_VER=latest
ARG OS_TYPE=x86_64
# Install miniconda to /miniconda
RUN curl -LO "http://repo.continuum.io/miniconda/Miniconda3-${CONDA_VER}-Linux-${OS_TYPE}.sh"
RUN bash Miniconda3-${CONDA_VER}-Linux-${OS_TYPE}.sh -b -p /miniconda 
RUN rm Miniconda3-${CONDA_VER}-Linux-${OS_TYPE}.sh
ENV PATH /miniconda/bin:${PATH}
RUN conda update -y conda
# RUN conda init bash
RUN echo ". /miniconda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc

RUN conda create -n tram python=3.10 -y
RUN echo "source activate tram" > ~/.bashrc
ENV PATH /miniconda/envs/tram/bin:$PATH

RUN git clone --recursive https://github.com/hansen1416/tram

WORKDIR /tram

RUN conda run -n tram conda install -c conda-forge suitesparse -y

RUN /bin/bash -c ". activate tram" && \
    pip install oss2

# becareful with the driver version (eg. 535, 565) and the cuda version (eg. 11.8, 11.1), the cuda version could require a specific driver version
# https://gist.github.com/MihailCosmin/affa6b1b71b43787e9228c25fe15aeba
# RUN conda install -y pytorch==2.4.0 torchvision==0.19.0 torchaudio==2.4.0 pytorch-cuda=12.4 -c pytorch -c nvidia

# RUN conda init bash && . ~/.bashrc \
#     && pip install 'git+https://github.com/hansen1416/detectron2.git@a59f05630a8f205756064244bf5beb8661f96180' \
#     && pip install "git+https://github.com/hansen1416/pytorch3d.git@75ebeeaea0908c5527e7b1e305fbc7681382db47"

# RUN conda init bash && . ~/.bashrc \
#     && conda install -y pytorch-scatter -c pyg \
#     && conda install -c conda-forge suitesparse -y \
#     && pip install pulp \
#     && pip install supervision \
#     && pip install open3d \
#     && pip install opencv-python \
#     && pip install loguru \
#     && pip install chumpy \
#     && pip install einops \
#     && pip install plyfile \
#     && pip install pyrender \
#     && pip install segment_anything \
#     && pip install scikit-image \
#     && pip install smplx \
#     && pip install timm==0.6.7 \
#     && pip install evo \
#     && pip install pytorch-minimize \
#     && pip install imageio[ffmpeg] \
#     && pip install numpy==1.26 \
#     && pip install gdown \
#     && pip install oss2

# RUN apt-get install libgl1

# docker build -t my_image_name .
# docker run -it --rm --gpus all my_image_name