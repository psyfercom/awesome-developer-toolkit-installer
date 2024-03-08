#!/bin/bash

# Function to install packages using npm
install_npm() {
    package=$1
    npm install -g $package
    if [ $? -eq 0 ]; then
        echo "$package installed successfully with npm."
        npm_packages+=("$package")
        return 0
    else
        return 1
    fi
}

# Function to install packages using yarn
install_yarn() {
    package=$1
    yarn global add $package
    if [ $? -eq 0 ]; then
        echo "$package installed successfully with yarn."
        yarn_packages+=("$package")
        return 0
    else
        return 1
    fi
}

# Function to install packages using pnpm
install_pnpm() {
    package=$1
    pnpm install -g $package
    if [ $? -eq 0 ]; then
        echo "$package installed successfully with pnpm."
        pnpm_packages+=("$package")
        return 0
    else
        return 1
    fi
}

# Function to install packages using pip
install_pip() {
    package=$1
    pip install $package
    if [ $? -eq 0 ]; then
        echo "$package installed successfully with pip."
        pip_packages+=("$package")
        return 0
    else
        return 1
    fi
}

# Function to install packages using cargo
install_cargo() {
    package=$1
    cargo install $package
    if [ $? -eq 0 ]; then
        echo "$package installed successfully with cargo."
        cargo_packages+=("$package")
        return 0
    else
        return 1
    fi
}

# Function to install packages using apt
install_apt() {
    package=$1
    apt install -y $package
    if [ $? -eq 0 ]; then
        echo "$package installed successfully with apt."
        apt_packages+=("$package")
        return 0
    else
        return 1
    fi
}

# Initialize arrays to categorize packages
npm_packages=()
yarn_packages=()
pnpm_packages=()
pip_packages=()
cargo_packages=()
apt_packages=()
failed_packages=()

# List of packages to install
packages_to_install=(
    "gcc"
    "g++"
    "make"
    "cmake"
    "git"
    "vim"
    "nano"
    "curl"
    "wget"
    "tmux"
    "screen"
    "ssh"
    "openssl"
    "zip"
    "unzip"
    "tar"
    "gzip"
    "bzip2"
    "file"
    "htop"
    "iotop"
    "iftop"
    "nethogs"
    "net-tools"
    "traceroute"
    "dnsutils"
    "nmap"
    "tcpdump"
    "strace"
    "ltrace"
    "sysstat"
    "procps"
    "psmisc"
    "lsof"
    "jq"
    "tree"
    "htop"
    "atop"
    "iotop"
    "curl"
    "wget"
    "vim"
    "emacs"
    "nano"
    "htop"
    "iotop"
    "iftop"
    "lsof"
    "netstat"
    "tcpdump"
    "sysstat"
    "nmap"
    "tree"
    "git"
    "subversion"
    "mercurial"
    "gcc"
    "g++"
    "make"
    "cmake"
    "autoconf"
    "automake"
    "libtool"
    "pkg-config"
    "libssl-dev"
    "libffi-dev"
    "python3-dev"
    "python3-pip"
    "ruby"
    "ruby-dev"
    "gem"
    "perl"
    "perl-dev"
    "php"
    "php-dev"
    "php-pear"
    "php-mysql"
    "php-gd"
    "php-curl"
    "php-zip"
    "php-mbstring"
    "php-xml"
    "php-json"
    "nodejs"
    "npm"
    "yarn"
    "pnpm"
    "python3"
    "pip"
    "rustc"
    "cargo"
    "golang-go"
    "java-common"
    "openjdk-11-jdk"
    "openjdk-11-jre"
    "maven"
    "gradle"
    "docker-ce"
)

# Iterate through packages to install them using different package managers
for package in "${packages_to_install[@]}"; do
    if install_npm "$package"; then
        continue
    fi

    if install_yarn "$package"; then
        continue
    fi

    if install_pnpm "$package"; then
        continue
    fi

    if install_pip "$package"; then
        continue
    fi

    if install_cargo "$package"; then
        continue
    fi

    if install_apt "$package"; then
        continue
    fi

    echo "Failed to install $package with any package manager."
    failed_packages+=("$package")
done

# Print categorized packages
echo "Packages installed with npm: ${npm_packages[@]}"
echo "Packages installed with yarn: ${yarn_packages[@]}"
echo "Packages installed with pnpm: ${pnpm_packages[@]}"
echo "Packages installed with pip: ${pip_packages[@]}"
echo "Packages installed with cargo: ${cargo_packages[@]}"
echo "Packages installed with apt: ${apt_packages[@]}"

# Print failed packages if any
if [ ${#failed_packages[@]} -gt 0 ]; then
    echo "The following packages failed to install:"
    printf '%s\n' "${failed_packages[@]}"
fi
