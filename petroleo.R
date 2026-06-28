#tidyverse para ler arquivos csv
library(tidyverse)
#readxl para ler arquivos xlsx
library(readxl)
dados <- read_csv("projeto-estatistica-final-est01421/main_database.csv", locale = locale(encoding = "UTF-8"))
# 2. Criar a coluna rentier_state com base nas 2 variáveis que temos
dados_corrigidos <- dados |> 
  mutate(
    # Verifica o primeiro corte: PIB do petróleo > 10%
    corte_pib    = if_else(oil_share_gdp_x > 10, 1, 0, missing = 0),
    
    # Verifica o segundo corte: Exportação de combustíveis > 20%
    corte_export = if_else(fuel_share_exports_x > 20, 1, 0, missing = 0),
    
    # Soma os dois critérios (pode dar 0, 1 ou 2)
    total_cortes = corte_pib + corte_export,
    
    # Preenche a coluna rentier_state de acordo com o resultado
    rentier_state = case_when(
      total_cortes == 0 ~ "Não-rentista",
      total_cortes == 1 ~ "Semi-rentista",
      total_cortes == 2 ~ "Rentista",
      TRUE              ~ NA_character_
    )
  ) |> 
  # Remove as colunas temporárias para deixar a tabela limpa
  select(-corte_pib, -corte_export, -total_cortes)
# 1. Calcular a média do IDH por ano e por grupo (corrigido para na.rm)
dados_medias <- dados_corrigidos |> 
  group_by(year, rentier_state) |> 
  summarise(media_socioec = mean(hdi, na.rm = TRUE), .groups = "drop")

# 2. Gerar o gráfico de linhas
ggplot(dados_medias, aes(x = year, y = media_socioec, color = rentier_state)) +
  geom_line(linewidth = 1.2) +
  geom_point(size = 2) +
  scale_color_manual(
    values = c("Não-rentista" = "#2ca02c", "Semi-rentista" = "#ff7f0e", "Rentista" = "#d62728")
  ) +
  labs(
    title = "Evolução Média do IDH por Status de Estado Rentista",
    x = "Ano",
    y = "IDH Médio",
    color = "Status do Estado"
  ) +
  theme_minimal() +
  theme(legend.position = "bottom", plot.title = element_text(face = "bold", hjust = 0.5))