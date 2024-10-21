# scRNA-Seq-Analysis

## Introduction to RNA seq
Used to measure gene expression.

### Three main steps for RNA seq
1. Prepare a sequence library
   - Isolate the RNA
     
   - Break RNA into small fragments
     
   - Convert RNA into dsDNA
     
   - Add adapters
     
   - PCR amplification
2. Sequence
   - Sequencer/sequencing machine
     
   - Quality control
     
3. Data analysis

<img width="500" alt="scrnaseq2" src="https://github.com/user-attachments/assets/690089f1-c845-4fd5-8c22-df585aadf375">

### BULK
- Extract RNA
  
- Average gene expression across all the cells
  
- Impossible to compare differences in gene expression between individual cells
  

### SINGLE
- Extract RNA from all the cells
  
- Sequence RNA from each cell and quantify the expression

## Bulk v/s single-cell RNA sequencing

SINGLE-CELL RNA SEQ ADVANTAGES

- Allows you to compare the expression between cells
  
- Identify rare cell population
  
- Understand spatial transcriptomics
  
- Track cell lineage

# Basic Workflow

<img width="600" alt="scRNA4" src="https://github.com/user-attachments/assets/cc679f81-4da5-491d-9f5c-ee3ad05b3640">

### Single-cell Isolation

- Limiting Dilution - Use pipettes to isolate cells by dilution
  
- Micromanipulation - Classic approach used to retrieve cells from samples with a small number of cells such as early embryos
  
- Flow-activated cell sorting - widely used for isolating single cells in suspension
  
- Fraser capture microdissection - An advanced technique used for isolating single cells from solid tissue by using a laser system

### Technologies available

| Method                  | Transcript Coverage | UMI Possibility | Strand Specific |
|-------------------------|---------------------|-----------------|-----------------|
| **Tang method**         | Nearly full-length  | No              | No              |
| **Quartz-Seq**          | Full-length         | No              | No              |
| **SUPeR-seq**           | Full-length         | No              | No              |
| **Smart-seq**           | Full-length         | No              | No              |
| **Smart-seq2**          | Full-length         | No              | No              |
| **MATQ-seq**            | Full-length         | Yes             | Yes             |
| **STRT-seq and STRT/C1**| 5′-only             | Yes             | Yes             |
| **CEL-seq**             | 3′-only             | Yes             | Yes             |
| **CEL-seq2**            | 3′-only             | Yes             | Yes             |
| **MARS-seq**            | 3′-only             | Yes             | Yes             |
| **CytoSeq**             | 3′-only             | Yes             | Yes             |
| **Drop-seq**            | 3′-only             | Yes             | Yes             |
| **InDrop**              | 3′-only             | Yes             | Yes             |
| **Chromium**            | 3′-only             | Yes             | Yes             |
| **SPLiT-seq**           | 3′-only             | Yes             | Yes             |
| **sci-RNA-seq**         | 3′-only             | Yes             | Yes             |
| **Seq-Well**            | 3′-only             | Yes             | Yes             |
| **DroNC-seq**           | 3′-only             | Yes             | Yes             |
| **Quartz-Seq2**         | 3′-only             | Yes             | Yes             |

**Reference:** Chen, G., Ning, B., & Shi, T. (2019). Single-cell RNA-seq technologies and related computational data analysis. Frontiers in Genetics, 10(317). (https://doi.org/10.3389/fgene.2019.00317)

### Read Mapping Tools
#### Tools for Read Mapping and Expression Quantification of scRNA-seq Data

| Tool         | Function                   | Link                                                            |
|--------------|----------------------------|-----------------------------------------------------------------|
| **TopHat2**  | Read mapping               | [TopHat2](https://ccb.jhu.edu/software/tophat/index.shtml)      |
| **STAR**     | Read mapping               | [STAR](https://github.com/alexdobin/STAR)                       |
| **HISAT2**   | Read mapping               | [HISAT2](https://github.com/DaehwanKimLab/hisat2)               |
| **Cufflinks**| Expression quantification  | [Cufflinks](https://github.com/cole-trapnell-lab/cufflinks)     |
| **RSEM**     | Expression quantification  | [RSEM](https://github.com/deweylab/RSEM)                        |
| **StringTie**| Expression quantification  | [StringTie](https://github.com/gpertea/stringtie)               |

**Reference:** Chen, G., Ning, B., & Shi, T. (2019). Single-cell RNA-seq technologies and related computational data analysis. Frontiers in Genetics, 10(317). (https://doi.org/10.3389/fgene.2019.00317)

### scRNA seq Databases
1. scRNASeqDB - (https://bioinfo.uth.edu/scrnaseqdb/)

2. PanglaoDB - (https://panglaodb.se/)
 
3. CancerSea - (http://biocc.hrbmu.edu.cn/CancerSEA/home.jsp)
   
### Packages to analyze scRNA-seq data
1. SingleCellExperiment
  
2. Seurat
   
3. Scater
   
4. Monocle3
   
5. Scanpy



