#! /bin/bash
#  chmod +x downsample_script.sh

inputfile1=N8_GTTTCG_L001_R1_001; 
inputfile2=N8_GTTTCG_L001_R2_001;

CNT=1
declare -a SEED_ARRAY;

while read -r seed || [[ -n $seed ]]; do
#    echo $seed;
    SEED_ARRAY[ $CNT ]=$seed;
#    (($CNT++));
#    echo $SEED_ARRAY[$CNT];
    CNT=$((CNT+1));
done < ./DownSample_seqtk/primes_300_5000
#exit;    
for rep in {1..100}; do
    filerep=`printf "%03d" $rep`;
    for depth in 6250 12500 25000 50000 100000; do
        outputfile1=${inputfile1}_${depth}_${filerep}.fastq
        outputfile2=${inputfile2}_${depth}_${filerep}.fastq
        
	echo "/home/ndc/Documents/DownSample_seqtk/seqtk/seqtk sample -s$SEED_ARRAY[$rep] ${inputfile1}.fastq $depth > $outputfile1"
        /home/ndc/Documents/DownSample_seqtk/seqtk/seqtk sample -s$SEED_ARRAY[$rep] ${inputfile1}.fastq $depth > $outputfile1
 	echo "/home/ndc/Documents/DownSample_seqtk/seqtk/seqtk sample -s$SEED_ARRAY[$rep] ${inputfile2}.fastq $depth > $outputfile2"
        /home/ndc/Documents/DownSample_seqtk/seqtk/seqtk sample -s$SEED_ARRAY[$rep] ${inputfile2}.fastq $depth > $outputfile2
        
    done;
done;
    
