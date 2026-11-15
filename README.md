# Cuando el miedo canta: respuesta de las aves a depredadores según el hábitat

Proyecto de la materia **Ecología de Bosques Tropicales Fragmentados** (Maestría en Ciencias Biológicas, UNAM), realizado en equipo con Estrella Flores-Flores y J. Alfredo Rodríguez.

## Pregunta

¿El comportamiento antidepredador de las aves (acoso con vocalizaciones vs. silencio) depende del **tipo de depredador** y del **tipo de hábitat**?

## Diseño experimental

- Dos hábitats: **dosel abierto** y **dosel cerrado**.
- Playbacks de tres aves rapaces con distintos hábitos de caza:
  - Tecolote — *Glaucidium brasilianum*
  - Halcón — *Micrastur semitorquatus*
  - Aguililla — *Rupornis magnirostris*
- En cada punto se registraron los individuos y especies que vocalizaban **antes y después** del playback.

## Análisis (R)

- Cálculo del cambio en abundancia (ΔN) y en riqueza de especies (ΔS) por punto (después − antes).
- Modelos lineales mixtos (`lme4` + `lmerTest`):
  - `ΔN ~ depredador * hábitat + (1 | punto)`
  - `ΔS ~ depredador * hábitat + (1 | punto)`
- Estadística descriptiva por especie y hábitat: especies más abundantes y cambio promedio en cantos.
- Visualización con `ggplot2`.

## Resultados principales

![Cambio en abundancia por depredador y hábitat](figuras/delta_abundancia.png)

- Hubo más individuos vocalizando en **hábitats cerrados**.
- Ante el halcón (*M. semitorquatus*) en **áreas abiertas**, las aves tendieron a **no vocalizar**.
- Los resultados apoyan que la flexibilidad conductual de las aves les permite usar distintas estrategias antidepredación según la identidad del depredador y las características del hábitat.

## Estructura del repositorio

```
├── scripts/analisis_aves.R          # Modelos, gráficas y descriptiva
├── figuras/delta_abundancia.png     # Figura principal
└── datos/                           # Archivos .csv (ver LEEME.txt)
```

## Cómo reproducir

1. Coloca `palomas2.csv` y `pinchespalomas.csv` en `datos/`.
2. Abre la carpeta como proyecto en RStudio.
3. Instala los paquetes: `install.packages(c("tidyverse", "lme4", "lmerTest"))`.
4. Corre `scripts/analisis_aves.R`.

## Herramientas

R · tidyverse · lme4 · lmerTest · ggplot2

## Autoría

Nazly C. Ochoa-Larios, Estrella Flores-Flores y J. Alfredo Rodríguez.
