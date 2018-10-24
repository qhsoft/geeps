FROM nvidia/cuda:9.1-cudnn7-devel-ubuntu16.04
LABEL maintainer "NVIDIA CORPORATION <cudatools@nvidia.com>"


RUN apt-get -y update

RUN apt-get -y install --no-install-recommends \
        openssh-server \
        scons \
        wget \
        git \
        build-essential \
        cmake \
        apt-utils \
        nload

RUN service ssh restart

WORKDIR /root
RUN git clone https://github.com/qhsoft/geeps.git


COPY ssh .ssh
ARG NUM_CORE=8

WORKDIR /root/geeps
# RUN sh ./scripts/install-geeps-deps-ubuntu16.sh
# RUN sh ./scripts/install-caffe-deps-ubuntu16.sh

RUN apt-get install -y --no-install-recommends \
        libatlas-base-dev \
        libopencv-dev \
        protobuf-compiler \
        libprotobuf-dev \
        libgoogle-glog-dev \
        libgflags-dev \
        libhdf5-dev \
        libleveldb-dev \
        libsnappy-dev \
        liblmdb-dev \
        libpython-dev \
        libboost-python-dev \
        libboost-filesystem-dev \
        cython \
        python-numpy \
        python-protobuf \
        python-skimage \
        python-h5py \
        python-matplotlib \
        libboost-thread-dev \
        libboost-program-options-dev \
        libtbb-dev \
        libzmq-dev \
        pdsh && \
    rm -rf /var/lib/apt/lists/*


RUN scons -j ${NUM_CORE}
WORKDIR /root/geeps/apps/caffe
RUN make -j ${NUM_CORE}

WORKDIR /root/geeps

# RUN apt-get update && apt-get install -y --no-install-recommends \
#         build-essential \
#         cmake \
#         git \
#         wget \
#         libatlas-base-dev \
#         libboost-all-dev \
#         libgflags-dev \
#         libgoogle-glog-dev \
#         libhdf5-serial-dev \
#         libleveldb-dev \
#         liblmdb-dev \
#         libopencv-dev \
#         libprotobuf-dev \
#         libsnappy-dev \
#         protobuf-compiler \
#         python-dev \
#         python-numpy \
#         python-pip \
#         python-scipy && \
#     rm -rf /var/lib/apt/lists/*

