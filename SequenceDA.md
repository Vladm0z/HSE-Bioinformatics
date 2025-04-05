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


#### Лекции
- [Лекция 1](https://docs.google.com/viewer?url=https://github.com/Vladm0z/HSE-Bioinformatics/raw/main/Bioinformatics/MSc/SequenceDA/Lection_1.pdf)
