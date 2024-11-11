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
ENV PATH=/miniconda/bin:${PATH}
RUN conda update -y conda
# RUN conda init bash
RUN echo ". /miniconda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc


RUN conda create -n tram python=3.10 -y
RUN echo "source activate tram" > ~/.bashrc
ENV PATH /miniconda/envs/tram/bin:$PATH

RUN git clone --recursive https://github.com/hansen1416/tram

WORKDIR /tram

RUN ls -lhs
RUN conda list

# docker run -it --rm --gpus all my_image_name