#!/bin/bash

# Function to print messages in different colors
print_message() {
    local message=$1
    local color=$2
    case $color in
        red) echo -e "\e[31m$message\e[0m" ;;
        green) echo -e "\e[32m$message\e[0m" ;;
        yellow) echo -e "\e[33m$message\e[0m" ;;
        blue) echo -e "\e[34m$message\e[0m" ;;
        purple) echo -e "\e[35m$message\e[0m" ;;
        cyan) echo -e "\e[36m$message\e[0m" ;;
        *) echo -e "$message" ;;
    esac
}

# Function to stop and remove all Docker containers
cleanup_docker() {
    print_message "Stopping all running Docker containers..." "yellow"
    docker stop $(docker ps -aq) > /dev/null 2>&1
    print_message "All containers stopped." "green"

    print_message "Removing all Docker containers..." "yellow"
    docker rm $(docker ps -aq) > /dev/null 2>&1
    print_message "All containers removed." "green"
}

# Function to navigate to the directory and run docker-compose
start_docker_compose() {
    # Change to the folder where docker-compose.yml is located
    local folder_path=$1
    print_message "Changing directory to: $folder_path" "yellow"
    cd "$folder_path" || { print_message "Directory not found! Exiting." "red"; exit 1; }

    print_message "Starting services with docker-compose..." "yellow"
    docker-compose up -d > /dev/null 2>&1
    print_message "Services started successfully." "green"
}

# Function to check and print the Onion domain
get_onion_domain() {
    local hidden_service_dir="/var/lib/tor/hidden_service/hostname"

    # Check if the file with the .onion domain exists
    if [ -f "$hidden_service_dir" ]; then
        onion_domain=$(cat "$hidden_service_dir")
        print_message "Your .onion domain is: $onion_domain" "cyan"
    else
        print_message "Error: Could not find the .onion domain." "red"
        exit 1
    fi
}

# Main function to run the script
main() {
    # Confirm if the script is running as root (needed for Docker commands)
    if [ "$(id -u)" -ne 0 ]; then
        print_message "This script must be run as root (use sudo)." "red"
        exit 1
    fi

    print_message "Starting the Tor setup script..." "blue"
    print_message "Step 1: Cleaning up Docker containers..." "blue"
    cleanup_docker

    # Set the path to the folder where docker-compose.yml is located
    local folder_path="/path/to/your/folder"

    print_message "Step 2: Starting Docker services with docker-compose..." "blue"
    start_docker_compose "$folder_path"

    print_message "Step 3: Retrieving the Onion domain..." "blue"
    get_onion_domain
}

# Run the main function
main
