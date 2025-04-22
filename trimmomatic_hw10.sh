#!/bin/bash
#SBATCH --job-name=trim_reads
#SBATCH --output=trim_reads_%j.out
#SBATCH --error=trim_reads_%j.err
#SBATCH --time=01:00:00
#SBATCH --mem=8G
#SBATCH --cpus-per-task=4

module load trimmomatic

IN_DIR=/projects/mipt_dbmp_biotechnology/genome
OUT_DIR=trimmed_output
ADAPTERS=${IN_DIR}/adapters.fa

mkdir -p $OUT_DIR

trimmomatic PE \
  -threads 4 \
  ${IN_DIR}/illumina_reads_R1_001.fastq ${IN_DIR}/illumina_reads_R2_001.fastq \
  ${OUT_DIR}/reads_R1_paired.fastq ${OUT_DIR}/reads_R1_unpaired.fastq \
  ${OUT_DIR}/reads_R2_paired.fastq ${OUT_DIR}/reads_R2_unpaired.fastq \
  ILLUMINACLIP:${ADAPTERS}:2:30:10 \
  LEADING:20 TRAILING:20 SLIDINGWINDOW:4:20 MINLEN:50
