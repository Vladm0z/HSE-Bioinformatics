# Практическая Биоинформатика

#### Аннотация
Курс охватывает базы данных и основные сервисы и программы для обработки биологических последовательностей, а также молекулярную филогению, семейства и домены белков, базы данных по структурам белков и РНК. В цели курса входит научить студентов использовать основные биологические базы данных, в том числе содержащие геномную, структурную и другую информацию, в научно-исследовательской работе; овладеть базовыми средствами анализа геномной, структурной и другой биологической информации. Курс развивает ключевые знания и компетенции в биоинформатических задачах и позволит успешно работать с любыми типами биологических данных, которые будут встречаться в следующих курсах модуля.

[ПУД](https://www.hse.ru/edu/courses/900085705) (пока пустой, [хотя быть таким не должен](https://www.hse.ru/studyspravka/programmauchdisc))

## Лекции
- [Лекция 1](https://docs.google.com/viewer?url=https://github.com/Vladm0z/HSE-Bioinformatics/raw/main/Bioinformatics/MSc/PracBio/PB_Lec1.pdf)
- [Лекция 4](https://docs.google.com/viewer?url=https://github.com/Vladm0z/HSE-Bioinformatics/raw/main/Bioinformatics/MSc/PracBio/PB_Lec4.pdf)
- [Лекция 5](https://docs.google.com/viewer?url=https://github.com/Vladm0z/HSE-Bioinformatics/raw/main/Bioinformatics/MSc/PracBio/PB_Lec5.pdf)
- [Лекция по GWAS](https://docs.google.com/viewer?url=https://github.com/Vladm0z/HSE-Bioinformatics/raw/main/Bioinformatics/MSc/PracBio/Post-GWAS-1_30.09.2024.pdf)
- [GWAS tutorial](https://pbreheny.github.io/adv-gwas-tutorial/quality_control.html#fam)
- [BLAST](https://blast.ncbi.nlm.nih.gov/Blast.cgi)

## Домашние Задания
### HW1
##### Задание 1
Определить APOE статус и риск болезни Альцгеймера для полногеномного сиквенса с помощью IGV.
[BAM (70Гб)](https://storage.yandexcloud.net/genotek-testing/data/vi0006/vi0006.markdup.hg19.bam?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=wgMztS8ws2HPY6sgnw38%2F20240910%2Fru-central1%2Fs3%2Faws4_request&X-Amz-Date=20240910T170208Z&X-Amz-Expires=864000&X-Amz-Signature=673FB8F2B3259D4A5F2326BD88BD7980B1D508D1A2F55075379BF61BD2A6AF69&X-Amz-SignedHeaders=host)
[BAI](https://storage.yandexcloud.net/genotek-testing/data/vi0006/vi0006.markdup.hg19.bai?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=wgMztS8ws2HPY6sgnw38%2F20240910%2Fru-central1%2Fs3%2Faws4_request&X-Amz-Date=20240910T170237Z&X-Amz-Expires=864000&X-Amz-Signature=955B8DC66CC6C474038D2DFF1D90E354CA9F21D631C6901B1AB032218143BA74&X-Amz-SignedHeaders=host)

##### Задание 2
Найти человека с синдромом Клайнфельтера. Использовать долю прочтений для X, Y хромосомы. Визуализировать образцы на графике.
[Data](https://drive.google.com/file/d/1y4EX5VJBc5ZzAWVECgbhZMGMP7EzSRqt/view?usp=drive_link)

##### Задание 3
Определить сборку BAM (на какой из референсных геномов производилось выравнивание).
[Data](https://drive.google.com/file/d/1yBwfSk_-UkrYXF3zkjf8hAv-YlD8XNhV/view?usp=drive_link)

##### Задание 4
Из BAM файла получить BED файл с регионами, покрытие которых 10 и более. С помощью bedtools определить, какая доля гена APOE имеет покрытие x10+.
[Data](https://drive.google.com/file/d/1y6mscgydlMXj96c0m3xV3kHSci2a498n/view?usp=drive_link)

##### Задание 5
Определить сборку (референсный геном) VCF файла.
[Data](https://drive.google.com/file/d/1tB5_aX_PHTfgJBOxrBBgURkVGfd2gtAq/view?usp=drive_link)

##### Задание 6
Попарно сравнить генотипы для 3 образцов с помощью bcftools. Сделать выводы о родстве.
[Data](https://drive.google.com/file/d/1yKQC_qn8sDhyflKWvAQpYyDbBiTPvuv4/view?usp=drive_link)

##### Задание 7
Рассчитать частоты генетических вариантов для трех популяций (AFR, EUR, SAS) и построить scatterplot попарно между популяциями (ось Х – частота в первой популяции, ось Y – частота во второй популяции, точка – генетический вариант с соответствующими частотами)
[Data](https://drive.google.com/file/d/1yMDb2JGcMfaZ8T6oHVJRB2EPjq3dGos5/view?usp=drive_link)


[пример выполненной работы](https://colab.research.google.com/drive/1Re9ICj2SAEqcDrvhP-rtJgg-LgfydNbZ?usp=sharing)



### HW2

Исправить ошибки первого ДЗ

### HW3
[Мануалы + условия](https://github.com/michtrofimov/hse_data_analysis_MSA/blob/master/README.md#%D0%B4%D0%BE%D0%BC%D0%B0%D1%88%D0%BD%D0%B5%D0%B5-%D0%B7%D0%B0%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5)




