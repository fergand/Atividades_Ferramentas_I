# Atividade 7 - corrigindo gráficos

library(ggplot2)
library(tidyr)
library(dplyr)
library(rcartocolor)
library(ggthemes)

dados <- read.csv("./Dados/Pokemon_full.csv")
head(dados)


# Gráfico da média da altura

dados %>%
  group_by(type) %>% 
  summarise(
    media_h = mean(height),
    media_w = mean(weight)
  ) %>% 
  ggplot()+
  geom_col(aes(x = type, y = media_h))+
  labs(
    x = "Tipo do Pokemon",
    y = "Média Altura"
  )+
  theme(
    axis.title = element_text(size = 18, face = "bold"),
    axis.text.y = element_text(size = 14),
    axis.text.x = element_text(size = 14, angle = 45, hjust = 1.0),
    legend.title = element_text(size = 15, face = "bold")
  )


# Gráfico da média da altura e do peso


dados %>%
  group_by(type) %>% 
  summarise(
    media_h = mean(height),
    media_w = mean(weight)
  ) %>%
  tidyr::pivot_longer(cols = c("media_h", "media_w"), names_to = "tipo", values_to = "media") %>% 
  ggplot()+
  geom_col(aes(x = type, y = media, color = tipo)) +
  labs(x = "Tipo do pokemon", y = "Média")+
  scale_colour_brewer(palette = "Set1", labels = c("Média altura", "Média peso"), name = "Medida")+
  scale_fill_brewer(palette = "Set1", labels = c("Média altura", "Média peso"), name = "Medida")+
  theme(axis.text.x = element_text(angle = 45))


# Separando em duas colunas o gráfico anterior
df <- dados %>%
  group_by(type) %>% 
  summarise(
    media_h = mean(height),
    media_w = mean(weight)
  ) 

fator <- max(df$media_w)/max(df$media_h)
fator

df$media_h <- df$media_h*fator

df %>% 
  tidyr::pivot_longer(cols = c("media_h", "media_w"), names_to = "tipo", values_to = "media") %>% 
  ggplot()+
  geom_col(aes(x = type, y = media, color = tipo, fill = tipo), position = position_dodge2())+
  scale_y_continuous(
    
    # Features of the first axis
    name = "Média peso",
    
    # Add a second axis and specify its features
    sec.axis = sec_axis(~./fator, name="Média altura"),
    expand = c(0,0)
  )+
  labs(x = "Tipo do pokemon")+
  scale_color_brewer(palette = "Set1", labels = c("Média altura", "Média peso"), name = "Medidas")+
  scale_fill_brewer(palette = "Set1", labels = c("Média altura", "Média peso"), name = "Medidas")+
  theme_bw()+
  theme(
    axis.title = element_text(size = 18, face = "bold"),
    axis.text.y = element_text(size = 12),
    axis.text.x = element_text(size = 12, angle = 45, hjust = 1.0),
    legend.title = element_text(size = 12, face = "bold")
  )

