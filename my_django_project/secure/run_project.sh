#!/bin/bash

# Location of the password file
PASSWORD_FILE="~/my_django_project/secure/.password"

# Read the stored password from the file
stored_password=$(cat $PASSWORD_FILE)

# Prompt for the password
echo "Enter password to run the Django project:"
read -s user_password

# Check if the entered password matches the stored password
if [[ "$user_password" == "$stored_password" ]]; then
    echo "Password correct. Starting Django server..."
    # Change to the project directory
    cd ~/my_django_project
    # Activate the virtual environment
    source venv/bin/activate
    # Run the Django development server
    python manage.py runserver
else
    echo "Incorrect password. Access denied."
    exit 1
fi
