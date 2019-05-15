# creo que solo sirve para correrlo en analisis con 10 repeticiones por k
let indv_number=58
let locus_number=27600
MAINPARAMS_FILE="mainparams"
EXTRAPARAMS_FILE="extraparams"
STR_INPUT"missing5.vcf"
JOBS=8
k_range=15

let total_reps=$k_range*10-1
seq 0 $total_reps > repetitions
mkdir results
rm runrun -f

for i in $(cat repetitions)
do
	echo structure -i $STR_INPUT -N $indv_number -L $locus_number -m $MAINPARAMS_FILE -e $EXTRAPARAMS_FILE -D $RANDOM -K $(( $i % $k_range + 1 )) -o ./results/structure_k$(( $i % $k_range + 1 ))-$(( $i/$k_range + 1 )) >> runrun
done
cat runrun | parallel -j $JOBS
