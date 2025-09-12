#!/usr/bin/env bash

set -e  # exit on error
set -u  # treat unset vars as errors
set -o pipefail # catch errors in pipelines

log() {
    echo -e "${GREEN}[+] $1${NC}"
}

update_system() {
    log "Updating system packages..."
    sudo apt-get update -y
    sudo apt-get upgrade -y
}

install_basic_tools() {
    log "Installing basic tools (curl, wget, unzip, git, make, python3, pip, venv)..."
    sudo apt-get install -y \
        curl wget unzip git make \
        python3 python3-pip python3-venv \
        software-properties-common
}

install_postgres_client() {
    log "Installing PostgreSQL client..."
    sudo apt-get install -y postgresql-client
}

install_docker() {
    log "Installing Docker CE..."
    # Remove older versions if any
    sudo apt-get remove -y docker docker-engine docker.io containerd runc || true

    # Install prerequisites
    sudo apt-get install -y apt-transport-https ca-certificates gnupg lsb-release

    # Add Docker’s official GPG key
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker.gpg

    # Set up stable repository
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    # Install Docker
    sudo apt-get update -y
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    # Enable & add vagrant user to docker group
    sudo systemctl enable docker
    sudo usermod -aG docker vagrant
}

main() {
    update_system
    install_basic_tools
    install_postgres_client
    install_docker
    log "Bootstrap completed! Please log out and log back in (or run 'newgrp docker') to use Docker without sudo."
}

main "$@"