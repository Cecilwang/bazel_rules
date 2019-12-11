ARG UBUNTU_VERSION=16.04
FROM ubuntu:${UBUNTU_VERSION} AS base

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    chrpath \
    cmake \
    curl \
    file \
    git \
    lcov \
    less \
    openssh-server \
    pkg-config \
    python \
    python3-dev \
    python3-pip \
    python3-setuptools \
    qemu \
    rsync \
    software-properties-common \
    unzip \
    wget \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN pip3 --no-cache-dir install --upgrade \
    pip \
    setuptools \
    wheel

# Install bazel
ARG BAZEL_VERSION=1.2.1
RUN wget -O /tmp/installer.sh "https://github.com/bazelbuild/bazel/releases/download/${BAZEL_VERSION}/bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh" && \
    chmod +x /tmp/installer.sh && \
    /tmp/installer.sh && \
    rm -f /tmp/installer.sh

# Install repo
RUN curl https://storage.googleapis.com/git-repo-downloads/repo > /usr/bin/repo \
  && chmod a+x /usr/bin/repo
