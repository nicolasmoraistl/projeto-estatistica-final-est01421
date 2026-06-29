# Análise do impacto da de dependência do petróleo em Estados Nacionais
*Uma investigação acerca dos impactos do rentismo na organização dos Estados Nacionais (1995-2024*)

**Colaboradores:**
* Nicolas Morais Teixeira Lima
* João Augusto de Almeida Silva
* Mateus Cintra Brasil de Souza

## Conjunto de Dados

Extraiu-se dados macroeconômicos a partir de bases do World Bank Data (Banco Mundial), complementando dados faltantes com bases encontradas do Kaggle, International Monetary Fund(IMF) e International Transparency, em um escopo de **30 anos**.

**Variáveis Independentes**

* `Oil_price`: dados sobre evolução do preço do barril no tempo.
* `Oil_share_GDP`: Porcentagem do PIB proveniente de receitas do petróleo
* `Export_import_oil`: Dados sobre valores de importação e importação de petróleo de países ao longo dos anos.
* `Fuel_share_exports`: Porcentagem de exportação de combustíveis sobre o total de mercadorias
* `Rents_share_budget`: participação da renda vinda de combustíveis fósseis no orçamento do governo.


**Variáveis Dependentes**

- `Gov_stability`: índice que mede a estabilidade governamental de 0-100
- `Burocratic_eff`: índice que mede a eficiência da burocracia/administração governamental de 0-100
- `Judiciary_stability`: mede a segurança jurídica do país de 0-100
- `Cpi_index`: mede a percepção geral de corrupção de um país de 0-100
- `Inflation`: Inflação percebida em 1 ano
- `Unemployement`: porcentagem de desemprego reportado em 1 ano
- `Industry_share_GDP`: participação da indústria na economia
- `Life_expectancy`: expectativa de vida ao nascer média em um país
- `HDI_index`: mede o Índice de Desenvolvimento Humano (IDH) de um país de 0-1
- `Tax_share_revenue`: participação da taxação no total do PIB de um país
- `Pib_capita_ppc`: renda média por pessoa ajustada ao poder de compra local

**Variáveis de Controle**

- `Ressource_rich_export_country`: verifica se o país exporta combustíveis e/ou é rico em recursos não-renováveis
- `Development_level`: checa o nível de desenvolvimento de um país, variando de baixa renda até alta renda
- `Island_micronation`: verifica se é um micro-país
- `Rentier_state` (Mohtadi et al., 2025; Vlaskamp, 2025): verifica se é um estado rentista (escala abaixo)
- `Oil_centered_matrix` (IEA, 2023): verifica se tem matriz dependente de combustíveis fósseis (escala abaixo)

As variáveis explicativas e explicadas serão fundamentalmente quantitativas contínuas, trazendo indicadores de diversas áreas que englobam o ciclo econômico dos países analisados, tirados de bases de dados do World Bank Data, International Transparency, International Monetary Fund e Kaggle. 

Outrossim, as variáveis de controle serão qualitativas ordinais e nominais. As qualitativas nominais serão tiradas da base de dados do IMF (2026), que são o Development_level, Island_micronation e Ressource_rich_export_country. 

Por outro lado, as ordinais serão criadas com base nos dados coletados das três variáveis independentes que tangem a dependência financeiro no petróleo, em que a classificação Rentier_state será: Não-rentista (nenhum dos cortes atendidos), semi-rentista (um corte atendido) e rentista (mais de um corte atendido). Os cortes para essas medidas são: o limite de Mohtadi et al. (2025) e Hasan et al.(2024) de 10% do PIB proveniente da venda de petróleo, 20% das exportações e das receitas estatais provindas da venda de combustíveis (IMF, 2012). 

No que tange a dependência da Oil_centered_matrix, a variável independente que estabelece irá ordenar o nível de dependência ordinal, segundo os dados da Agência Internacional da Energia (IEA) (2023), que afirma que há décadas que a média global de participação dos combustíveis fósseis na matriz é de 80%. Então, estabeleceu-se que os cortes seriam: : Pouco dependente (menor ou igual a 50%), Dependente (maior que 50% e menor que 80%), Muito dependente (maior ou igual a 80%), onde o corte de 50% é uma escolha arbitrária com base no limiar fornecido pela IEA.

## Planejamento

**Gráficos e Tabelas**

- `Dispersão`: permitirão entender melhor a distribuição de indicadores entre os grupos de nações de forma a melhor visualizar possível correlação (linha de regressão será usada)

- `Boxplot`: permitirá identificar outliers, tanto na parte do desenvolvimento como na qualidade institucional antes da aplicação de controles como a clusterização por desenvolvimento. Além de mapear mais concisamente as possíveis diferenças de distribuição entre os grupos

- `Linhas`: serão usados para mapear as séries temporais entre os indicadores que serão trabalhados nas perguntas (como o teste da hipótese "sem taxação, sem representação"), além de permitir visualizar essa variação com as variáveis explicativas

- `Tabela de sumarização descritiva`: será gerada uma tabela visando trazer um resumo das principais medidas descritivas quanto aos dados dos indicadores sociais e institucionais, cruzados com a dependência energética e financeira em combustíveis fósseis

**Linguagem**

Será utilizado o `R` para realizar a análise e modelar os dados


**Classificação das Variáveis**

- `Eixo Energético`: %PIB petróleo/exportação, %Receitas estatais do petróleo, %Matriz energética e Preço do Barril

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


*o arquivo .bib será adicionado mais tarde*
