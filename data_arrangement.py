#o tratamento de dados será feito de modo à facilitar a análise usando o R
#biblioteca do pandas importada para dataframe
import pandas as pd

#converter xlsx para csv
database = pd.read_excel('data_base.xlsx')

database.to_csv('data_base.csv', index=None, header=True)

#trazer base csv
database_main = pd.read_csv('data_frame_en.csv', sep=',')

#será feito a integração de cada uma das bases de dados a main

