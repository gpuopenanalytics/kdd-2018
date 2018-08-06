# An integration test & dev container which builds and installs libgdf & pygdf from master
ARG CUDA_VERSION=9.2
ARG LINUX_VERSION=ubuntu16.04
FROM nvcr.io/nvidia/cuda:${CUDA_VERSION}-devel-${LINUX_VERSION}
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib64:/usr/local/lib
# Needed for pygdf.concat(), avoids "OSError: library nvvm not found"
ENV NUMBAPRO_NVVM=/usr/local/cuda/nvvm/lib64/libnvvm.so
ENV NUMBAPRO_LIBDEVICE=/usr/local/cuda/nvvm/libdevice/

ARG CC_VERSION=5
ARG CXX_VERSION=5
RUN apt update -y --fix-missing && \
    apt upgrade -y && \
    apt install -y \
      git \
      gcc-${CC_VERSION} \
      g++-${CXX_VERSION} \
      libboost-dev \
      cmake \
    && rm -rf /var/lib/apt/lists/*

# Install conda
ADD https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh /miniconda.sh
RUN sh /miniconda.sh -b -p /conda && /conda/bin/conda update -n base conda
ENV PATH=${PATH}:/conda/bin
# Enables "source activate conda"
SHELL ["/bin/bash", "-c"]

# Build combined libgdf/pygdf conda env
ARG PYTHON_VERSION=3.6
RUN conda create -n gdf python=${PYTHON_VERSION}

ARG NUMBA_VERSION=0.40.0
ARG NUMPY_VERSION=1.14.3
# Locked to Pandas 0.20.3 by https://github.com/gpuopenanalytics/pygdf/issues/118
ARG PANDAS_VERSION=0.20.3
ARG XGBOOST_VERSION=0.72.1
RUN conda install -n gdf -y -c numba -c conda-forge -c defaults \
      numba=${NUMBA_VERSION} \
      numpy=${NUMPY_VERSION} \
      numpy-base=${NUMPY_VERSION} \
      pandas=${PANDAS_VERSION} \
      xgboost=${XGBOOST_VERSION} \
      jupyterlab \
      ipython-autotime

# LibGDF & PyGDF build/install
ARG LIBGDF_REPO=https://github.com/gpuopenanalytics/libgdf
ARG PYGDF_REPO=https://github.com/gpuopenanalytics/pygdf
RUN git clone --recurse-submodules ${LIBGDF_REPO} /libgdf
RUN git clone --recurse-submodules ${PYGDF_REPO} /pygdf
ENV CC=/usr/bin/gcc-${CC_VERSION}
ENV CXX=/usr/bin/g++-${CXX_VERSION}
ARG HASH_JOIN=ON
RUN source activate gdf && \
    mkdir -p /libgdf/build && \
    cd /libgdf/build && \
    cmake .. -DHASH_JOIN=${HASH_JOIN} && \
    make -j install && \
    make copy_python && \
    python setup.py install && \
    cd /pygdf && \
    python setup.py install

ENV TINI_VERSION=v0.18.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/bin/tini
RUN chmod +x /usr/bin/tini

ARG JUPYTER_USER=jupyter
RUN useradd -ms /bin/bash ${JUPYTER_USER}
USER ${JUPYTER_USER}
WORKDIR /notebooks
EXPOSE 8888

ENTRYPOINT [ "/usr/bin/tini", "--" ]
CMD [ "/bin/bash", "-c","source activate gdf && jupyter-lab --ip=* --NotebookApp.token='kdd-2018'"]

