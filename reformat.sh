#!/bin/bash

# Raw fasta input file
input_fasta_file="sequences.fasta"

# Create new header line for fasta sequence
get_new_accession_string() {
    accession=$(echo $1 | awk '{print $1}' | cut -d ">" -f2)
    species_name=$(echo $1 | awk '{print $2"_"$3}')
    new_accession_name="$species_name"_"$accession"
    separator=" "
    new_line=">"$new_accession_name" "${1#*> * }
    echo $new_line
}

# Write new fasta file with modified headers
reformat_fasta() {
    output_file="reformatted_$input_fasta_file"
    while IFS= read -r line; do
        if [[ ${line:0:1} == ">" ]]; then
            echo "$(get_new_accession_string "$line")" >> "$output_file"
        else
            echo "$line" >> "$output_file"
        fi
    done < "$input_fasta_file"
}

reformat_fasta "$input_fasta_file"