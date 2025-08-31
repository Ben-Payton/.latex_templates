#!/bin/bash

PATH_TO_TEMPLATES="${HOME}/.latex_templates"

PROJECT_NAME=$1

echo "choose a temlate"

counter=1

for file in "$PATH_TO_TEMPLATES"/*.tex; do
    echo $counter : "$(basename "$file" .tex)"
    ((counter++))
done

while true; do
    read -p "Enter an integer less than $MAX: " input

    # Check if the input is a valid integer
    if [[ "$input" =~ ^-?[0-9]+$ ]]; then
        # Check if it's less than MAX
        if (( input <=  counter )); then
            echo "You entered a valid integer: $input"
            break
        else
            echo "The number must be less than or equal to $counter."
        fi
    else
        echo "Invalid input. Please enter a valid integer."
    fi
done

counter=1

for file in "$PATH_TO_TEMPLATES"/*.tex; do
    if [[ $counter  -eq $input ]]; then
        template_file=$file
        ((counter++))
    fi
done
echo $template_file
git init $PROJECT_NAME
cp $template_file ./$PROJECT_NAME/main.tex
echo "*.aux
*.fdb_latexmk
*.fls
*.log
*.synctex.gz">> ./$PROJECT_NAME/.gitignore