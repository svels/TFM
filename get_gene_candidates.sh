
"""
Parsear los resultados de blastvsNTM para que de una lista con las familias de genes que tengan no match con otras NTM y 
valen para la pcr
Desde el directorio en el que están los resultados de los matches contra la lista de micobacterias
el primer argumento es el nombre que quiero que excluya como no válido. es decir, el nombre del organimo que estoy estudiando
el segundo argumento es la comparación que estoy estudiando
"""

microorg="$1"
echo $microorg

rm nocandidatos_rep.txt

for i in `ls $2/nomatch/vsAll/nomatches/vsNTM | grep .cons`
do 
cat $2/nomatch/vsAll/nomatches/vsNTM/$i | awk -F "\t" -v MICRO=$microorg '{ 
    if ($2 !~ MICRO ) 
    print $1 >> "nocandidatos_rep.txt"}'
done

uniq nocandidatos_rep.txt 'listanocandidatos'$2'.txt'

for i in `ls $2/nomatch/vsAll/nomatches/vsNTM | grep .cons`
do
    if [[ `cat 'listanocandidatos'$2'.txt'` != *`basename -s .cons $i`* ]] 
    then
    basename -s .cons $i >> 'candidatos'$2'.txt'
    fi
done


chmod 777 ppangg/partitions/*

for i in `cat ppangg/partitions/exact_core.txt`  
do 
    if [[ `cat 'candidatos'$2'.txt'`  == *$i* ]] 
    then   
    echo $i >> 'exact_candidates'$2'.txt'
    fi 
done 