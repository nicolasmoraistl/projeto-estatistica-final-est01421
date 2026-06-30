# Análise do impacto da de dependência do petróleo em Estados Nacionais
*Uma investigação acerca dos impactos do rentismo na organização dos Estados Nacionais (1995-2024*)

**Colaboradores:**
* Nicolas Morais Teixeira Lima
* João Augusto de Almeida Silva
* Mateus Cintra Brasil de Souza

## Conjunto de Dados

Extraiu-se dados macroeconômicos a partir de bases do World Bank Data (Banco Mundial), complementando dados faltantes com bases encontradas do Kaggle, International Monetary Fund(IMF) e International Transparency, em um escopo de **30 anos**.

**Variáveis Independentes**

* `oil_share_gdp_x`: Porcentagem do PIB proveniente de receitas do petróleo
* `fuel_share_exports_x`: Porcentagem de exportação de combustíveis sobre o total de mercadorias


**Variáveis Dependentes**

- `gov_stability_x`: índice que mede a estabilidade governamental de 0-100
- `bureaucratic_eff_x`: índice que mede a eficiência da burocracia/administração governamental de 0-100
- `rule_of_law_x`: mede a segurança jurídica do país de 0-100
- `corruption_control_x`: mede a percepção geral de corrupção de um país de 0-100
- `inflation_index_x`: Inflação percebida em 1 ano
- `Unemployement`: porcentagem de desemprego reportado em 1 ano
- `industry_share_gdp_x`: participação da indústria na economia
- `life_expectancy_x`: expectativa de vida ao nascer média em um país
- `hdi`: mede o Índice de Desenvolvimento Humano (IDH) de um país de 0-1
- `tax_share_gdp_x`: participação da taxação no total do PIB de um país
- `gdp_capita_ppp_x`: renda média por pessoa ajustada ao poder de compra local

**Variáveis de Controle**

- `ResourceRich`: verifica se o país é rico em recursos naturais
- `FuelExporting`: verifica se o país é exportador de combustíveis fósseis.
- `rentier_state` (Mohtadi et al., 2025; Vlaskamp, 2025): verifica se é um estado rentista (escala abaixo)

As variáveis explicativas e explicadas serão fundamentalmente quantitativas contínuas, trazendo indicadores de diversas áreas que englobam o ciclo econômico dos países analisados, tirados de bases de dados do World Bank Data, International Transparency, International Monetary Fund e Kaggle. 

Outrossim, as variáveis de controle serão qualitativas ordinais e nominais. As qualitativas nominais serão tiradas da base de dados do IMF (2026), que são os rentier_state, ResourceRich e FuelExporting. 

Por outro lado, as ordinais serão criadas com base nos dados coletados das três variáveis independentes que tangem a dependência financeiro no petróleo, em que a classificação Rentier_state será: Não-rentista (nenhum dos cortes atendidos), semi-rentista (um corte atendido) e rentista (mais de um corte atendido). Os cortes para essas medidas são: o limite de Mohtadi et al. (2025) e Hasan et al.(2024) de 10% do PIB proveniente da venda de petróleo, 20% das exportações e das receitas estatais provindas da venda de combustíveis (IMF, 2012). 

## Planejamento

**Perguntas**

- Como os índices governamentais se comportam em relação a dependência do petróleo em relação ao PIB?

- A partipação da indústria é maior em Estados Rentistas ou não rentistas? E com relação ao emprego? Observe a distribuição dos dados.

- A hipótese "sem taxação sem representação" é validadada pelo conjunto de dados? Isto é, existe uma correlação negativa entre a taxação e os índices de eficiência governamental?

- A IDH tem evoluído mais em Estados Rentistas ou não rentistas? E com relação a expectativa de vida? (Em média, ao longo dos 30 anos)

- Como se comporta a média global dos indicadores econômicos entre os 2 grupos(inflação, investimentos estrangeiros e crescimento econômico)?


**Gráficos e Tabelas**

- `Dispersão`: permitirão entender melhor a distribuição de indicadores entre os grupos de nações de forma a melhor visualizar possível correlação (linha de regressão será usada)

- `Boxplot`: permitirá identificar outliers, tanto na parte do desenvolvimento como na qualidade institucional antes da aplicação de controles como a clusterização por desenvolvimento. Além de mapear mais concisamente as possíveis diferenças de distribuição entre os grupos

- `Linhas`: serão usados para mapear as séries temporais entre os indicadores que serão trabalhados nas perguntas (como o teste da hipótese "sem taxação, sem representação"), além de permitir visualizar essa variação com as variáveis explicativas

- `Tabela de sumarização descritiva`: será gerada uma tabela visando trazer um resumo das principais medidas descritivas quanto aos dados dos indicadores sociais e institucionais, cruzados com a dependência energética e financeira em combustíveis fósseis

**Linguagem**

Será utilizado o `R` para realizar a análise e modelar os dados


**Classificação das Variáveis**

- `Eixo Energético`: %PIB petróleo/exportação.

- `Eixo Socioeconômico`: PIB per Capita PPC, Desemprego, IDH, Inflação, etc.

- `Eixo Institucional:` Percepção de Corrupção, Estabilidade, Eficiência Burocrática e Confiança Judiciária


**Limitações**

 - `Dados em falta`: Muitos Estados são autoritários/fechados, não publicando dados econômicos precisos, restando apenas estimativas (quando existem) de organizações internacionais. A Venezuela e a Líbia, por exemplo, não publicam dados desde 2012, a Síria desde 2007. Sem considerar que dados mais recentes ainda estão sendo gerados, o que pode gerar distorção para os anos de 2023 e 2024.

 - `Limiar de rentismo e de matriz energética`: Trabalhar com limiares é extremamente complicado pois implica que, por exemplo, para um limite acima de 40%, 39,99% estaria de fora enquanto 40,01% estaria dentro, ainda que a diferença entre os 2 seja irrisória.

 - `Dificuldade de estimar causalidade`: Ainda que comprovada a correlação entre os dados estudados, precisar-se-ia de estudos mais aprofundados para entender de onde vem a causalidade. Visto que não é impossível que as variáveis explicadas talvez expliquem as variáveis explicativas nesse caso.

## Referências


- Beblawi, H. (1987). *The Rentier State in the Arab World*. In Beblawi, H. & Luciani, G. (Eds.), *The Rentier State* (pp. 49-62). Londres: Croom Helm.

- Hasan, Q. et al. (2024). *Stepping into the Just Transition Journey: The Energy Transition in Petrostates*. Energy Research & Social Science, 113, 103553.

- IEA (2023). *World Energy Outlook 2023*. Paris: International Energy Agency.

- IMF (2012). *Macroeconomic Policy Frameworks for Resource-Rich Developing Countries*. Washington, DC: International Monetary Fund.

- IMF (2026). *World Revenue Longitudinal Database*. Washington, DC: International Monetary Fund.

- Martini, E. (2022). *Human Development Index Historical Data*. Kaggle.

- Mohtadi, S. et al. (2025). *Gendered Impacts of Oil Price Shocks: Analyzing Women's Labor Force Participation in Petrostates*. Energy Research & Social Science, 126, 104134.

- Singh, C. (2026). *Crude Oil Price*. Kaggle.

- Toriqul (2023). *Worldwide Crude Oil Export and Import Trade*. Kaggle.

- Transparency International (2026). *Corruption Perceptions Index 2025*. Berlim.

- UNDP (2023). *Global Decarbonization in Fossil Fuel Export-Dependent Economies: Fiscal and Economic Transition Costs*. Nova York: United Nations Development Programme.

- UNU-WIDER (2025). *UNU-WIDER Government Revenue Dataset* (Version 2025). Helsinki.

- U.S. EIA (n.d.). *Total Energy Consumption*. Washington, DC: U.S. Energy Information Administration.

- Vlaskamp, M. C. (2025). *Pathways to Instability: How Decreasing Oil Prices Impact Political Stability in Petrostates*. Energy Research & Social Science, 127, 104265.

- World Bank (n.d.). *Energy Use (kg of oil equivalent per capita)*. Washington, DC.

- World Bank (n.d.). *Fuel Exports (% of merchandise exports)*. Washington, DC.

- World Bank (n.d.). *Government Effectiveness: Estimate*. Washington, DC.

- World Bank (n.d.). *Inflation, Consumer Prices (annual %)*. Washington, DC.

- World Bank (n.d.). *Life Expectancy at Birth, Total (years)*. Washington, DC.

- World Bank (n.d.). *Oil Rents (% of GDP)*. Washington, DC.

- World Bank (n.d.). *Tax Revenue (% of GDP)*. Washington, DC.

- World Bank (n.d.). *Unemployment, Total (% of total labor force)*. Washington, DC.


*o arquivo .bib será adicionado mais tarde e integrado ao Rmd*
