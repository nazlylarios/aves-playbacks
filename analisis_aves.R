# Paquetes (instalar una sola vez):
# install.packages(c("tidyverse", "lme4", "lmerTest"))

library(tidyverse)
library(lme4)
library(lmerTest)

datos <- read.csv("datos/palomas2.csv")

datos_wide <- datos %>%
  pivot_wider(names_from = momento,
              values_from = c(abundancia_ind, riqueza_sp)) %>%
  mutate(
    delta_riqueza = riqueza_sp_despues - riqueza_sp_antes,
    delta_abundancia = abundancia_ind_despues - abundancia_ind_antes
  )

###riqueza
modelo_riqueza <- lmer(delta_riqueza ~ tratamiento * habitat + (1|punto),
                       data = datos_wide)

summary(modelo_riqueza)

datos_wide$tratamiento <- recode(datos_wide$tratamiento,
                                 "tecolote" = "Tecolote",
                                 "halcon" = "Halcón",
                                 "aguililla" = "Aguililla")

ggplot(datos_wide, aes(x = tratamiento, y = delta_riqueza, fill = habitat)) +
  geom_boxplot() +
  geom_jitter(width = 0.1, size = 2) +
  theme_minimal()

ggplot(datos_wide, aes(x = tratamiento, y = delta_riqueza, fill = habitat)) +
  geom_boxplot(alpha = 0.8) +
  geom_jitter(width = 0.1, size = 2, alpha = 0.7) +
  scale_fill_manual(values = c("abierto" = "#a1d99b", 
                               "cerrado" = "#006d2c")) +
  labs(
    x = "Tipo de depredador",
    y = "Cambio en riqueza de especies (ΔS)",
    fill = "Hábitat"
  ) +
  theme_minimal(base_size = 14)

###abundancia

modelo_abund <- lmer(delta_abundancia ~ tratamiento * habitat + (1|punto),
                     data = datos_wide)

summary(modelo_abund)

ggplot(datos_wide, aes(x = tratamiento, y = delta_abundancia, fill = habitat)) +
  geom_boxplot(alpha = 0.8) +
  geom_jitter(width = 0.1, size = 2, alpha = 0.7) +
  scale_fill_manual(values = c("abierto" = "#a1d99b", 
                               "cerrado" = "#006d2c")) +
  labs(
    x = "Tipo de depredador",
    y = "Cambio en abundancia de individuos (ΔN)",
    fill = "Hábitat"
  ) +
  theme_minimal(base_size = 14)

###
#juntas

datos_long <- datos_wide %>%
  select(punto, habitat, tratamiento, delta_riqueza, delta_abundancia) %>%
  pivot_longer(cols = c(delta_riqueza, delta_abundancia),
               names_to = "variable",
               values_to = "valor")

ggplot(datos_long, aes(x = tratamiento, y = valor, fill = habitat)) +
  geom_boxplot() +
  facet_wrap(~variable, scales = "free_y") +
  scale_fill_manual(values = c("abierto" = "#a1d99b", 
                               "cerrado" = "#006d2c")) +
  theme_minimal()

###

cor(datos_wide$delta_riqueza, datos_wide$delta_abundancia)


####descriptiva

datos_palomas <- read.csv("datos/pinchespalomas.csv")
head(datos_palomas)
str(datos_palomas)

datos_palomas <- datos_palomas %>%
  mutate(
    habitat = as.factor(habitat),
    tratamiento = as.factor(tratamiento),
    punto = as.factor(punto),
    especie = as.factor(especie)
  )

abund_total <- datos_palomas %>%
  group_by(habitat, tratamiento) %>%
  summarise(
    antes = sum(cantos_antes),
    despues = sum(cantos_despues),
    .groups = "drop"
  )

abund_total

riqueza <- datos_palomas %>%
  group_by(habitat, tratamiento) %>%
  summarise(
    riqueza_antes = sum(cantos_antes > 0),
    riqueza_despues = sum(cantos_despues > 0),
    .groups = "drop"
  )

riqueza

cambios <- abund_total %>%
  left_join(riqueza, by = c("habitat", "tratamiento")) %>%
  mutate(
    delta_abund = despues - antes,
    delta_riqueza = riqueza_despues - riqueza_antes
  )

cambios

top_especies <- datos_palomas %>%
  mutate(total = cantos_antes + cantos_despues) %>%
  group_by(especie) %>%
  summarise(total = sum(total)) %>%
  arrange(desc(total))

top_especies
top5 <- top_especies %>% slice_max(total, n = 5)
top5

respuesta_especies <- datos_palomas %>%
  mutate(delta = cantos_despues - cantos_antes) %>%
  group_by(especie) %>%
  summarise(
    cambio_promedio = mean(delta),
    total = sum(cantos_antes + cantos_despues)
  ) %>%
  arrange(desc(cambio_promedio))
respuesta_habitat <- datos_palomas %>%
  mutate(delta = cantos_despues - cantos_antes) %>%
  group_by(especie, habitat) %>%
  summarise(delta = mean(delta), .groups = "drop")

total_aves <- sum(datos_palomas$cantos_antes) + sum(datos_palomas$cantos_despues)

total_aves
total_especies <- n_distinct(datos_palomas$especie)

total_especies

especies_antes <- datos_palomas %>%
  filter(cantos_antes > 0) %>%
  summarise(n = n_distinct(especie))

especies_despues <- datos_palomas %>%
  filter(cantos_despues > 0) %>%
  summarise(n = n_distinct(especie))

especies_antes
especies_despues
