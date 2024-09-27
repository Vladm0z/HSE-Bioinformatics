# Устанавливаем дирректорию\
setwd("C:/Users/vlad2/Documents/GitHub/HSE-Bioinformatics/Bioinformatics/MSc/introR")
getwd()

# 1. Загрузка данных
# Чтение данных из текстового файла с указанием заголовков столбцов и разделителя
data <- read.table("hw1.txt", header = TRUE, sep = "")
print(colnames(data))  # Вывод имен столбцов для проверки правильности данных

# 2. Визуализация распределений генов
# Построение графиков плотности для всех генов
plot(density(data$htVWQ), main="Графики плотности генов", ylab="Плотность", xlab="Экспрессия", col="green", lwd=2)
lines(density(data$RMD4), col="red", lwd=2)  # Добавление плотности для гена RMD4
lines(density(data$CPY14), col="blue", lwd=2)  # Добавление плотности для гена CPY14
legend("topright", legend=c("Ген htVWQ", "Ген RMD4", "Ген CPY14"), col=c("green", "red", "blue"), lwd=2)

# Установить рабочую директорию на папку с R-скриптом
setwd(dirname(rstudioapi::getActiveDocumentContext()$path/results))

# Сохранение графика плотностей в файл
png("gene_density_plot.png")
plot(density(data$htVWQ), main="Графики плотности генов", ylab="Плотность", xlab="Экспрессия", col="green", lwd=2)
lines(density(data$RMD4), col="red", lwd=2)
lines(density(data$CPY14), col="blue", lwd=2)
legend("topright", legend=c("Ген htVWQ", "Ген RMD4", "Ген CPY14"), col=c("green", "red", "blue"), lwd=2)
dev.off()  # Закрытие файла для сохранения графика

# 3. Проверка корреляций между парами генов (Спирмен)
# Расчет коэффициентов корреляции Спирмена между парами генов
correlation_test_12 <- cor.test(data$CPY14, data$RMD4, method = "spearman")
correlation_test_23 <- cor.test(data$RMD4, data$htVWQ, method = "spearman")
correlation_test_31 <- cor.test(data$htVWQ, data$CPY14, method = "spearman")

# Вывод результатов корреляции
print(paste("Корреляция между CPY14 и RMD4: rho =", correlation_test_12$estimate, "p-value =", correlation_test_12$p.value))
print(paste("Корреляция между RMD4 и htVWQ: rho =", correlation_test_23$estimate, "p-value =", correlation_test_23$p.value))
print(paste("Корреляция между htVWQ и CPY14: rho =", correlation_test_31$estimate, "p-value =", correlation_test_31$p.value))

# Интерпретация:
# Так как распределения не являются нормальными, была использована корреляция Спирмена для оценки
# степени монотонной зависимости между парами генов. Из результатов видно, что значимой корреляцией 
# обладает только пара CPY14 и RMD4 (p-value < 0.05), что свидетельствует о значимой связи между ними.

# 4. Проверка различий в средней экспрессии (t-тест)
# Выполнение парных t-тестов для проверки отличий между средними значениями экспрессий генов
t_test_12 <- t.test(data$CPY14, data$RMD4, paired = TRUE)
t_test_23 <- t.test(data$RMD4, data$htVWQ, paired = TRUE)
t_test_31 <- t.test(data$htVWQ, data$CPY14, paired = TRUE)

# Вывод результатов t-тестов
print(paste("Тест CPY14 vs RMD4: p-value =", t_test_12$p.value))
print(paste("Тест RMD4 vs htVWQ: p-value =", t_test_23$p.value))
print(paste("Тест htVWQ vs CPY14: p-value =", t_test_31$p.value))

# Интерпретация:
# Парный t-тест был использован для проверки различий в средней экспрессии генов. 
# Результаты показывают, что статистически значимыми (p-value < 0.05) являются различия между 
# экспрессией генов htVWQ и CPY14, что позволяет отвергнуть нулевую гипотезу о равенстве средних.

# 5. Линейная регрессия
# Построение линейной модели между CPY14 и RMD4
model_12 <- lm(data$CPY14 ~ data$RMD4)

# Визуализация регрессии
plot(data$RMD4, data$CPY14, main="Регрессия: CPY14 и RMD4", xlab="RMD4", ylab="CPY14")
abline(model_12, col='green', lwd=2)

# Сохранение графика регрессии
png("regression_CPY14_RMD4.png")
plot(data$RMD4, data$CPY14, main="Регрессия: CPY14 и RMD4", xlab="RMD4", ylab="CPY14")
abline(model_12, col='green', lwd=2)
dev.off()  # Сохранение файла

# 6. Сохранение результатов анализа в текстовые файлы
# Создание датафрейма с результатами корреляций и t-тестов
results_corr <- data.frame(
  gene_1 = c("CPY14", "RMD4", "htVWQ"),
  gene_2 = c("RMD4", "htVWQ", "CPY14"),
  spearman_rho = c(correlation_test_12$estimate, correlation_test_23$estimate, correlation_test_31$estimate),
  spearman_p_value = c(correlation_test_12$p.value, correlation_test_23$p.value, correlation_test_31$p.value)
)

results_t_test <- data.frame(
  gene_1 = c("CPY14", "RMD4", "htVWQ"),
  gene_2 = c("RMD4", "htVWQ", "CPY14"),
  t_test_p_value = c(t_test_12$p.value, t_test_23$p.value, t_test_31$p.value)
)

# Сохранение результатов корреляции и t-тестов в текстовые файлы
write.table(results_corr, file="gene_pairs_corr_results.txt", sep="\t", row.names=FALSE, col.names=TRUE)
write.table(results_t_test, file="gene_pairs_ttest_results.txt", sep="\t", row.names=FALSE, col.names=TRUE)

print("Результаты записаны в файлы gene_pairs_corr_results.txt и gene_pairs_ttest_results.txt")

# 7. Визуализация коробочных диаграмм для пар генов
# Построение коробочных диаграмм для сравнения экспрессии между генами
boxplot(data$CPY14, data$RMD4, names=c("CPY14", "RMD4"), main="Сравнение коробочных диаграмм: CPY14 и RMD4", ylab="Экспрессия")

# Сохранение коробочной диаграммы
png("boxplot_CPY14_RMD4.png")
boxplot(data$CPY14, data$RMD4, names=c("CPY14", "RMD4"), main="Сравнение коробочных диаграмм: CPY14 и RMD4", ylab="Экспрессия")
dev.off()

# Очистка рабочей среды
rm(list = ls())  # Очистка всех переменных
dev.off(dev.list()["RStudioGD"])  # Закрытие графических окон
