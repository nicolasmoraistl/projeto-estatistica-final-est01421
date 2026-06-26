#o tratamento de dados será feito de modo à facilitar a análise usando o R
#biblioteca do pandas importada para dataframe
import pandas as pd

#trazer base csv
database_main = pd.read_csv('data_frame_en.csv', sep=',')

#algumas bases possuem dados indesejáveis, vamos criar uma função para eliminar esses erros.
#para os dados extraídos no World Bank que possuem o mesmo formato
def filter_years(dataframe):
  years = [str(year) for year in range(1995, 2025)]
  return dataframe[['Country Name'] + years]

def transfer_data_to_main(dataframe, variable, database_main):
    # Filtrando anos de 1995 a 2024
    df_year_filtered = filter_years(dataframe)
    
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

#porcentagem do petróleo nas exportações

fuel_exports = pd.read_csv('data/%fuel exports-merchandise/API_TX.VAL.FUEL.ZS.UN_DS2_en_csv_v2_1353.csv')

database_main = transfer_data_to_main(fuel_exports, 'fuel_share_exports', database_main)

database_main.to_csv('main_database.csv', index=False)
