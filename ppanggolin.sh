
# Argumento es el fasta list

ppanggolin annotate --fasta $1 -o . -f --cpu 8

ppanggolin cluster --no_defrag --identity 0.95 -f -c 8 -p pangenome.h5

ppanggolin fasta -p pangenome.h5 --output genes --genes all -f

ppanggolin graph -p pangenome.h5 -f

ppanggolin partition -p pangenome.h5 -f

ppanggolin write -p pangenome.h5 --csv -o . -f

ppanggolin write -p pangenome.h5 --Rtab -o . -f

ppanggolin write -p pangenome.h5 --partitions -o . -f

ppanggolin draw -p pangenome.h5 --tile_plot -o . -f

ppanggolin draw -p pangenome.h5 --ucurve -o . -f
