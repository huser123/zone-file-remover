#!/bin/bash

# Kezdeti változók
count=0

# Ideiglenes fájl a törölt fájlok számolásához
temp_file=$(mktemp)
echo 0 > "$temp_file"

# Mappa bejárása rekurzívan
find . -type f -name "*Zone.Identifier:\$DATA" | while read -r file; do
    # Törlés és számláló növelése
    if rm -f "$file"; then
        echo "Törölve: $file"
        current_count=$(<"$temp_file")
        echo $((current_count + 1)) > "$temp_file"
    else
        echo "Hiba történt a törléskor: $file"
    fi
done

# Összesített törölt fájlok száma
count=$(<"$temp_file")
rm -f "$temp_file"

# Összesítés kiírása
echo "Összesen törölt fájlok: $count"
