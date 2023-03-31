# add read groups to bam file 
# Matthew Teasdale
# Cambridge 2023

using CSV
using DataFrames

# read sample sheet 
samples = DataFrame(CSV.File(ARGS[1]))

# show(samples)

"""
Input_bam - col 1
Output_bam - col 2
Sample_name - col 3  
Library_name - col 4  
Sequencing_platform - col 5  
Sequencing_centre - col 6
P7_barcode - col 7
P5_barcode - col 8
"""

for row in eachrow(samples)
    bam_file = row[1]
    bam_file_out = row[2]
    sample_name = row[3]
    library_name = row[4]
    sequencing_plat = row[5]
    sequencing_centre = row[6]
    p7_barcode = row[7]
    p5_barcode = row[8]
    run(`gatk AddOrReplaceReadGroups 
	      --VALIDATION_STRINGENCY LENIENT
	      --INPUT $bam_file 
	      --OUTPUT $bam_file_out 
	      --RGID $sample_name-$library_name-$p5_barcode-$p7_barcode-$sequencing_centre
	      --RGLB $library_name 
	      --RGPL $sequencing_plat 
	      --RGPU $library_name-$p5_barcode-$p7_barcode-$sequencing_centre 
	      --RGSM $sample_name
	      --RGCN $sequencing_centre`)
end
