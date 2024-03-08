#!/bin/bash

# Install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

# Install Rust (choose 1 for automatic install)
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Install Python3 and pip
sudo apt-get update
sudo apt-get install -y python3 python3-pip

# Install latest Node.js with nvm
nvm install node

# Install pnpm and yarn
npm install -g pnpm yarn

# Function to install packages using npm
install_npm() {
    package=$1
    npm install -g $package
    if [ $? -eq 0 ]; then
        echo "$package installed successfully."
    else
        echo "Failed to install $package with npm."
        failed_packages+=("$package")
    fi
}

# Function to install packages using apt-get
install_apt() {
    package=$1
    sudo apt-get install -y $package
    if [ $? -eq 0 ]; then
        echo "$package installed successfully."
    else
        echo "Failed to install $package with apt-get."
        failed_packages+=("$package")
    fi
}

# Function to install packages using cargo
install_cargo() {
    package=$1
    cargo install $package
    if [ $? -eq 0 ]; then
        echo "$package installed successfully."
    else
        echo "Failed to install $package with cargo."
        failed_packages+=("$package")
    fi
}

# Function to install packages using pip
install_pip() {
    package=$1
    pip install $package
    if [ $? -eq 0 ]; then
        echo "$package installed successfully."
    else
        echo "Failed to install $package with pip."
        failed_packages+=("$package")
    fi
}

# List of packages to install
packages_to_install=(
    "code"
    "git"
    "docker"
    "default-jdk"
    "gcc"
    "openjdk-17-jdk"
    "postgresql"
    "mysql-server"
    "mongodb"
    "openssh-client"
    "vim"
    "nano"
    "sublime-text"
    "eclipse"
    "intellij-idea-community"
    "android-studio"
    "anaconda"
    "jupyter-notebook"
    "apache2"
    "nginx"
    "php"
    "ruby"
    "golang"
    "cmake"
    "make"
    "maven"
    "gradle"
    "tensorflow"
    "pytorch"
    "python3-flask"
    "python3-django"
    "node-express-generator"
    "spring"
    "reactjs"
    "vue"
    "electron"
    "qt5-default"
    "wireshark"
    "postman"
    "gitlab"
    "jenkins"
    "travis"
    "grafana"
    "prometheus"
    "elasticsearch"
    "kibana"
)

# Main script
failed_packages=()
for package in "${packages_to_install[@]}"; do
    install_npm "$package" || install_apt "$package" || install_cargo "$package" || install_pip "$package"
done

# Print failed packages if any
if [ ${#failed_packages[@]} -gt 0 ]; then
    echo "The following packages failed to install:"
    printf '%s\n' "${failed_packages[@]}"
fi
