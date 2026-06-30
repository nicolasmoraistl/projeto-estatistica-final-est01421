#==============================================================================
  
#  1. INITIAL SETUP AND COMPLETE DATA CLEANING

#==============================================================================
  
library(tidyverse)
library(patchwork)

#Loading the CSV file

dados_original <- read_csv("/cloud/project/projeto-estatistica-final-est01421/data-transform/main_database.csv")

#Force absolute conversion of all numeric columns handling commas/texts automatically

dados <- dados_original |>
  mutate(
    oil_share_gdp_x      = parse_number(as.character(oil_share_gdp_x)),
    tax_share_gdp_x      = parse_number(as.character(tax_share_gdp_x)),
    corruption_control_x = parse_number(as.character(corruption_control_x)),
    bureaucratic_eff_x   = parse_number(as.character(bureaucratic_eff_x)),
    gov_stability_x      = parse_number(as.character(gov_stability_x)),
    rule_of_law_x        = parse_number(as.character(rule_of_law_x)),
    industry_share_gdp_x = parse_number(as.character(industry_share_gdp_x)),
    unemployement_x      = parse_number(as.character(unemployement_x)),
    inflation_index_x    = parse_number(as.character(inflation_index_x)),
    economic_growth_x    = parse_number(as.character(economic_growth_x)),
    hdi                  = parse_number(as.character(hdi)),
    life_expectancy_x    = parse_number(as.character(life_expectancy_x))
  ) |>
  
#  Filter out rows where essential variables failed to convert and clean tax outliers

filter(!is.na(bureaucratic_eff_x),
       !is.na(corruption_control_x),
       !is.na(tax_share_gdp_x),
       tax_share_gdp_x >= 0,
       tax_share_gdp_x <= 100)

#==============================================================================
  
#  2. DESCRIPTIVE SUMMARY TABLE

#==============================================================================
  
  descriptive_table <- dados |>
  group_by(rentier_state) |>
  summarise(
    Countries_Obs = n_distinct(countries),
    Mean_Oil_GDP = mean(oil_share_gdp_x, na.rm = TRUE),
    Mean_HDI = mean(hdi, na.rm = TRUE),
    Mean_Life_Expectancy = mean(life_expectancy_x, na.rm = TRUE),
    Mean_Tax_GDP = mean(tax_share_gdp_x, na.rm = TRUE),
    Mean_Bureaucratic_Eff = mean(bureaucratic_eff_x, na.rm = TRUE),
    Mean_Industry_GDP = mean(industry_share_gdp_x, na.rm = TRUE),
    Mean_Unemployment = mean(unemployement_x, na.rm = TRUE),
    Mean_Inflation = mean(inflation_index_x, na.rm = TRUE),
    Mean_GDP_Growth = mean(economic_growth_x, na.rm = TRUE)
  )

print(descriptive_table)

#==============================================================================
  
#  3. DATA VISUALIZATIONS (IN ENGLISH)

#==============================================================================
  
#  --- Question 1: Institutional Quality vs Oil Dependence (WITHOUT Non-Rentiers) ---
  
#  Filtering to keep only states with actual oil dependence (Rentier and Semi-Rentier)

dados_petroleo_ativos <- dados |>
  filter(rentier_state %in% c("rentier state", "semi-rentier state"))

plot_q1 <- ggplot(dados_petroleo_ativos, aes(x = oil_share_gdp_x, y = corruption_control_x, color = rentier_state)) +
  geom_point(alpha = 0.6, size = 2.5) +
  geom_smooth(method = "lm", color = "black", se = FALSE, linetype = "dashed") +
  theme_minimal() +
  scale_color_brewer(palette = "Set1") +
  labs(
    title = "Institutional Quality and Oil Dependence",
    subtitle = "Comparing Rentier vs Semi-Rentier States (Non-Rentiers excluded)",
    x = "Oil Rents (% of GDP)",
    y = "Control of Corruption Index",
    color = "State Type"
  ) +
  theme(legend.position = "bottom")

#--- Question 2: The Dutch Disease Test (With X-Axis Label Rotation Fix) ---
  
  plot_industry <- ggplot(dados, aes(x = rentier_state, y = industry_share_gdp_x, fill = rentier_state)) +
  geom_boxplot(alpha = 0.7, outlier.color = "red") +
  theme_classic() +
  labs(
    title = "Industrial Share of GDP",
    x = "State Type",
    y = "Industry (% of GDP)"
  ) +
  theme(
    legend.position = "none",
    axis.text.x = element_text(angle = 25, hjust = 1) # Prevents text overlap
  )

plot_unemployment <- ggplot(dados, aes(x = rentier_state, y = unemployement_x, fill = rentier_state)) +
  geom_boxplot(alpha = 0.7, outlier.color = "red") +
  theme_classic() +
  labs(
    title = "Unemployment Rates Distribution",
    x = "State Type",
    y = "Unemployment Rate (%)"
  ) +
  theme(
    legend.position = "none",
    axis.text.x = element_text(angle = 25, hjust = 1) # Prevents text overlap
  )

#Displaying both side-by-side using patchwork

plot_q2 <- plot_industry + plot_unemployment

#--- Question 3: "No Taxation Without Representation" Hypothesis (WITHOUT Non-Rentiers) ---
  
#  Filtering to analyze the fiscal contract only on oil-producing states

plot_q3 <- ggplot(dados_petroleo_ativos, aes(x = tax_share_gdp_x, y = bureaucratic_eff_x, color = rentier_state)) +
  geom_point(alpha = 0.6, size = 2.5) +
  geom_smooth(method = "lm", aes(group = rentier_state), se = FALSE, linewidth = 1) +
  theme_light() +
  scale_color_brewer(palette = "Set1") +
  labs(
    title = "Fiscal Bargaining Hypothesis: Taxation vs Governance",
    subtitle = "Comparing Rentier and Semi-Rentier dynamics (Non-Rentiers excluded)",
    x = "Tax Revenue (% of GDP)",
    y = "Bureaucratic Efficiency Index",
    color = "State Type"
  ) +
  theme(legend.position = "bottom")

#--- Question 4: Human Development Evolution Over Time ---
  
  plot_hdi_time <- dados |>
  group_by(rentier_state, year) |>
  summarise(mean_hdi = mean(hdi, na.rm = TRUE), .groups = 'drop') |>
  ggplot(aes(x = year, y = mean_hdi, color = rentier_state)) +
  geom_line(linewidth = 1.2) +
  theme_minimal() +
  labs(
    title = "HDI Evolution (30-Year Trend)",
    x = "Year",
    y = "Mean HDI",
    color = "State Type"
  )

plot_life_time <- dados |>
  group_by(rentier_state, year) |>
  summarise(mean_life = mean(life_expectancy_x, na.rm = TRUE), .groups = 'drop') |>
  ggplot(aes(x = year, y = mean_life, color = rentier_state)) +
  geom_line(linewidth = 1.2) +
  theme_minimal() +
  labs(
    title = "Life Expectancy Trend",
    x = "Year",
    y = "Mean Life Expectancy (Years)",
    color = "State Type"
  )

plot_q4 <- plot_hdi_time / plot_life_time

#--- Question 5: Global Macroeconomic Indicators ---
  
  macro_data <- dados |>
  group_by(rentier_state) |>
  summarise(
    Inflation = mean(inflation_index_x, na.rm = TRUE),
    FDI = mean(foreign_investments_x, na.rm = TRUE),
    GDP_Growth = mean(economic_growth_x, na.rm = TRUE)
  ) |>
  pivot_longer(cols = c(Inflation, FDI, GDP_Growth), names_to = "Indicator", values_to = "Value")

plot_q5 <- ggplot(macro_data, aes(x = rentier_state, y = Value, fill = rentier_state)) +
  geom_col(position = "dodge") +
  facet_wrap(~Indicator, scales = "free_y") +
  theme_bw() +
  labs(
    title = "Global Macroeconomic Comparison",
    subtitle = "Comparing average macroeconomic performance across groups",
    x = "State Type",
    y = "Consolidated Mean Value"
  ) +
  theme(legend.position = "none", axis.text.x = element_text(angle = 15, hjust = 1))

#==============================================================================
  
#  HOW TO VIEW INDIVIDUAL PLOTS:
  
#  ==============================================================================
  
  print(plot_q1) # Institutional Quality (Excluding Non-Rentier)

print(plot_q2) # Dutch Disease Boxplots (All groups, with rotated axis text)

print(plot_q3) # Taxation vs Governance (Excluding Non-Rentier)

print(plot_q4) # Development Trends Over Time

print(plot_q5) # Macroeconomic Bars