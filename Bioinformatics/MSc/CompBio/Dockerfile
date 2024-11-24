# Base image
FROM ubuntu:22.04

# Set noninteractive mode for apt
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    wget \
    samtools \
    bedtools \
    unzip \
    python3-pip \
    openjdk-11-jre \
    libbz2-dev \
    libcurl4-openssl-dev \
    liblzma-dev \
    zlib1g-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Download and install tools
WORKDIR /tools
# Install FastQC version 0.11.9
RUN wget http://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.11.9.zip && \
    unzip fastqc_v0.11.9.zip && \
    mv FastQC/ /opt/FastQC/ && \
    chmod +x /opt/FastQC/fastqc && \
    rm -rf fastqc_v0.11.9.zip FastQC

# Install bcftools version 1.18
RUN wget https://github.com/samtools/bcftools/releases/download/1.18/bcftools-1.18.tar.bz2 && \
    tar -xjf bcftools-1.18.tar.bz2 && \
    cd bcftools-1.18 && \
    make && \
    mv bcftools /usr/local/bin/ && \
    cd .. && \
    rm -rf bcftools-1.18*

# Set PATH for FastQC
ENV PATH="/opt/FastQC:$PATH"

# Install MultiQC
RUN pip3 install multiqc==1.13

# Cleanup
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*