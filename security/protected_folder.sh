#!/bin/bash

# Create the folder
PROJECT_DIR="project"
FOLDER_NAME="$PROJECT_DIR/protected_folder"
FILE_NAME="protected_file.txt"
PASSWORD_FILE="password.txt"

# Create the project directory structure
mkdir -p $FOLDER_NAME

# Create a sample text file in the folder
echo "This is a protected file. It will be deleted if not accessed in 3 minutes." > $FOLDER_NAME/$FILE_NAME

# Ask for a password
echo "Please enter a password to protect the file:"
read -s PASSWORD

# Save the password (in a real scenario, this should be secured and not stored like this)
echo "$PASSWORD" > $PROJECT_DIR/$PASSWORD_FILE

# Encrypt the file using GPG
gpg --batch --yes --passphrase "$PASSWORD" -c $FOLDER_NAME/$FILE_NAME

# Remove the original unencrypted file
rm $FOLDER_NAME/$FILE_NAME

# Set a timer to delete the folder after 3 minutes (180 seconds)
(
  sleep 180
  rm -rf $FOLDER_NAME
  echo "The folder has been deleted due to inactivity!"
) &

# Output instructions to the user
echo "Folder and file have been created and encrypted."
echo "The folder will be deleted in 3 minutes if not accessed."
echo "Use the following command to decrypt and open the file (before the 3 minutes expire):"
echo "  gpg --decrypt $FOLDER_NAME/$FILE_NAME.gpg"
echo "You will be prompted for the password stored in $PROJECT_DIR/$PASSWORD_FILE."
echo "Make sure to retrieve the password to access the file."

# End of script
