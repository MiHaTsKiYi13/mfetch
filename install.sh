#!/bin/bash

# Проверка существования /etc/os-release
if [ ! -f /etc/os-release ]; then
    echo "Cannot detect OS: /etc/os-release not found"
    exit 1
fi

. /etc/os-release  # POSIX-совместимая альтернатива source

echo "[+] Installing build tools for: $ID..."

case "$ID" in
    arch | manjaro)
        sudo pacman -Sy --noconfirm base-devel
        ;;
    ubuntu | debian | kali | pop | linuxmint)
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
    void)
        sudo xbps-install -Sy base-devel
        ;;
    gentoo)
        sudo emerge --ask sys-devel/gcc
        ;;
    *)
        echo "Unsupported distro: $ID"
        exit 1
        ;;
esac

echo "[+] Building mfetch..."

# Компиляция и установка
make || { echo "Make failed!"; exit 1; }

sudo make install || { echo "Make install failed!"; exit 1; }

chmod +x mfetch

echo "[+] Running mfetch..."
./mfetch

echo "mfetch is now installed and ready to use!"
