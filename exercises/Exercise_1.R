# Paket laden 
library(tidyverse)

data <- read_csv("data/data_referendum.csv")

data <- data %>%
  select(Periode, 
         `Obligatorisches Referendum Total`, 
         `Fakultatives Referendum Total`, 
         `Volksinitiative Total`)

# Periode bereinigen und in Integer umwandeln
data <- data %>%
  mutate(
    Periode = str_replace(Periode, "Jahr: ", ""),
    Periode = as.integer(Periode)
  )

# Daten ins Long-Format umwandeln
data_long <- data %>%
  pivot_longer(cols = -Periode, 
               names_to = "Kategorie", 
               values_to = "Wert")

# Liniendiagramm zeichnen
ggplot(data_long, aes(x = Periode, y = Wert, fill = Kategorie)) +
  geom_col(position = "stack") +
  labs(title = "Entwicklung der Volksrechte über die Jahre",
       x = "Jahr",
       y = "Anzahl") +
  theme_minimal()
