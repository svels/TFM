

"""
Para obtener un csv con una columna con el gen de un organismo y la segunda columna con el gen ortologo correspondiente en otro organismo
a partir de los resultados de match que han dado posibles candidatos
compara los matches para que sean recíprocos
1: organismo1
2: comparacion1
3: organismo2
4: comparacion2
5: los numeros de id y cov
"""

#mkdir directorio_de_trabajo/alignments/$1"_"$3

for i in $(ls directorio_de_trabajo/$1/$2/ort_candidates_$5)

do
    echo $i   
    q=$(cut -f1 directorio_de_trabajo/$1/$2/ort_candidates_$5/$i)
    echo "q=$q"
    #echo $q
    h=$(cut -f2 directorio_de_trabajo/$1/$2/ort_candidates_$5/$i)
    echo "h=$h"
    #echo "h=$h"
    if [ -s directorio_de_trabajo/$3/$4/ort_candidates_$5/$h".cons" ]; then
        q2=$(cut -f2 directorio_de_trabajo/$3/$4/ort_candidates_$5/$h".cons")
        h2=$(cut -f1 directorio_de_trabajo/$3/$4/ort_candidates_$5/$h".cons")
        if [[ "$q" == *"$q2"* ]] && [[ "$h" == *"$h2"* ]] ; then
            echo "$q $h" >> $1_$3_ortologos$5.csv
        fi
    fi
done


