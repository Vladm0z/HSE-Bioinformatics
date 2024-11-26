# Base image
FROM ubuntu:22.04

# Set noninteractive mode for apt
ENV DEBIAN_FRONTEND=noninteractive

# Install essential dependencies and clean up
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    fastqc \
    python3-pip \
    unzip \
    bzip2 \
    libbz2-dev \
    libcurl4-openssl-dev \
    zlib1g-dev \
    libncurses5-dev \
    liblzma-dev \
    build-essential && \
    wget -qO- https://github.com/samtools/bcftools/releases/download/1.18/bcftools-1.18.tar.bz2 | tar -xj && \
    cd bcftools-1.18 && \
    make && \
    mv bcftools /usr/local/bin/ && \
    cd .. && rm -rf bcftools-1.18* && \
    wget -qO- https://github.com/samtools/samtools/releases/download/1.16.1/samtools-1.16.1.tar.bz2 | tar -xj && \
    cd samtools-1.16.1 && \
    make && \
    mv samtools /usr/local/bin/ && \
    cd .. && rm -rf samtools-1.16.1* && \
    pip3 install --no-cache-dir multiqc==1.13 && \
    apt-get remove -y --purge build-essential && \
    apt-get autoremove -y && apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set the working directory for future commands
WORKDIR /tools

