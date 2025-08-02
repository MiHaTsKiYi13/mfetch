#!/bin/bash


source /etc/os-release

echo "[+] Installing build tools..."

case "$ID" in
    arch | manjaro)
        sudo pacman -Sy --noconfirm base-devel
        ;;
    ubuntu | debian)
        sudo apt update && sudo apt install -y build-essential
        ;;
    fedora)
        sudo dnf install -y make automake gcc gcc-c++ kernel-devel
        ;;
    opensuse* | sles)
        sudo zypper install -y make gcc
        ;;
    alpine)
        sudo apk add make gcc musl-dev
        ;;
    *)
        echo "Unsupported distro: $ID"
        exit 1
        ;;
esac

echo "[+] Building mfetch..."

sudo make install

chmod +x mfetch

./mfetch

# Уведомление
echo "mfetch is now installed!"
