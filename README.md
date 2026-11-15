Proyecto de la materia **Ecología de Bosques Tropicales Fragmentados**

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
- Hubo más individuos vocalizando en **hábitats cerrados**.
- Ante el halcón (*M. semitorquatus*) en **áreas abiertas**, las aves tendieron a **no vocalizar**.
- Los resultados apoyan que la flexibilidad conductual de las aves les permite usar distintas estrategias antidepredación según la identidad del depredador y las características del hábitat.

## Herramientas

R · tidyverse · lme4 · lmerTest · ggplot2

## Autoría del script

Nazly C. Ochoa-Larios
