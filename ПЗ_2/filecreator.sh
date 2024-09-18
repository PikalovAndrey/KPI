#!/bin/bash

# Задаємо ім'я для файлів
name="Andrii"

# Знаходимо максимальний номер вже існуючих файлів
max_number=$(find . -maxdepth 1 -name "${name}[0-9]*" | sed "s/${name}//" | sed "s/[^0-9]//g" | sort -n | tail -n 1)

# Якщо файлів не знайдено, починаємо з 0
if [ -z "$max_number" ]; then
    max_number=0
fi

# Створюємо наступні 25 файлів
for i in $(seq 1 25); do
    next_number=$((max_number + i))
    touch "${name}${next_number}"
done

echo "Створено 25 файлів з іменами ${name}$((max_number + 1)) до ${name}$((max_number + 25))"
