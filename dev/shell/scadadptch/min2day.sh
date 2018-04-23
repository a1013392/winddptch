#!/bin/bash
#./min2day.sh
# Shell script to concatenate 5-minute SCADA files into a daily file.

workdir=$PWD
outdir=$workdir/output
echo "Output directory: $outdir"
datadir=$workdir/scada
echo "Data directory: $datadir"
cd $datadir
for dir in *; 
do
	echo "Directory: $dir"
	cd $datadir/$dir
	currdir=$PWD
	echo "Current directory: $currdir"
	for file in *.zip; do unzip "$file"; done
	rm *.zip
	for file in *.CSV; do sed -i '' '1,2 d; $ d' $file; done
	cat *.CSV > $outdir/scada_$dir.csv
done

# Count lines in SCADA 5-minute generation data files
#for dir in *; do cd $dir; echo "$dir"; for file in *; do wc -l $file >> ../linecount.txt; done; cd ..; done