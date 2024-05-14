# Promoter_extraction
This repository contains file with code which can be used to extract promoter regions in whole-genome scale. 

gtf_parser.py takes three arguments:
--file=   (Path to gtf file)
--step=   (size of promoter in bp)
--out=    (Path for output file) 
The output of gtf_parser.py is a bed file with coordinates of promoters for each gene 
This bed file could be used directly for bedtools getfasta tool input. Snakefile to launch it for several genomes can be found in repo. 
