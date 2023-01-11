import pandas as pd
import os
import csv

def read_vcf(file):
    df = pd.read_table(file, header=None, comment='#')
#     cuando se realiza una comparación entre más de dos especies hay que añadir un * más al final por 
#     cada especie extra
    df.columns = ['CHROM', 'POS', 'ID', 'REF', 'ALT', 'QUAL', 'FILTER', 'INFO', 'FORMAT', '*', '*']
    df.drop(columns = ['CHROM', 'ID', 'QUAL', 'FILTER', 'INFO', 'FORMAT'], inplace = True)
#     en el vcf las partes que eran N aparece como * así que quitamos las filas que lo tengan porque no son verdaderos SNPS
    df = df[df["ALT"].str.contains("\*")==False]
        
    return df

def get_combo(df):

# para cada posición busca los SNPs que están a menos del snp_dist indicado y los va añadiendo a una lista
# en el archivo final se verá una linea por cada posición seguida de las posiciones que están a menos de snp_dist
# cada posición sequida de su REF ALT 1/0 1/0

    l_row = []
    pos_ini = -1000000
    prev_line = []
    snp_prev = []
    for _, row in df.iterrows():
        pos_ini = row.POS
        l_row = [list(row)]
        for _, row2  in df.iterrows():
            if row2.POS > row.POS and row2.POS - row.POS <= snp_dist :
                l_row.append(list(row2))
#         print(l_row)
        with open(c_outfile, 'a+') as f:
            f.write(f"{l_row}\n")


def get_snp3(df):
#     para crear una lista (archivo) con el resumen de todos los snps
    l_row = []
    for _, row in df.iterrows():
        if len(row.ALT) == 1:
            l_row.append(list(row))
    return l_row


directory = "Directorio_de_trabajo"

for snp_dist in [10, 50, 100, 300]:
    for filename in os.listdir(directory):
        f = os.path.join(directory, filename)
        # checking if it is a file
        if os.path.isfile(f) and f.endswith('vcf'):
            print(f)
            c_outfile = f.split('.vcf')[0] + '_combo_' + str(snp_dist) + '.csv'
            s_outfile = f.split('.vcf')[0] + '_snp3.csv'
            df = read_vcf(f)
            get_combo(df)
            snp3 = get_snp3(df)

            if len(snp3) > 0:
                with open(s_outfile, 'w') as f:
                    write = csv.writer(f)
                    write.writerows(snp3)

