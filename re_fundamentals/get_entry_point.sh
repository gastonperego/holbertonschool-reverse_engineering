#!/bin/bash

# Check if the file is passed as an argument
if [ -z "$1" ]; then
    echo "Usage: get_entry_point ELFfile"
    exit 1
fi

file_name="$1"

file_type=$(file "$file_name" | grep -o "ELF")
if [ "$file_type" != "ELF" ]; then
    echo "Error: '$file_name' is not an ELF file."
    exit 1
fi

magic_number=$(readelf -h "$file_name" | grep -oP 'Magic:\s+\K([0-9a-fA-F]{2}\s){15}[0-9a-fA-F]{2}')
class=$(readelf -h "$file_name" | grep "Class:" | awk '{print $2}')
byte_order=$(readelf -h "$file_name" | grep "Data:" | awk '{print $4, $5}')
entry_point_address=$(readelf -h "$file_name" | grep "Entry point address:" | awk '{print $4}')

source messages.sh

display_elf_header_info
