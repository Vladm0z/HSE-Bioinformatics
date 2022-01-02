---
title: "Ribosomal Protein L18"
author: "Vladislav Mozgovoy"
date: "12/17/2020"
output: 
      html_document:
        keep_md: true
---




### Цели : 

Все последующие действия требуется выполить для **ribosomal protein L18**

##### Задание 1:
  1. Измерить длину 3 водородных связей
  2. Между какими атомами есть связи
  3. Есть ли странные находки
  4. Каковы их длины
  5. Есть ли отличие от табличных значений
  
##### Задание 2:
  1. Найти второй ортолог
  2. Построить структурное выравнивание
  3. Найти значение RMSD
  4. Раскрасить мисмэтчи и индели


### Обработка:
#### Задание 1:
Рассмотрим **ribosomal protein L18**, в [RCSB PDB](https://www.rcsb.org/), у него есть 2 ортолога [1OVY](https://www.rcsb.org/structure/1OVY) и [1ILY](https://www.rcsb.org/structure/1ILY)\
Для 1 задания выберем **1OVY**\
<br/><br/>
Чтобы загрузить белок необходимо выполнить

```fetch
fetch 1OVY
```
<br/>
![](Pics\1OVY_1.png){width=30%}
<br/><br/>
Выберем альфа спираль

```ahelix
select helix, (ss h)
create ahelix, (helix)
```
<br/>
![](Pics\1OVY_2.png){width=30%}\
<br/><br/>
Отобразим водородные связи.\
Для этого выберем пункт в меню **[A] -> find -> polar contacts -> excluding solvent**\
<br/>
![](Pics\1OVY_3_1.png){width=30%}\
<br/><br/>
Отобразим длины водородных связей\
Для этого выберем водородные связи и нажмем **[S] -> show -> labels**\
Также отобразим спирали в ином виде **[S] -> show as -> sticks**, чтобы было ясно, что с чем соединяют водородные связи.\
<br/>
![](Pics\1OVY_4_3.png){width=35%}\
<br/><br/>
Найдем длины 3 водородных связей:

```get_distance
get_distance /ahelix/A/A/ARG`84/O, /ahelix/A/A/LYS`88/H
get_distance /ahelix/A/A/ARG`84/H, /ahelix/A/A/LEU`80/O
get_distance /ahelix/A/A/ALA`85/C, /ahelix/A/A/GLU`87/C
```
<br/>
![](Pics\1OVY_5_1.png){width=30%}
![](Pics\1OVY_5_2.png){width=30%}
![](Pics\1OVY_5_3.png){width=30%}\
<br/><br/><br/>

##### Ответы на вопросы:
  1. H-H, H-O, O-O
  2. Нет, все измеренные расстояния совпадают с табличными значениями
  3. 3 рассмотренных участка имеют длины 2.596, 2.217, 2.329, все остальные участки лежат в диапазоне между 1.7 и 2.7
  4. Нет, не отличаются
  5. На PyMOLWiki можно найти страницу о программе [get_raw_distances](https://pymolwiki.org/index.php/Get_raw_distances), тогда, запустив ее, мы можем использовать функцию **get_mean_distance ahelix_polar_conts** и получить среднюю длину связи. В нашем случае она равна 2.2 при 33 связях.

```get_raw_distances
run get_raw_distances
get_mean_distance ahelix_polar_cont
```
<br/>
![](Pics\1OVY_8.png){width=80%}
<br/><br/><br/>

#### Задание 2:
  1. Возьмем для этого задания [1ILY](https://www.rcsb.org/structure/1ILY)
  2. Вполним команду **Plugin -> Alignment**

```align
align 1ILY, 1OVY, object=alnobj
```
  3. RMSD = 3.433
  4. Раскрасим мисмэтчи красным (части 1ILY) и желтым (части 1OVY) и индели фиолетовым\
<br/>
<center>
![](Pics\1OVY_7.png){width=100%}
</center>

  
