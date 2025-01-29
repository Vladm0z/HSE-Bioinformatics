##!/bin/sh

CHR=$1
SAMPLES=$2

VCF=./test.vcf.gz
VCF0=/media/scglab/T7/Work/data/1000GP/${CHR}/ALL.chr${CHR}.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf.gz


bcftools query -f '%POS\n' ${VCF0}|sort|uniq -cd   > dublicated.snps.txt
sed -i 's/^ *//' dublicated.snps.txt
sed -i 's/.* //' dublicated.snps.txt 
#нужно поменять на нужный номер хромосомы
sed -i -e 's/^/22\t/' dublicated.snps.txt 



bcftools view --types snps -m 2 -M 2 -S ${SAMPLES} -T ^dublicated.snps.txt  --force-samples ${VCF0} -Oz -o ${VCF}




./plink --vcf ${VCF} --double-id --allow-extra-chr \
--set-missing-var-ids @:# \
--indep-pairwise 50 10 0.1 --out test2

./plink --vcf ${VCF} --double-id --allow-extra-chr --set-missing-var-ids @:# --maf 0.1 \
--extract test2.prune.in \
--make-bed --out test3

awk -vOFS='\t' '{ print $1,  $4 }' test3.bim > var.chr${CHR}.txt
bcftools view -T var.chr${CHR}.txt ${VCF} -Oz -o chr${CHR}.pca.vcf.gz
bcftools query -f '%POS\t%REF\t%ALT\t[%GT ]\n' chr${CHR}.pca.vcf.gz> chr${CHR}.pca.txt


rm test3.*
rm test2.*
rm dublicated.*
rm test.*
