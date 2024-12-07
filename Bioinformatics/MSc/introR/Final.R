# 4
# Условия
# датасет Indometh
# визуализируйте данные
# постройте модель, которая бы предсказывала концентрацию вещества.
# постарайтесь добиться наилучшего качества модели. разные признаки и их комбинации.
# возможно, полином (poly) или какая-то другая функция над каким-то признаком
# сделайте выводы


# Загрузим Indometh
library(datasets)
data("Indometh")
str(Indometh)
summary(Indometh)

# Визуализируем данные
library(ggplot2)

ggplot(Indometh, aes(x = time, y = conc, color = factor(Subject))) +
  geom_point() +
  geom_line() +
  labs(title = "Indometh Concentration Over Time",
       x = "Time (hours)",
       y = "Concentration (mg/L)",
       color = "Subject") +
  theme_minimal()

# Построим модель предсказывающую концентрацию
# (пока линейную)
model_lm <- lm(conc ~ time, data = Indometh)
summary(model_lm)
# Residual standard error: 0.4486
# Multiple R-squared:  0.5048,	Adjusted R-squared:  0.497

# Построим график
plot(model_lm, which = 1)

# постарайтесь добиться наилучшего качества модели. разные признаки и их комбинации.
# возможно, полином (poly) или какая-то другая функция над каким-то признаком

# Попробуем полином
model_poly <- lm(conc ~ poly(time, 2), data = Indometh)
summary(model_poly)
# esidual standard error: 0.3378
# Multiple R-squared:  0.7236,	Adjusted R-squared:  0.7149 

# Сравним модели
anova(model_lm, model_poly)

# Построим график
Indometh$predicted <- predict(model_poly)
ggplot(Indometh, aes(x = time, y = conc)) +
  geom_point() +
  geom_line(aes(y = predicted), color = "blue") +
  labs(title = "Polynomial Regression Fit", x = "Time", y = "Concentration")


# Попробуем другие подходы
# Log
Indometh$log_conc <- log(Indometh$conc)
model_log <- lm(log_conc ~ time, data = Indometh)
summary(model_log)

# График
Indometh$log_pred <- exp(predict(model_log))
ggplot(Indometh, aes(x = time, y = conc)) +
  geom_point() +
  geom_line(aes(y = log_pred), color = "blue") +
  labs(title = "Log-Transformed Linear Model Fit", x = "Time", y = "Concentration")

# Exp
exp_model <- nls(conc ~ a * exp(-b * time), data = Indometh, start = list(a = 2, b = 0.2))
summary(exp_model)

# График
Indometh$exp_pred <- predict(exp_model)
ggplot(Indometh, aes(x = time, y = conc)) +
  geom_point() +
  geom_line(aes(y = exp_pred), color = "red") +
  labs(title = "Exponential Decay Model Fit", x = "Time", y = "Concentration")


# Выводы, статистика и график:

Indometh$lm_pred <- predict(model_lm)
Indometh$poly_pred <- predict(model_poly)
Indometh$log_pred <- exp(predict(model_log))
Indometh$exp_pred <- predict(exp_model)

# Статистика
stats <- data.frame(
  Model = c("Linear", "Polynomial", "Log-Linear", "Exponential Decay"),
  RSS = c(
    sum((Indometh$conc - Indometh$lm_pred)^2),
    sum((Indometh$conc - Indometh$poly_pred)^2),
    sum((Indometh$conc - Indometh$log_pred)^2),
    sum((Indometh$conc - Indometh$exp_pred)^2)
  ),
  Adj_R2 = c(
    summary(model_lm)$adj.r.squared,
    summary(model_poly)$adj.r.squared,
    summary(model_log)$adj.r.squared,
    1 - sum((Indometh$conc - Indometh$exp_pred)^2) / sum((Indometh$conc - mean(Indometh$conc))^2) # Manually calculated
  ),
  AIC = c(
    AIC(model_lm),
    AIC(model_poly),
    AIC(model_log),
    AIC(exp_model)
  )
)

# Результаты
print(stats)

# Финальный График
ggplot(Indometh, aes(x = time, y = conc)) +
  geom_point(color = "black", size = 2, alpha = 0.7) +
  geom_line(aes(y = lm_pred, color = "Linear Model"), linewidth = 1) +
  geom_line(aes(y = poly_pred, color = "Polynomial Model"), linewidth = 1, linetype = "dashed") +
  geom_line(aes(y = log_pred, color = "Log-Linear Model"), linewidth = 1, linetype = "dotted") +
  geom_line(aes(y = exp_pred, color = "Exponential Decay Model"), linewidth = 1, linetype = "dotdash") +
  labs(title = "Model Comparisons", x = "Time", y = "Concentration") +
  scale_color_manual(
    values = c("Linear Model" = "blue", 
               "Polynomial Model" = "green", 
               "Log-Linear Model" = "purple", 
               "Exponential Decay Model" = "red")
  ) +
  theme_minimal()

# Как мы видим, exponential decay оказался самым хорошим подходом




# 6
# Напишите функцию которая визуализирует числовую таблицу при помощи символов разного размера
# Как image, но вместо цветных квадратов — точки разного размера.
# Для каждой ячейки таблицы рисуется символ с размером пропорциональным значению в ячейке таблицы.
# Размер (cex) максимального и минимального символа — параметры ) максимального и минимального символа — параметры функции.


# Функция
visualize_table <- function(table, min_cex = 0.5, max_cex = 2) {
  if (is.null(table) || length(table) == 0) {
    message("Table is empty")
    return(NULL)
  }
  
  if (nrow(table) == 0 || ncol(table) == 0) {
    message("Table has zero rows/columns")
    return(NULL)
  }
  
  # Missing values
  if (any(is.na(table))) {
    table[is.na(table)] <- 0
  }
  
  # Нормирование значений
  norm_values <- (table - min(table, na.rm = TRUE)) / (max(table, na.rm = TRUE) - min(table, na.rm = TRUE))
  
  # График
  plot(1:ncol(table), 1:nrow(table), type = "n",
       xlab = "", ylab = "", xaxt = "n", yaxt = "n")
  axis(1, at = 1:ncol(table), labels = colnames(table))
  axis(2, at = 1:nrow(table), labels = rownames(table), las = 2)
  
  for (i in 1:nrow(table)) {
    for (j in 1:ncol(table)) {
      cex_val <- min_cex + norm_values[i, j] * (max_cex - min_cex)
      points(j, i, cex = cex_val, pch = 16)
    }
  }
}

# Проверка
# Пустая таблица
empty_table <- matrix(nrow = 0, ncol = 0)
visualize_table(empty_table)

# 1x1
single_element_table <- matrix(42, nrow = 1, ncol = 1)
visualize_table(single_element_table, min_cex = 1, max_cex = 3)

# NA -> 0
table_with_na <- matrix(c(10, NA, 30, 40), nrow = 2)
visualize_table(table_with_na, min_cex = 0.5, max_cex = 2)

# Нормальный случай
example_table <- matrix(runif(25, 1, 100), nrow = 5)
rownames(example_table) <- paste("Row", 1:5)
colnames(example_table) <- paste("Col", 1:5)
visualize_table(example_table, min_cex = 0.5, max_cex = 2)
