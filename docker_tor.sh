#!/bin/bash

# Update system
echo "Updating system..."
sudo apt update && sudo apt upgrade -y

# Install dependencies for Docker
echo "Installing dependencies for Docker..."
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y

# Add Docker GPG key
echo "Adding Docker GPG key..."
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Add Docker repository
echo "Adding Docker repository..."
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update apt sources and install Docker
echo "Installing Docker..."
sudo apt update
sudo apt install docker-ce -y

# Start and enable Docker
echo "Starting Docker service..."
sudo systemctl start docker
sudo systemctl enable docker

# Install Docker Compose
echo "Installing Docker Compose..."
sudo curl -L "https://github.com/docker/compose/releases/download/v2.16.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Verify Docker and Docker Compose installations
echo "Verifying Docker and Docker Compose versions..."
docker --version
docker-compose --version

# Install Tor
echo "Installing Tor..."
echo "deb https://deb.torproject.org/torproject.org $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/torproject.list
curl https://deb.torproject.org/torproject.org/keys/archive.asc | sudo gpg --dearmor -o /usr/share/keyrings/tor-archive-keyring.gpg
sudo apt update
sudo apt install tor torbrowser-launcher -y

# Start and enable Tor
echo "Starting Tor service..."
sudo systemctl start tor
sudo systemctl enable tor

# Verify Tor installation
echo "Verifying Tor installation..."
curl --socks5 127.0.0.1:9050 https://check.torproject.org

echo "Installation Complete!"
