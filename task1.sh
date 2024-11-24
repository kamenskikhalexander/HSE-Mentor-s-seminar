#!/bin/bash

echo "Список файлов и их типов:"
for entry in *; do
    if [ -d "$entry" ]; then
        echo "$entry: каталог"
    elif [ -f "$entry" ]; then
        echo "$entry: файл"
    elif [ -L "$entry" ]; then
        echo "$entry: символическая ссылка"
    else
        echo "$entry: другой тип"
    fi
done

if [ -z "$1" ]; then
    echo "Ошибка: укажите имя файла в качестве аргумента."
    exit 1
fi

if [ -e "$1" ]; then
    echo "Файл '$1' найден."
else
    echo "Файл '$1' отсутствует."
fi

echo "Информация о файлах в текущей директории:"
for entry in *; do
    permissions=$(ls -ld "$entry" | awk '{print $1}')
    echo "Имя: $entry, Права доступа: $permissions"
done
