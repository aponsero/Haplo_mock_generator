#!/usr/bin/env python3
from Bio import SeqIO
from Bio.Seq import Seq
from Bio.SeqRecord import SeqRecord
import random
import itertools
import sys, getopt
import argparse

def get_args():
    parser = argparse.ArgumentParser(description='create a new haplotype with random mutations')

    parser.add_argument('-f', '--file', help='file_genome',
    type=str, metavar='FILE', required=True)

    parser.add_argument('-n', '--name', help='name_haplotype',
    type=str, metavar='NAME', required=True)

    parser.add_argument('-m', '--mutation', help='mutation rate',
    type=float, metavar='MUTATION', required=True)

    parser.add_argument('-o', '--output', help='output directory',
    type=str, metavar='OUTPUT', required=True)

    return parser.parse_args()


def mutate(orig_string, mutation_rate):
    bases = "ACGT"
    result = ""
    mutations = []
    for base in orig_string:
        if random.random() < mutation_rate:
            new_base = bases[bases.index(base) - random.randint(1, 3)] # negatives are OK
            result += new_base
            mutations.append((base, new_base))
        else:
            result += base
    print(mutations)
    return result


def main():
   args = get_args()
   outfile= args.output
   infile=args.file
   haplo_name=args.name
   mutation_rate=args.mutation

   for record in SeqIO.parse(infile, "fasta"):
       with open(outfile, "w") as output_handle:
           string=record.seq
           #print(string)
           result = mutate(string, mutation_rate)    
           #print(result)
           new_seq=Seq(result)
           new_record= SeqRecord(new_seq, id=haplo_name)
   
           SeqIO.write(new_record, output_handle, "fasta")


if __name__ == "__main__":main()




