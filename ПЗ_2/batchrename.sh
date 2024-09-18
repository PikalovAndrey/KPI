#!/bin/bash

# Перевірка, чи є всі аргументи заданими
if [ "$#" -ne 3 ]; then
    echo "Використання: $0 <каталог> <оригінальне_розширення> <нове_розширення>"
    exit 1
fi

# Задаємо змінні
directory="$1"
original_ext="$2"
new_ext="$3"

# Перевіряємо, чи каталог існує
if [ ! -d "$directory" ]; then
    echo "Каталог не знайдено: $directory"
    exit 1
fi

# Перейменування файлів
shopt -s nullglob  # Налаштування, щоб wildcard не повертав нічого, якщо немає відповідних файлів
files=("$directory"/*."$original_ext")

if [ ${#files[@]} -eq 0 ]; then
    echo "Не знайдено файлів з розширенням .$original_ext у каталозі $directory"
    exit 0
fi

for file in "${files[@]}"; do
    base_name=$(basename "$file" .$original_ext)
    new_file="$directory/${base_name}.$new_ext"
    echo "Переіменовую $file на $new_file"
    mv "$file" "$new_file"
done
