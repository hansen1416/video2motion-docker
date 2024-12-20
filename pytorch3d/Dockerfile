FROM pytorch/pytorch:2.4.0-cuda11.8-cudnn9-runtime

# # /var/lib/apt/lists/ directory. This directory contains cached information about available packages.
# RUN apt-get update --fix-missing && \
#     apt-get install -y --no-install-recommends wget bzip2 ca-certificates curl git vim libgl1 libglib2.0-0 libglfw3-dev libgles2-mesa-dev && \
#     apt-get clean && \
#     rm -rf /var/lib/apt/lists/*


RUN conda install -c fvcore -c iopath -c conda-forge fvcore iopath

RUN conda install pytorch3d=0.7.8 -c pytorch3d


# docker build -t hansen1416/pytorch3d .
# docker run -d --rm --gpus all --name pytorch3d hansen1416/pytorch3d tail -f /dev/null
# docker exec -it pytorch3d /bin/bash