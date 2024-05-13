PROTEOMS, = glob_wildcards("/home/alexadol/Work/Yandex.Disk/Alexa/Tables_and_databases/Proteins/{proteome}.faa")


rule all:
    input:
        expand("getfasta_out_1000/{proteome}.fasta", proteome=PROTEOMS)


rule proteinortho:
    input:
        fasta="/home/alexadol/Work/Yandex.Disk/Alexa/ChIP_seq/Promoter_non_legumes/MtrunA17_Chr5g0409341_MtIPD3.faa",
	    prot="/home/alexadol/Work/Yandex.Disk/Alexa/Tables_and_databases/Proteins/{proteome}.faa",
    output:
        "{proteome}.proteinortho-graph"
    params:
	    project="{proteome}"
    shell:
	    "proteinortho -e=1e-30  -project={params.project} {input.fasta} {input.prot}"


rule proteinortho_cut:
    input:
        "{proteome}.proteinortho-graph"
    output:
        "input_ids_1000/{proteome}_ids.txt"
    shell:
        """
        cut -f 1,2 {input} | grep -v "#"| cut -f 2 > {output}
	"""

rule extract_gene_coordinate:
    input:
        id="input_ids_1000/{proteome}_ids.txt",
        file="/home/alexadol/Work/Yandex.Disk/Alexa/Tables_and_databases/GFF/{proteome}.gff"
    output:
        "gene_coordinates_1000/{proteome}.bed"
    shell:"python3 gtf.py --id={input.id} --file={input.file} --out={output} --step=1000"


rule get_fasta:
    input:
        bed="gene_coordinates_1000/{proteome}.bed",
        fa="/home/alexadol/Work/Yandex.Disk/Alexa/Tables_and_databases/Fasta_whole/{proteome}.fna"
    output:
        "getfasta_out_1000/{proteome}.fasta"
    shell:
        "bedtools getfasta -fi {input.fa} -bed {input.bed} -name -s > {output}"
