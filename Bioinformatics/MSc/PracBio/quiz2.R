setwd("C:\\Users\\vlad2\\Downloads")

data <- read.csv("dt3.csv")
library(ggplot2)

fit_lm <- lm(newborn..g. ~ gestation..mo., data = data)
fit_log <- lm(newborn..g. ~ log(gestation..mo.), data = data)
fit_exp <- lm(log(newborn..g.) ~ gestation..mo., data = data)
fit_poly <- lm(newborn..g. ~ poly(gestation..mo., 2), data = data)
fit_power <- lm(log(newborn..g.) ~ log(gestation..mo.), data = data)

# Function to calculate R^2 (for models with transformed Y)
calculate_r2 <- function(model, data, is_log = FALSE) {
  pred <- predict(model, data)
  if (is_log) pred <- exp(pred)
  ss_res <- sum((data$newborn..g. - pred)^2)
  ss_tot <- sum((data$newborn..g. - mean(data$newborn..g.))^2)
  1 - (ss_res / ss_tot)
}
model_metrics <- data.frame(
  Model = c("Linear", "Logarithmic", "Exponential", "Quadratic", "Power-Law"),
  R2 = c(
    summary(fit_lm)$r.squared,
    summary(fit_log)$r.squared,
    calculate_r2(fit_exp, data, is_log = TRUE),
    summary(fit_poly)$r.squared,
    calculate_r2(fit_power, data, is_log = TRUE)
  ),
  AIC = c(
    AIC(fit_lm),
    AIC(fit_log),
    AIC(fit_exp),
    AIC(fit_poly),
    AIC(fit_power)
  )
)

print(model_metrics)

gestation_range <- seq(min(data$gestation..mo.), max(data$gestation..mo.), length.out = 100)
new_data <- data.frame(gestation..mo. = gestation_range)

pred_lm <- predict(fit_lm, new_data)
pred_log <- predict(fit_log, new_data)
pred_exp <- exp(predict(fit_exp, new_data))
pred_poly <- predict(fit_poly, new_data)
pred_power <- exp(predict(fit_power, data.frame(gestation..mo. = log(gestation_range))))

# Plot
ggplot(data, aes(x = gestation..mo., y = newborn..g.)) +
  geom_point(alpha = 0.6) +
  geom_line(aes(y = pred_lm, color = "Linear"), data = new_data, size = 1) +
  geom_line(aes(y = pred_log, color = "Logarithmic"), data = new_data, size = 1) +
  geom_line(aes(y = pred_exp, color = "Exponential"), data = new_data, size = 1) +
  geom_line(aes(y = pred_poly, color = "Quadratic"), data = new_data, size = 1) +
  geom_line(aes(y = pred_power, color = "Power-Law"), data = new_data, size = 1) +
  scale_color_manual(values = c("red", "blue", "green", "purple", "orange")) +
  labs(
    x = "Gestation Duration (months)",
    y = "Newborn Weight (g)",
    title = "Comparison of Regression Models",
    color = "Model Type"
  ) +
  theme_minimal()