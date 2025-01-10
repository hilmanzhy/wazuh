#!/bin/bash

# Fungsi untuk mengganti nama file dan folder
rename_items() {
  for item in "$1"/*; do
    # Skip jika item tidak ada
    [ -e "$item" ] || continue

    # Proses direktori terlebih dahulu (rekursif)
    if [ -d "$item" ]; then
      rename_items "$item"
    fi

    # Dapatkan nama dasar dan direktori dari item
    base_name=$(basename "$item")
    dir_name=$(dirname "$item")

    # Ganti semua kemunculan "wazuh" dalam nama file/direktori
    new_name=$(echo "$base_name" | sed -e 's/wazuh/verprotect/g' \
                                       -e 's/Wazuh/Verprotect/g' \
                                       -e 's/WAZUH/VERPROTECT/g')

    # Rename jika nama berubah
    if [ "$base_name" != "$new_name" ]; then
      mv "$item" "$dir_name/$new_name"
    fi
  done

  # Setelah item di dalam folder selesai, ganti nama direktori itu sendiri
  base_dir=$(basename "$1")
  parent_dir=$(dirname "$1")
  new_dir_name=$(echo "$base_dir" | sed -e 's/wazuh/verprotect/g' \
                                        -e 's/Wazuh/Verprotect/g' \
                                        -e 's/WAZUH/VERPROTECT/g')

  if [ "$base_dir" != "$new_dir_name" ]; then
    mv "$1" "$parent_dir/$new_dir_name"
  fi
}

# Direktori awal (direktori saat ini secara default)
start_dir="."

# Jalankan fungsi rename_items
rename_items "$start_dir"

echo "Renaming completed!"

