#!/bin/bash

# Define the possible values for each field
names=("Alice" "Bob")
actions=("Purchase" "Sell")

# Generate 400 random lines
for ((i=1; i<=401; i++))
do
    # Randomly select values for each field
    name=${names[$RANDOM % ${#names[@]}]}
    action=${actions[$RANDOM % ${#actions[@]}]}
    stock_index="idx=$((RANDOM % 100))"
    count="count=$((RANDOM % 1000))"
    comment=$(shuf -n 15 /usr/share/dict/words | tr '\n' ' ')

    # Write the line to the file
    echo "$name | $action | $stock_index | $count | $comment" >> /usr/stock.log
done
