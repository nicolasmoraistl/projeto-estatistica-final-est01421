#o tratamento de dados será feito de modo à facilitar a análise usando o R
#biblioteca do pandas importada para dataframe

import pandas as pd
from pandas import set_option

#trazer base csv
database_main = pd.read_csv('data_frame_en.csv', sep=',')

database_main['corruption_control'] = pd.NA

database_main['foreign_investments'] = pd.NA



#criar função que transfira os dados

def transfer_data_to_main(dataframe, variable, database_main):
  
    # Filtrando anos de 1995 a 2024
    
    year_cols = [col for col in dataframe.columns if col.isdigit()]
    
    df_year_filtered = dataframe[['Country Name'] + year_cols].copy()
    
    # Transferindo os anos para o formato longo usando o método melt
    df_long_format = df_year_filtered.melt(
        id_vars=['Country Name'], 
        var_name='year',
        value_name=variable
    )
    
    # Transferindo valor de ano para inteiro
    df_long_format['year'] = df_long_format['year'].astype(int)
    
    # Checar se país do dataset principal bate com o da base
    df_long_format = df_long_format[
        df_long_format['Country Name'].isin(database_main['countries'])
    ]
    
    # Faremos um merge para juntar os dados corretamente
    database_main = database_main.merge(
        df_long_format, 
        left_on=['countries', 'year'],
        right_on=['Country Name', 'year'],
        how='left'
    )
    
    # Tira country name para evitar distorção nos dados
    if 'Country Name' in database_main.columns:
        database_main.drop('Country Name', axis=1, inplace=True)
        
    #excluindo colunas duplicadas
    database_main[variable+'_x'] = database_main[variable+'_y']
    database_main = database_main.drop(variable+'_y', axis=1)
    
    return database_main

#expectativa de vida
life_expectancy = pd.read_csv('data/life_expect/API_SP.DYN.LE00.IN_DS2_EN_csv_v2_257577.csv')

database_main = transfer_data_to_main(life_expectancy, 'life_expectancy', database_main)

database_main.to_csv('main_database.csv', index=False)

#porcentagem da taxação no PIB

tax_revenue = pd.read_csv('data/Tax-revenue/API_GC.TAX.TOTL.GD.ZS_DS2_en_csv_v2_1167.csv')

database_main = transfer_data_to_main(tax_revenue, 'tax_share_gdp', database_main)

database_main.to_csv('main_database.csv', index=False)

#desemprego

unemployement = pd.read_csv('data/Unemployement/API_SL.UEM.TOTL.ZS_DS2_en_csv_v2_115692.csv')

database_main = transfer_data_to_main(unemployement, 'unemployement', database_main)

database_main.to_csv('main_database.csv', index=False)

#Pib per capita (base poder de compra)

gdp_ppp = pd.read_csv('data/gdp_ppp_percapita/API_NY.GDP.PCAP.PP.CD_DS2_en_csv_v2_396610.csv')

database_main = transfer_data_to_main(gdp_ppp, 'gdp_capita_ppp', database_main)

database_main.to_csv('main_database.csv', index=False)

#participação da indústria no PIB

industry_share = pd.read_csv('data/value-added-industry/API_NV.IND.TOTL.ZS_DS2_en_csv_v2_576.csv')

database_main = transfer_data_to_main(industry_share, 'industry_share_gdp', database_main)

database_main.to_csv('main_database.csv', index=False)

#participação do petróleo no pib

oil_share_gdp = pd.read_csv('data/Oil_Share_GDP/API_NY.GDP.PETR.RT.ZS_DS2_en_csv_v2_2051.csv')

database_main = transfer_data_to_main(oil_share_gdp, 'oil_share_gdp', database_main)

database_main.to_csv('main_database.csv', index=False)

#investimentos estrangeiros

fdi_gdp = pd.read_csv('data/foreign_direct_investments/API_BX.KLT.DINV.WD.GD.ZS_DS2_en_csv_v2_411706.csv')

database_main = transfer_data_to_main(fdi_gdp, 'foreign_investments', database_main)

database_main.to_csv('main_database.csv', index=False)
#inflação

inflation_index = pd.read_csv('data/Inflation_index/API_FP.CPI.TOTL.ZG_DS2_en_csv_v2_250039.csv')

database_main = transfer_data_to_main(inflation_index, 'inflation_index', database_main)

database_main.to_csv('main_database.csv', index=False)

#porcentagem do petróleo nas exportações

fuel_exports = pd.read_csv('data/%fuel exports-merchandise/API_TX.VAL.FUEL.ZS.UN_DS2_en_csv_v2_1353.csv')

database_main = transfer_data_to_main(fuel_exports, 'fuel_share_exports', database_main)

database_main.to_csv('main_database.csv', index=False)

#índice de desenvolvimento humano.
#esse arquivo mistura diversos índices
#iremos extrair somente o hdi referente aos países do data set principal

hdi_index = pd.read_csv('data/HDI/hdr_data.csv')

hdi_index = hdi_index[['country', 'indicator', 'year', 'value']]

#filtro do que queremos
hdi_index = hdi_index[
    (hdi_index['indicator'] == 'Human Development Index (value)') & 
    (hdi_index['country'].isin(database_main['countries']))
  ]

#renomear colunas para corresponderem
hdi_index = hdi_index.rename(columns={'country': 'countries'})

#fazer merge
database_main = database_main.merge(
    hdi_index[['countries', 'year', 'value']], 
    on=['countries', 'year'], 
    how='left'
)

database_main['hdi'] = database_main['value']
database_main = database_main.drop('value', axis=1)

database_main.to_csv('main_database.csv', index=False)


#índices de eficiência governamental

gov_eff = pd.read_csv('data/governement_effectiveness_indexes/3be8611c-a998-4ed7-ad29-16f485b87ebf_Data.csv')

#mudar nome de colunas

columns = list(gov_eff.columns)

for column in columns[4:]:
  gov_eff = gov_eff.rename({column:column[0:4]}, axis=1)
  
#podemos reutilizar a função de transferência de dados ao cortar em 4 variáveis.

df_corruption = gov_eff[gov_eff['Series Code'] == 'GOV_WGI_CC.SC']
df_stability = gov_eff[gov_eff['Series Code'] == 'GOV_WGI_PV.SC']
df_effectiveness = gov_eff[gov_eff['Series Code'] == 'GOV_WGI_GE.SC']
df_rule_of_law = gov_eff[gov_eff['Series Code'] == 'GOV_WGI_RL.SC']


database_main = transfer_data_to_main(df_corruption, 'corruption_control', database_main)
database_main = transfer_data_to_main(df_stability, 'gov_stability', database_main)
database_main = transfer_data_to_main(df_effectiveness, 'bureaucratic_eff', database_main)
database_main = transfer_data_to_main(df_rule_of_law, 'rule_of_law', database_main)

database_main.to_csv('main_database.csv', index=False)

#checar se é exportador de combustíveis e rico em recursos
df_resources = pd.read_csv('data/development-revenue/world-imf2026.csv')

df_resources = df_resources[df_resources['year'] > 1994]

df_imf_selected = df_resources[['country', 'year', 'FuelExporting', 'ResourceRich']]

database_main = database_main.merge(
    df_imf_selected,
    left_on=['countries', 'year'], 
    right_on=['country', 'year'],    
    how='left'                       
)

database_main.to_csv('main_database.csv', index=False)

database_main = database_main.drop(['country', 'ressource_rich_export_country'], axis=1)

#retirando colunas não desejáveis

database_main = database_main.drop([
  'energy_matrix_share', 'oil_centered_matrix', 'import_oil', 'export_oil',
  'cpi_index ', 'micronation', 'development_level'
  ], axis=1)

database_main.to_csv('main_database.csv', index=False)

