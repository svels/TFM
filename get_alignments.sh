
"""
1: el input del csv
2: el organismo del primer gen
3: el organismo del segundo gen
"""

# PARA DOS
# vcf
while read -r gen1 gen2;
    do 
    #multifasta de las secuencias de los ortólogos
    cat /directorio_de_trabajo/$2/ppangg90/multifasta/cons_95/$gen1.cons /directorio_de_trabajo/$3/ppangg/multifasta/cons_95/$gen2.cons > 'tmp.fasta'
    #alineamiento con mafft entre las dos secuencias se guarda en un fasta
    #mkdir /directorio_de_trabajo/alignments/$3"_"$2

    mafft --adjustdirectionaccurately --thread 8 tmp.fasta > /directorio_de_trabajo/alignments/$3"_"$2/$gen1"_"$gen2".fasta"
    # con snp-sites se crea el vcf con el alineamiento entre las secuencias
    snp-sites -v /directorio_de_trabajo/alignments/$3"_"$2/$gen1"_"$gen2".fasta" > /directorio_de_trabajo/alignments/$3"_"$2/$gen1"_"$gen2".vcf"
done < $1


# # PARA EL TRIO
# # vcf
# while read -r genint genabs genmars;
#     do 
#     #multifasta de las secuencias de los ortólogos
#     cat /directorio_de_trabajo/Mintracellulare/ppangg/multifasta/cons_95/$genint.cons /directorio_de_trabajo/MAbscessus/ppangg/multifasta/cons_95/$genabs.cons /directorio_de_trabajo/Mmarseillense/ppangg/multifasta/cons_95/$genmars.cons > 'tmp.fasta'
#     #alineamiento con mafft entre las dos secuencias se guarda en un fasta
#     mkdir mafft
#     mafft --adjustdirectionaccurately --thread 8 tmp.fasta > mafft/$genint"_"$genabs"_"$genmars".fasta"
#     # con snp-sites se crea el vcf con el alineamiento entre las secuencias
#     mkdir vcf
#     snp-sites -v mafft/$genint"_"$genabs"_"$genmars".fasta" > vcf/$genint"_"$genabs"_"$genmars".vcf"
# done < intr_abs_mars_ort.csv






#  while read -r gen1 gen2 ; do cat /directori_de_trabajo/MAvium/ppangg/multifasta/cons_95/$gen1.cons /directori_de_trabajo/Mintracellulare/ppangg/multifasta/cons_95/$gen2.cons > Mintracellulare_MAvium/clustal/$gen1'_'$gen2'.fasta' ; mafft --clustalout > Mintracellulare_MAvium/clustal/$gen1'_'$gen2'.clustal' ; done < MAvium_Mintracellulare_ortologos.csv
