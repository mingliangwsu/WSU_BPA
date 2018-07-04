#!/bin/bash
qsub -v irrigation="TRUE",vic_out_dir="/fastscratch/liuming/BPA_180703",output_dir="/fastscratch/liuming/BPA_180703_stat" post_process_stat.pbs
