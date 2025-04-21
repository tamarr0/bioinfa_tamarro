#!/bin/bash


mkdir -p data/raw data/clean reports/fastqc reports/multiqc logs


echo "Downloading SRA data..."
ids=("ERR14230595" "ERR14230586" "ERR14230582" "ERR14230570")


for id in "${ids[@]}"; do
    echo "Processing $id..."
    prefetch "$id"
    fasterq-dump --outdir data/raw "$id"
done


echo "Checking FASTQ files..."
ls data/raw/*.fastq || { echo "No FASTQ files found! Exiting."; exit 1; }


echo "Running FastQC..."
fastqc -t 4 -o reports/fastqc data/raw/*.fastq


echo "Generating MultiQC report..."
multiqc -o reports/multiqc reports/fastqc/

echo "Analysis complete! Check reports/multiqc/"
