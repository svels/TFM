# Añadir gen de cabecera a la lista de la familia
for i in `cut -f1,15- -d',' persistent.csv | sed -e 's/"//g' -e 's/ /,/g'`; do 
    family=$(echo $i | cut -f1 -d',');
    echo $i > families/$family.txt; 
done

# Pasar lista con comas a saltos de línea
for i in `ls families`; do 
    sed -i 's/\,/\n/g' families/$i; 
    sed -i '/^$/d' families/$i ; 
done

# extraer todos los genes por familias
mkdir multifasta

for i in `ls families`; do 
    grep -A1 -Ff families/$i genes/all_genes.fna | grep -v '\-\-' > multifasta/$i".fasta"; 
done

# renombrar
cd multifasta
rename 's/\.txt//g' *

# alinear genes
for i in $(ls *.fasta); do 
    mafft --retree 2 --adjustdirectionaccurately --thread 32 $i > "$(basename $i .fasta)".aln; 
done

# sacar consenso

mkdir cons_95
for i in $(ls *.aln); do 
NAME="$(basename $i .aln)"; num=$(grep -c ">" $i); id=$(echo $num*0.95 | bc | cut -f1 -d'.'); 
case=$(echo $num*0.95 | bc | cut -f1 -d'.'); em_cons -sequence $i -outseq cons_95/$NAME".cons" -name $NAME -snucleotide1 -setcase $case -identity $id; 
done


