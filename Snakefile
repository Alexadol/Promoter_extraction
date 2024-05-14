#Path to gtf files 
GENOMES, = glob_wildcards("/home/Genomes/GTF/{genome}.gtf")

rule all:
    input:
        expand("getfasta_out_3000/{genome}.fasta", genome=GENOMES)


rule extract_gene_coordinate:
    input:
        file="/home/alexadol/Work/Yandex.Disk/Alexa/Tables_and_databases/GFF/{genome}.gff"
    output:
        "gene_coordinates_3000/{genome}.bed"
    shell:"python3 gtf.py  --file={input.file} --out={output} --step=3000"


rule get_fasta:
    input:
        bed="gene_coordinates_3000/{genome}.bed",
	#Path to genomes fasta files 
        fa="/home/Genomes/Fasta/{genome}.fna"
    output:
        "getfasta_out_3000/{genome}.fasta"
    shell:
        "bedtools getfasta -fi {input.fa} -bed {input.bed} -name -s > {output}"
