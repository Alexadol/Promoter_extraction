import argparse
import re

def print_result(line, step,id):
    line_split=line.split()
    if line_split[6]=='+':
        beg=int(line_split[3])-step
        if beg<0:
            beg=0
        end=int(line_split[3])+1000
        chrn=line_split[0]
    else:
        beg=int(line_split[4])-1000
        end=int(line_split[4])+step
        chrn=line_split[0]
    file=open(args.out,'a')
    file.write(chrn+"\t"+str(beg)+"\t"+str(end)+"\t"+id+'_'+spec_name[:-8]+'\n')

parser = argparse.ArgumentParser()

parser.add_argument('--file', type=str)
parser.add_argument('--id', type=str)
parser.add_argument('--step', type=int)
parser.add_argument('--out', type=str)

args = parser.parse_args()

step=args.step
ids=open(args.id, 'r')

name_str = str(args.id).split('/')
spec_name = name_str[len(name_str)-1]

for line in ids:
    print(line)
    id = line.rstrip()
    final_pattern="="+id+";"
    with open(args.file) as file:
        f=False
        for line in file:
            if f:
                break
            if final_pattern in line:
                line_type=line.split()[2]
                if line_type == "gene" or line_type == "mRNA":
                    print("\nFound\n"+id)
                    print_result(line, step,id)
                    break
                else:
                    parent_id=re.search(r"Parent=[^;\n]+(;|\n)",line).group(0)
                    id_pattern="ID="+parent_id[7:]
                    with open(args.file) as my_file:
                        for parent_line in my_file:
                            if id_pattern in parent_line:
                                print_result(parent_line, step,id)
                                f=True
                                break
                                               
