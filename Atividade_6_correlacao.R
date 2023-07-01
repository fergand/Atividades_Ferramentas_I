# Atividade 6 - Calculo da correlaçao

library(dplyr)
library(lubridate)
library(stringr)
library(tidyr)

dados <- readr::read_rds("Atividades/Dados/imdb.rds")

df <- dados %>% 
  select(titulo, orcamento, receita, receita_eua)
df

# Vamos calcular a correlação entre os dados. No entanto, só é possível para os 
# casos com os dados completos, desta forma, precisamos filtrar os dados que 
# estejam completos.

df_filtrado <- df %>% select(where(is.numeric)) %>% 
  filter(complete.cases(.))

cor(df_filtrado)
