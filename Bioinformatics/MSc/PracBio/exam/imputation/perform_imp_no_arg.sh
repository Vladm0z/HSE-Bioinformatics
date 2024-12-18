#!/bin/bash

beagle="/usr/bin/beagle.29Oct24.c8e.jar"

java -Xmx1g \
  -jar ${beagle} \
    gt=${1}.vcf.gz \
    ref=${2}.vcf.gz \
    out=${3} \
    chrom=${4}:${5}-${6} \
    map=/files/Genetic_maps/hg38/beagle_hg38_${4}.map  \
    nthreads=1 \
    window=5 \
    overlap=4 \
    iterations=10 \
    ne=20000 \
    impute=true \
    gp=true \
    seed=-9999
