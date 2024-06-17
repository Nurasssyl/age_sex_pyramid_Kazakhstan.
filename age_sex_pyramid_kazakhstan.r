
library(ggplot2)
library(dplyr)
library(readr)
library(tidyr)

# Define the file path
file_path <- "C:/Users/User/Desktop/R/sex-age-pyramid.csv"

# Read the CSV data
data <- read_csv(file_path)

data_long <- data %>%
  pivot_longer(cols = c(Man, Woman), names_to = "Sex", values_to = "Population") %>%
  mutate(Sex = ifelse(Sex == "Man", "Мужчина", "Женщина"),
         Population = as.numeric(gsub(",", "", Population)),
         Population = ifelse(Sex == "Мужчина", -Population, Population))

ggplot(data_long, aes(x = Age, y = Population, fill = Sex)) +
  geom_bar(stat = "identity", width = 0.8) +
  coord_flip() +
  scale_y_continuous(labels = abs) +
  labs(title = "Возрастно-половая пирамида Казахстана",
       x = "Возрастная группа",
       y = "Население",
       fill = "Пол") +
  theme_minimal() +
  theme(text = element_text(family = "Times New Roman"))

ggsave("C:/Users/User/Desktop/R/age_sex_pyramid_kazakhstan.jpeg", plot = last_plot(), width = 10, height = 7)
