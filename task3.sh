#!/bin/bash

read -p "Введите число: " number

if [ "$number" -gt 0 ]; then
    echo "Число положительное."
elif [ "$number" -lt 0 ]; then
    echo "Число отрицательное."
else
    echo "Вы ввели ноль."
fi

if [ "$number" -gt 0 ]; then
    echo "Подсчёт от 1 до $number:"
    count=1
    while [ "$count" -le "$number" ]; do
        echo "$count"
        count=$((count + 1))
    done
fi

