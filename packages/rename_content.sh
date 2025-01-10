#!/bin/bash

# Fungsi untuk mengganti nama file dan direktori
rename_items() {
  for item in "$1"/*; do
    # Skip jika item tidak ada
    [ -e "$item" ] || continue

    # Proses direktori terlebih dahulu (rekursif)
    if [ -d "$item" ]; then
      rename_items "$item"
    fi

    # Proses file dan direktori
    base_name=$(basename "$item")
    dir_name=$(dirname "$item")

    # Ganti nama dengan mengganti semua pola yang cocok
    new_name=$(echo "$base_name" | sed -e 's/wazuh/verprotect/g' \
                                       -e 's/Wazuh/Verprotect/g' \
                                       -e 's/WAZUH/VERPROTECT/g')

    # Rename jika nama berubah
    if [ "$base_name" != "$new_name" ]; then
      mv "$item" "$dir_name/$new_name"
      item="$dir_name/$new_name" # Perbarui item untuk proses berikutnya
    fi
  done

  # Setelah semua item dalam folder selesai, ganti nama folder itu sendiri
  base_dir=$(basename "$1")
  parent_dir=$(dirname "$1")
  new_dir_name=$(echo "$base_dir" | sed -e 's/wazuh/verprotect/g' \
                                        -e 's/Wazuh/Verprotect/g' \
                                        -e 's/WAZUH/VERPROTECT/g')

  if [ "$base_dir" != "$new_dir_name" ]; then
    mv "$1" "$parent_dir/$new_dir_name"
  fi
}

# Fungsi untuk mengganti isi file
replace_content() {
  for item in "$1"/*; do
    # Skip jika item tidak ada
    [ -e "$item" ] || continue

    # Proses direktori terlebih dahulu (rekursif)
    if [ -d "$item" ]; then
      replace_content "$item"
    fi

    # Proses file
    if [ -f "$item" ]; then
      # Ganti isi file: wazuh → verprotect, Wazuh → Verprotect, WAZUH → VERPROTECT
      sed -i 's/wazuh/verprotect/g' "$item"
      sed -i 's/Wazuh/Verprotect/g' "$item"
      sed -i 's/WAZUH/VERPROTECT/g' "$item"
    fi
  done
}

# Direktori awal (default: direktori saat ini)
start_dir="."

# Jalankan fungsi rename_items dan replace_content
rename_items "$start_dir"
replace_content "$start_dir"

echo "Renaming and content replacement completed!"

