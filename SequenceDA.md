# Анализ данных секвенирования 1

#### Аннотация
В данном курсе изучаются методы анализа данных технологий секвенирования следующего поколения, таких как DNA-seq, RNA-seq, Chip-Seq. Изучается методы сборки геномов de-novо из сырых ридов DNA-seq, анализ экспрессии генов на основе RNA-seq, методы обработки данных Chip-Seq. Дается представление о современных приложениях и практиках использования.

[ПУД](https://www.hse.ru/edu/courses/900084636)

[Официальный Яндекс Диск](https://disk.yandex.ru/d/z1g3QDc-WFmUtA)

### Оценивание

**Основная формула:**
- (HW_1 + HW_2 + HW_3) * 0.2 + Exam * 0.4

**Дедлайны:**
- HW_1 и HW_2 – 1 неделя
- HW_3 – 2 недели

**Экзамен:**
- Формат: *50 тестовых вопросов*
- 45 с вариантами ответа, 5 без
- В каждом вопросе может быть любое число ответов
  - Если в вопросе *n* правильных и *m* неправильных ответов:
    - Каждый правильный: *+1/n*
    - Каждый неправильный: *–1/m*
- Итоговые баллы нормируются (и могут быть отрицательными)

### Course Plan

| Date       | Topics |
|------------|--------------------|
| [04.04.2025](https://docs.google.com/viewer?url=https://github.com/Vladm0z/HSE-Bioinformatics/raw/main/Bioinformatics/MSc/SequenceDA/Lection_1.pdf) | 1) Overview lecture with introduction and course structure.<br>2) Rules.<br>3) Applications of Sequencing in various fields of knowledge. |
| 11.04.2025 | 1) Evolution of DNA Sequencing Methods<br>&nbsp;&nbsp;&nbsp;- Historical milestones<br>&nbsp;&nbsp;&nbsp;- Comparative analysis: Throughput, accuracy, read length, and cost trends over time.<br>&nbsp;&nbsp;&nbsp;- Emerging technologies: Single-molecule sequencing and epigenetic applications.<br>2) Sequencing Data File Formats<br>&nbsp;&nbsp;&nbsp;- BCL<br>&nbsp;&nbsp;&nbsp;- FASTQ<br>&nbsp;&nbsp;&nbsp;- FAST5<br>3) Platform-Specific Data Structures<br>4) Sequencing Quality Assessment & Error Correction:<br>&nbsp;&nbsp;&nbsp;- FastQC<br>&nbsp;&nbsp;&nbsp;- MultiQC<br>&nbsp;&nbsp;&nbsp;- Error Correction Tools<br>5) Read Alignment & Coverage Analysis:<br>&nbsp;&nbsp;&nbsp;- Short reads: BWA-MEM, Bowtie2.<br>&nbsp;&nbsp;&nbsp;- Long reads: Minimap2, NGMLR.<br>&nbsp;&nbsp;&nbsp;- samtools depth, mosdepth.<br>6) Reference Genomes and Model organisms<br>7) Mutation Databases<br>&nbsp;&nbsp;&nbsp;- ClinVar, COSMIC, gnomAD, dbSNP<br>8) NGS Platform Errors & Comparative Analysis:<br>&nbsp;&nbsp;&nbsp;- Substitution errors.<br>&nbsp;&nbsp;&nbsp;- PCR duplicates.<br>&nbsp;&nbsp;&nbsp;- Homopolymers.<br>&nbsp;&nbsp;&nbsp;- High indel rates. |
| 18.04.2025 | Introduction to Linux for Bioinformatics<br>- Why Linux?<br>- Core commands<br>- Hands-on examples. |
| 25.04.2025 | 1) Major Steps in Sample Preparation for WGS and WES.<br>2) Required Equipment and Reagents.<br>3) DNA and RNA Extraction Methods.<br>4) Quality assessment.<br>5) Nucleic Acid Purification and Ribosomal RNA (rRNA) Depletion.<br>6) Library Preparation (Fragmentation and Tagmentation). |
| 09.05.2025 | 1) Sanger Sequencing (First-Generation Sequencing)<br>2) Next-Generation Sequencing (NGS) Platforms:<br>&nbsp;&nbsp;&nbsp;- Solexa (Pre-2006) Sequencing<br>&nbsp;&nbsp;&nbsp;- Illumina (Post-2006) Sequencing<br>&nbsp;&nbsp;&nbsp;- Ion Torrent (Thermo Fisher Scientific) |
| 16.05.2025 | 454 Sequencing (Roche) - SOLiD Sequencing (Thermo Fisher Scientific) |
| 23.05.2025 | Third-Generation Sequencing (Single-Molecule Sequencing)<br>- PacBio SMRT Sequencing<br>- Oxford Nanopore Sequencing |
| 30.05.2025 | Emerging Sequencing Technologies<br>- Helicos Biosciences (True Single-Molecule Sequencing)<br>- BGI (DNBSEQ)<br>- Quantum Sequencing (Quantapore)<br>- Single-Molecule Fluorescence Sequencing (Genia, Stratos Genomics) |
| 06.06.2025 | Targeted sequencing methods and clinical applications (Exome, panels). Interesting cases from publications. |
| 13.06.2025 | Exam |


## Лекции
- [Лекция 1](https://docs.google.com/viewer?url=https://github.com/Vladm0z/HSE-Bioinformatics/raw/main/Bioinformatics/MSc/SequenceDA/Lection_1.pdf)
- [Лекция 2](https://disk.yandex.ru/d/z1g3QDc-WFmUtA/Lection_2)
- [Лекция 3](https://disk.yandex.ru/d/z1g3QDc-WFmUtA/Lection_3)
- [Лекция 4](https://disk.yandex.ru/d/z1g3QDc-WFmUtA/Lection_4)

## ДЗ

### ДЗ 1

In this task, you will analyze paired-end Illumina sequencing data (FASTQ files) by performing quality control, read filtering, alignment to the human reference genome, and BAM file processing.

In order to make it as easy as possible here You can find [colab](https://colab.research.google.com/drive/1cSaDs-e1vdLm5Zix5mBLBhDnaS0f0Jvs?usp=sharing) example. Yes, everything besides installation commands and fastqc – on You

You can find [assigned fastq files here](https://disk.yandex.ru/i/SrCF0L1GGjk7pg) and download them from [here (1000 genomes)](https://ftp-trace.ncbi.nih.gov/1000genomes/ftp/phase3/data/NA12878/sequence_read/).

1.
- Quality Control with FastQC
  -	Run FastQC on the raw FASTQ files (sample_R1.fastq.gz, sample_R2.fastq.gz).
  -	Examine the HTML reports to check:
  -	Per-base sequence quality.
  -	Adapter contamination.
  -	GC content distribution.
- Question:
  - Based on the FastQC report, what are the main quality issues in the raw reads?

2.
- Read Trimming (Optional but Recommended)
  -	Use Trimmomatic or FastP to remove adapters and low-quality bases.
  -	Compare the trimmed FASTQ files with the original ones. Use multiQC if applicable,
- Question:
  - How many reads were discarded during trimming? Did the overall quality improve?

3.
- Alignment to the Human Reference Genome (GRCh38)
  -	Index the reference genome (GRCh38.fa) using bwa index.
  -	Align the trimmed reads using bwa mem.
  -	Convert the output SAM file to a sorted BAM file (aligned_sorted.bam).
- Question:
  - What percentage of reads successfully aligned to the genome? (Use samtools flagstat.)

4.
- BAM File Processing & Analysis
  -	Mark PCR duplicates using samtools markdup.
  -	Calculate read coverage (samtools depth).
  -	(Optional) Perform variant calling (bcftools mpileup).

- Questions:
  -	Why is it important to mark PCR duplicates before variant calling?
  -	What regions of the genome have the highest/lowest coverage?

Expected Deliverables
  -	FastQC reports (raw and trimmed, if applicable).
  -	Trimmed FASTQ files (if trimming was performed).
  -	Sorted & indexed BAM file (aligned_sorted.bam).
  -	Coverage file (coverage.txt).
  -	(Optional) VCF file (variants.vcf) with potential variants.

Discussion & Critical Thinking Questions
- Data Quality:
  -	How did the FastQC results influence your decision to trim reads?
  -	Would you trust variant calls made from low-quality regions? Why or why not?
- Alignment & Duplicates:
  -	If only 60% of reads aligned, what could be possible reasons?
  -	How do PCR duplicates affect downstream analysis?

### ДЗ 2

1. Find the sequence for the first exon of the human gene for the [assigned protein](https://disk.yandex.ru/i/ZiDhSlyQaFT4Ww). You can check on proteins via UniProt.
2. Using the tips, directions and formulas indicated, choose two primer sequence, a forward and a reverse primer.
3. Use [eurofinsgenomics](https://eurofinsgenomics.eu/en/ecom/tools/oligo-analysis) and [genome.ucsc](https://genome.ucsc.edu/cgi-bin/hgPcr)  to analyze both of your primers. For each primer, take a screenshot of each analysis and include a caption that demonstrates why the analysis supports the use of this primer.
4. When you are done, write up a paragraph discussing why the criteria that go into primer design are important, and describing the process that you went through in designing your primer, including failed attempts (primers that did not meet criteria) and how you overcame them, what was the most challenging criteria to meet and why, etc. Please, provide your calculations. Automatic primer design alone will not be accepted.
-	Sequences of both primers
-	Sequence of target exon
-	Used formulas and calculations
-	In silico PCR results 


### Exam


1. Case Study: A biotech startup wants to use sequencing for personalized medicine but has limited funds. Compare WGS, WES, and targeted panels for their cost, coverage, and clinical utility. Recommend an approach.
2. Critical Analysis: "Long-read sequencing will replace short-read technologies." Defend or refute this statement using throughput, accuracy, and applications. 3. Hypothetical Scenario: Design a sequencing project to track antibiotic resistance in a hospital. Include sample types, technology choice, and analysis steps.
4. Ethics Debate: Should patients own their genomic data? Discuss privacy, commercialization, and research implications.
5. Agriculture: How can CRISPR-edited crops be validated using sequencing? Contrast NGS with Sanger.
6. Forensics: A cold case has degraded DNA. Would you use mitochondrial sequencing or SNP microarrays? Why?
7. Cancer: A tumor has low purity (<20%). How would scRNA-seq vs. bulk RNA-seq resolve heterogeneity?
8. Metagenomics: Compare 16S rRNA sequencing vs. shotgun metagenomics for gut microbiome studies.
9. FastQC: A FastQC report shows per-base quality drops at read ends. Is this problematic? How to fix?
10. MultiQC: A MultiQC report aggregates 10 samples. One sample has 50% duplicates. Interpret.
11. Case Study: A project has 10x coverage but high PCR duplicates. Propose wet-lab and computational solutions.
12. Case Study: A researcher has a 100GB FASTQ file and needs to count reads matching "ATGCN{10,}". How?
13. Permissions: A bioinformatics tool fails with "Permission denied." How to fix the issue?
14. Pipeline Debugging: A shell script with bwa | samtools crashes. How would you use intermediate files to debug?
15. Case Study: A WES kit captures only 60% of target regions. Propose wet-lab and bioinformatics fixes.
16. Comparative Design: Compare DNA shearing (sonication vs. enzymatic) for AT-rich genomes.
17. Contamination: A sample shows 5% microbial reads. Is this wet-lab contamination or analysis error? Diagnose.
18. FFPE Samples: Design a library prep protocol for degraded FFPE DNA versus fresh frozen.
19. Cost Analysis: Compare the cost per sample of manual vs. automated library prep (include reagent waste).
20. Troubleshooting: A qPCR quantification pre-library prep shows no amplification. List potential causes.
21. Automation: When would you choose a liquid handler over manual pipetting? Justify for a 1,000-sample study.
22. QC Tools: Contrast Bioanalyzer, TapeStation, and Qubit for DNA quality assessment.
23. Protocol Choice: Justify column-based vs. magnetic bead RNA extraction for single-cell sequencing.
24. Degradation: RNA samples have RIN=5. How does this impact transcript quantification? Mitigation strategies?
25. Inhibitors: Post-extraction PCR fails. Design an experiment to identify inhibitors (e.g., humic acids).
26. Low Input: Extract DNA from 10 cells. Address amplification bias risks.
27. Cross-Contamination: A negative control shows human reads. Propose a bioinformatics filter.
28. QC Metrics: Define "library complexity" and how to calculate it from sequencing data.
29. rRNA Depletion: Compare RiboZero vs. poly-A selection for bacterial RNA- seq.
30. Protocol Optimization: A ribodepletion kit leaves 15% rRNA. How to improve this?
31. Cost vs. Benefit: When is it worth using duplex sequencing to reduce errors? 32. FFPE Artifacts: Post-purification sequencing shows C>T artifacts. How to correct bioinformatically?
33. UMIS: Explain how UMIS correct for PCR duplicates mathematically.
34. Tagmentation: A Nextera reaction has high fragment size variability. Troubleshoot.
35. Low Diversity: Illumina fails due to low library diversity. Propose a spike-in solution.
36. Illumina Chemistry: Explain how reversible terminators cause phasing errors. 37. Ion Torrent: A homopolymer stretch (AAAAA) is called as 6x A. Is this a systematic error? Why?
38. BGI DNBSEQ: Contrast DNA nanoball technology with Illumina's bridge amplification.
39. Throughput Tradeoffs: Calculate expected runtime for NovaSeq 6000 S4 (20B reads) vs. NextSeq 2000 (4B reads).
40. Modern Use: When would you choose Sanger over NGS today?
41. Electropherogram: A Sanger trace shows overlapping peaks. Interpret.
42. Limitations: Why can't Sanger detect low-frequency variants (<20% allele fraction)?
43. Read Length: A 100kb Nanopore read maps to two human chromosomes. Interpret.
44. Error Profiles: PacBio has indel errors; Nanopore has substitution errors. How does this affect assembly?
45. Methylation: Design an experiment to compare Nanopore's 5mC detection with bisulfite-seq.
46. Throughput: Can PacBio Sequel II compete with Illumina for large-scale genomics? Justify.
47. True Single-Molecule: How does Helicos avoid amplification bias? What are the tradeoffs?
48. Quantum Sequencing: Explain how quantum tunneling could revolutionize base calling.
49. Synthetic Long Reads: How does 10x Genomics linked-read technology work?
50. Ethics Debate: Should quantum sequencing devices be regulated differently? Discuss.
