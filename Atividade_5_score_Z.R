# Atividade 5 - Média da altura do peso por tipo e transformação z-score

library(dplyr)
library(lubridate)
library(stringr)

dados <- read.csv("Dados/Pokemon_full.csv")
head(dados)

# Calculando a média da altura do peso por tipo de Pokemon
dados %>%
  group_by(type) %>%
  summarise(
    media_altura = mean(height),
    media_peso = mean(weight),
    N = n()
  ) %>%
  arrange(media_altura)

# Filtrar os pokemons que tem o peso acima da média do seu type

df <- dados %>% 
  group_by(type) %>% 
  mutate(
    media_peso = mean(weight)
  ) %>% filter( weight > media_peso
  )
df

# criar uma coluna com a transformação Z-score para altura POR type utilizando 
# TODAS as variáveis quantitativas.

# Filtrando o conjunto de dados fornecido com as variáveis quantitativas temos:

df_filtrado <- dados %>% 
  select(where(is.numeric))
df_filtrado %>% names()

df_zscore <- dados %>% 
  mutate(
    z_height = (height - mean(height))/sd(height),
    z_weight = (weight - mean(weight))/sd(weight),
    z_hp = (hp - mean(hp))/sd(hp),
    z_attack = (attack - mean(attack))/sd(attack),
    z_defense = (defense - mean(defense))/sd(defense),
    z_sp.atk = (sp.atk - mean(sp.atk))/sd(sp.atk),
    z_sp.def = (sp.def - mean(sp.def))/sd(sp.def),
    z_speed = (speed - mean(speed))/sd(speed)
  ) %>% select(-height,-weight,-hp,-attack,-defense,-sp.atk,-sp.def,-speed)
df_zscore

