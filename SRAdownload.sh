list='SraAccList.txt'
while read -r line
do
	echo $line
	
	fastq-dump --split-files "$line"
done < $list

for i in `ls *_1*` 
do 
name=$(basename -s _1.fastq $i )
echo $name 
mkdir $name
mv ${name}_1.fastq $name
mv ${name}_2.fastq $name
done
