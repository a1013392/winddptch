#!/bin/bash
#./nddduid.sh
# Shell script to filter daily Next Day Dispatch files on dispatch unit
# identifier (DUID).  It concatenates records (rows) filtered on DUID into monthly
# files and drop unwanted fields (columns).  Output files retains five columns:
# DISPATCHINTERVAL, INITIALMW, TOTALCLEARED, AVAILABILITY, SEMIDISPATCHCAP

# Update DUID in shell variable and character string.

duid=waterlwf
workdir=$PWD
nemdir=$workdir/nem
echo "NEM data directory: $nemdir"
duiddir=$workdir/$duid
echo "DUID data directory: $duiddir"
outdir=$workdir/output/$duid
echo "Output data directory: $outdir"

#month=1503

mkdir $duiddir
mkdir $outdir

cd $nemdir
#for dir in $month;
for dir in *;
do
	cd $nemdir/$dir
	echo "Current (NEM) directory: $PWD"
	mkdir $duiddir/$dir
	for file in *.CSV; do sed '/WATERLWF/ !d' $file > $duiddir/$dir/$file; done
	cd $duiddir/$dir
	for file in *.CSV; do echo "$(wc -l $file)"; cut -d ',' -f 9,14,15,37,60 $file >> $outdir/dispatch_${duid}_$dir.csv; done
done

cd $outdir
for file in *.csv; do echo "$(wc -l $file)"; done

#cd $outdir
#outdir=$PWD
#echo "Output directory: $outdir"
#for file in *.csv 
#do 
#	newfile=${file%%.*}_snowtwn1.${file##*.}
#	cp $file $newfile
#	sed -i '' '/SNOWTWN1/ !d' $newfile
#	echo "$(wc -l $newfile)"
#done

# Store line number of line containing the first occurrence of text
#line = $(grep -n -m 1 'OFFERTRK' $file | cut -f1 -d:)
#echo $line

# Count lines in data files
#for dir in *; do cd $dir; echo "$dir"; for file in *; do wc -l $file >> ../linecount.txt; done; cd ..; done