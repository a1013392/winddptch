#!/bin/bash
#./nddcat.sh
# Shell script to concatenate monthly files into a single (annual) file.

# Update DUID in shell variable.

duid=waterlwf
workdir=$PWD
duiddir=$workdir/output/$duid
echo "DUID directory: $duiddir"
outdir=$workdir/output
echo "Output directory: $outdir"
outfile=dispatch_${duid}_1504_1603.csv
echo "Output file: $outfile"
countfile=dispatch_${duid}_rec_count.csv

cd $duiddir
echo "DUID directory: $PWD"
files=$(ls)
cat $files > $outdir/$outfile
#wc -l $files > $outdir/$countfile
