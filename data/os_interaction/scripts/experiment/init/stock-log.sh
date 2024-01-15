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
    stock_index=$((RANDOM % 100))
    count=$((RANDOM % 1000))
    comment=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 10 | head -n 1)

    # Write the line to the file
    echo "$name | $action | $stock_index | $count | $comment" >> /usr/stock.log
done
