import argparse
import re

def print_result(line, step):
    line_split=line.split()
    gene_name=line.split()[8].split(";")[0]
    if line_split[6]=='+':
        beg=int(line_split[3])-step
        if beg<0:
            beg=0
        end=int(line_split[3])
        chrn=line_split[0]
    else:
        beg=int(line_split[4])
        end=int(line_split[4])+step
        chrn=line_split[0]
    file_out=open(args.out,'a')
    file_out.write(chrn+"\t"+str(beg)+"\t"+str(end)+"\t"+gene_name+'\n')

parser = argparse.ArgumentParser()

parser.add_argument('--file', type=str)
parser.add_argument('--step', type=int)
parser.add_argument('--out', type=str)

args = parser.parse_args()

step=args.step

with open(args.file) as file:
    for line in file:
        if line.startswith('##'):
            continue
        else:
            line_type=line.split()[2]
            if line_type == "mRNA":
                print_result(line, step)
                                               
