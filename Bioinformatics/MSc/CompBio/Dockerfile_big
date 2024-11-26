# Base image
FROM ubuntu:22.04

# Set noninteractive mode for apt
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    wget \
    fastqc \
    unzip \
    python3-pip \
    openjdk-11-jre \
    libbz2-dev \
    libcurl4-openssl-dev \
    liblzma-dev \
    zlib1g-dev \
    libncurses5-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Download and install tools
WORKDIR /tools

# Install bcftools version 1.18
RUN wget https://github.com/samtools/bcftools/releases/download/1.18/bcftools-1.18.tar.bz2 && \
    tar -xjf bcftools-1.18.tar.bz2 && \
    cd bcftools-1.18 && \
    make && \
    mv bcftools /usr/local/bin/ && \
    cd .. && \
    rm -rf bcftools-1.18*

# Install samtools version 1.16.1
RUN wget https://github.com/samtools/samtools/releases/download/1.16.1/samtools-1.16.1.tar.bz2 && \
    tar -xjf samtools-1.16.1.tar.bz2 && \
    cd samtools-1.16.1 && \
    make && \
    mv samtools /usr/local/bin/ && \
    cd .. && \
    rm -rf samtools-1.16.1*

# Install MultiQC
RUN pip3 install multiqc==1.13

# Cleanup
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
