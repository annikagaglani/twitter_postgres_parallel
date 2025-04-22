#!/bin/bash

files=$(find data/*)

echo '================================================================================'
echo 'load denormalized'
echo '================================================================================'
time for file in $files; do
    echo
    python3 -u services/pg_denormalized/load_tweets.py --db=postgresql://postgres:1999 --inputs $file
done

echo '================================================================================'
echo 'load pg_normalized'
echo '================================================================================'
time for file in $files; do
    echo
    python3 -u services/pg_normalized/load_tweets.py --db=postgresql://postgres:pass@2000 --inputs $file
done

echo '================================================================================'
echo 'load pg_normalized_batch'
echo '================================================================================'
time for file in $files; do
    python3 -u load_tweets_batch.py --db=postgresql://postgres:pass@2001 --inputs $file
done
