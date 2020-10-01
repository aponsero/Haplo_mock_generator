# Haplo_mock_generator
Pipeline for the generation of mock haplotype communities - HPC parrallelization (PBS scheduler)


## Requirements

### Python
This pipeline uses Python3.6 and needs the module [BioPython](https://biopython.org/)
### GemSim
This pipeline uses [GemSim](https://bmcgenomics.biomedcentral.com/articles/10.1186/1471-2164-13-74) to simulate metagenomic reads. The tool's code was modified to correct bugs from the original tool. The corrected code is available in the folder "Scripts/workers" in this repository. No need to install the tool as it is provided with this repository.

## Installation

### Create a python environment called "bio"
 ```bash
 conda create -n bio python=3.6
 
 conda activate bio
 
 pip install biopython
 
```

## Quick start

### Edit scripts/config.sh file

please modify the
  - PROFILE= path to the csv file describing the mock community. An exemple of possible profile is available in "test/profile_test.csv"
  - FILE= Path to the Fasta genome to use to create the haplotypes
  - MUTRATE= mutation rate (float number between 0 and 1) for the haplotypes
  - OUT_DIR= path to the output directory. If the directory doesn't yet exist, it will be created when running the tool.
  - NB_READS= nb of reads to generate in the artificial metagenome
  
According to your user profile modify:
  - GROUP = your HPC billing group
  - MAIL_USER = your hpc email

You can also modify

  - MAIL_TYPE = change the mail type option. By default set to "bea".
  - QUEUE = change the submission queue. By default set to "standard".
  
  ### Run pipeline
  
  Run 
  ```bash
  ./run.sh
  ```
  This command will place two job in queue.
