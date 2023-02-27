# Read bam file and produce read length table
# Matthew Teasdale
# University of Cambridge 2023

using XAM
using FreqTables

reader = open(BAM.Reader, ARGS[1])

read_lengths =  Int64[]

for record in reader
    # `record` is a BAM.Record object.
    if BAM.ismapped(record)
        # Print the mapped position.
        append!(read_lengths, XAM.BAM.alignlength(record))
        
    end
end

println("Read ", length(read_lengths), " records from ", ARGS[1])
show(freqtable(read_lengths))
println()

