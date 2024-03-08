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

# Initialize arrays to categorize packages
npm_packages=()
apt_packages=()
cargo_packages=()
pip_packages=()
failed_packages=()

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

# Iterate through packages to categorize them and handle updates
for package in "${packages_to_install[@]}"; do
    # Check if package is available through npm
    if npm_package_exists "$package"; then
        npm_packages+=("$package")
        continue
    fi

    # Check if package is available through apt-get
    if apt_package_exists "$package"; then
        apt_packages+=("$package")
        continue
    fi

    # Check if package is available through cargo
    if cargo_package_exists "$package"; then
        cargo_packages+=("$package")
        continue
    fi

    # Check if package is available through pip
    if pip_package_exists "$package"; then
        pip_packages+=("$package")
        continue
    fi

    # If package not found in any package manager, add to failed_packages
    failed_packages+=("$package")
done

# Install packages using corresponding package managers
for package in "${npm_packages[@]}"; do
    install_npm "$package"
done

for package in "${apt_packages[@]}"; do
    install_apt "$package"
done

for package in "${cargo_packages[@]}"; do
    install_cargo "$package"
done

for package in "${pip_packages[@]}"; do
    install_pip "$package"
done

# Print failed packages if any
if [ ${#failed_packages[@]} -gt 0 ]; then
    echo "The following packages failed to install:"
    printf '%s\n' "${failed_packages[@]}"
fi
