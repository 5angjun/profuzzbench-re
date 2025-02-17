#!/bin/bash
set -e
DATADIR=$PWD

echo
echo "Analyzing data in $DATADIR"
echo

declare -a FOLDERS=$(ls | grep results-)
FILTER=$1

if [ ! -z "$FILTER" ]
then
    FOLDERS=$(echo "${FOLDERS[@]}" | grep -E $FILTER)
fi


echo "${FOLDERS[@]}" | while read RESULTDIR; do

    echo
    echo
    echo "***** Analyzing: $RESULTDIR *****"
    echo

    cd $DATADIR/$RESULTDIR

    APPEND=0

    TARGET=$(echo $RESULTDIR | perl -n -l -e '/results-(.*)/; print $1;')
    FUZZERS="aflnet aflnwe stateafl nsfuzz-v nsfuzz"
    REPS=$(ls *.tar.gz | perl -n -l -e 'print $1 if /^out-.+-\w+_(\d+)\.tar\.gz/;'|sort -r|head -1)
    
    echo "TARGET: $TARGET"
    echo "REPLICATIONS: $REPS"

    if [ -f results.csv ]; then
        rm results.csv
    fi

    ls | grep out- | grep -v "tar.gz" | xargs rm -rf

    for FUZZER in $FUZZERS; do

        echo "FUZZER: '$FUZZER'"
        echo

        profuzzbench_generate_csv.sh $TARGET $REPS $FUZZER results.csv $APPEND
        APPEND=1

        ls | grep out- | grep -v "tar.gz" | xargs rm -rf

    done

    profuzzbench_plot.py -i $DATADIR/$RESULTDIR/results.csv -p $TARGET -r $REPS -c 1 -s 1 -o $DATADIR/cov_over_time_${TARGET}.png

done
