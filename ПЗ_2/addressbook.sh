#!/bin/bash

# Файл для зберігання адресної книги
ADDRESSBOOK_FILE="addressbook.txt"

# Перевірка наявності файлу і створення, якщо його немає
if [ ! -f "$ADDRESSBOOK_FILE" ]; then
    touch "$ADDRESSBOOK_FILE"
fi

# Функція для додавання нового запису
add_entry() {
    echo "$1 $2" >> "$ADDRESSBOOK_FILE"
}

# Функція для відображення всіх записів
list_entries() {
    if [ ! -s "$ADDRESSBOOK_FILE" ]; then
        echo "Адресна книга порожня"
    else
        cat "$ADDRESSBOOK_FILE"
    fi
}

# Функція для видалення записів за іменем
remove_entry() {
    grep -v "^$1 " "$ADDRESSBOOK_FILE" > temp_file && mv temp_file "$ADDRESSBOOK_FILE"
}

# Функція для видалення всієї адресної книги
clear_entries() {
    > "$ADDRESSBOOK_FILE"
}

# Функція для перегляду всіх електронних адрес для імені
lookup_entry() {
    if [ -z "$1" ]; then
        echo "Використання: $0 lookup <name> [details]"
        exit 1
    fi

    local name="$1"
    local detail_mode="$2"

    if ! grep -q "^$name " "$ADDRESSBOOK_FILE"; then
        echo "Записів для $name не знайдено"
        exit 1
    fi

    if [ "$detail_mode" == "details" ]; then
        grep "^$name " "$ADDRESSBOOK_FILE"
    else
        grep "^$name " "$ADDRESSBOOK_FILE" | awk '{print $3}'
    fi
}

# Головний блок виконання скрипта
case "$1" in
    new)
        if [ "$#" -ne 3 ]; then
            echo "Використання: $0 new <name> <email>"
            exit 1
        fi
        add_entry "$2" "$3"
        ;;
    list)
        list_entries
        ;;
    remove)
        if [ "$#" -ne 2 ]; then
            echo "Використання: $0 remove <name>"
            exit 1
        fi
        remove_entry "$2"
        ;;
    clear)
        clear_entries
        ;;
    lookup)
        if [ "$#" -lt 2 ]; then
            echo "Використання: $0 lookup <name> [details]"
            exit 1
        fi
        lookup_entry "$2" "$3"
        ;;
    *)
        echo "Невідома команда. Доступні команди: new, list, remove, clear, lookup"
        exit 1
        ;;
esac
