#!/bin/bash

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

# Function to automate user input for package manager installations
install_with_confirmation() {
    package_manager=$1
    package=$2
    case $package_manager in
        "apt-get")
            sudo apt-get install -y $package
            ;;
        "npm")
            npm install -g $package
            ;;
        "cargo")
            cargo install $package
            ;;
        "pip")
            pip install $package
            ;;
    esac
    if [ $? -eq 0 ]; then
        echo "$package installed successfully."
    else
        echo "Failed to install $package with $package_manager."
        failed_packages+=("$package")
    fi
}

# Install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
source ~/.bashrc

# Install Rust without interaction
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source ~/.cargo/env

# List of packages to install
packages_to_install=(
    "code"
    "git"
    "python3"
    "nodejs"
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
    "rustc"
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
    install_with_confirmation "apt-get" "$package" || install_with_confirmation "npm" "$package" || install_with_confirmation "cargo" "$package" || install_with_confirmation "pip" "$package"
done

# Print failed packages if any
if [ ${#failed_packages[@]} -gt 0 ]; then
    echo "The following packages failed to install:"
    printf '%s\n' "${failed_packages[@]}"
fi

# Source .bashrc and .cargo/env to reflect changes
source ~/.bashrc
source ~/.cargo/env
