# Atividade 4 - Filtragem dos dados
# filtrar os dados do datset do pokemon com os pokemons que possuem bee ou saur
# no nome.

library(dplyr)
library(lubridate)
library(stringr)

dados <- read.csv("Dados/Pokemon_full.csv")
head(dados) #? vê as primeiras linhas de dados

dados %>% filter(grepl("bee", name) | grepl("saur", name))

df_bee_e_saur_nome <- dados %>% filter(grepl("bee", name) | grepl("saur", name))
df_bee_e_saur_nome

# Podemos observar que há 7 opçoes para o filtro desejado.

