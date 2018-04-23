#!/bin/bash
#./nddpproc.sh
# Shell script for pre-processing Next Day Dispatch files.

workdir=$PWD
datadir=$workdir/nem
echo "NEM data directory: $datadir"

cd $datadir
for dir in *;
do
	echo "Directory: $dir"
	cd $datadir/$dir
	currdir=$PWD
	echo "Current directory: $currdir"
	for file in *.zip; do unzip "$file"; done
	rm *.zip
	for file in *.CSV; do sed -i '' '/UNIT_SOLUTION/ !d' $file; done
	#for file in *.CSV; do sed -i '' '1,2 d; /OFFERTRK/,$ d' $file; done
done
