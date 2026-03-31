#!/bin/bash

APP_VERSION="0.3.0"
BASE_URL="https://github.com/artefatto/omit/releases/download/v$APP_VERSION"

BINARY_URL_LINUX="$BASE_URL/BINARY-$APP_VERSION-X86_64-LINUX"
BINARY_URL_MACOS_ARM="$BASE_URL/BINARY-$APP_VERSION-AARCH64-MACOS"
BINARY_URL_MACOS="$BASE_URL/binary-$APP_VERSION-x86_64-macos"
APP_NAME="omit"
OS_TYPE=$OSTYPE
CPU_TYPE=$CPUTYPE


download_and_create_executable() {
	echo "Downloading omit..."

	# Try curl first, fall back to wget
	if command -v curl &> /dev/null; then
		curl -sL "$binary_url" -o "$APP_NAME"
	elif command -v wget &> /dev/null; then
		wget -q "$binary_url" -O "$APP_NAME"
	fi

	if [ $? -ne 0 ]; then
    	echo "Failed to download omit."
    	exit 1
	fi

	echo "Making omit executable..."
	chmod +x "$APP_NAME"
}

linux_install () {
	echo "Moving omit to ~/.local/bin..."
	mv "$APP_NAME" "$HOME/.local/bin/$APP_NAME"

	# Verify installation
	if [ $? -eq 0 ]; then
	    echo "omit installed successfully!"
	else
	    echo "Failed to move omit to ~/.local/bin. You might need sudo privileges."
	    exit 1
	fi

	echo
	echo "Add ~/.local/bin to you PATH so you can run omit from anywhere"
	echo "Then use run omit"
}

macos_install() {
    LOCAL_BIN="$HOME/.local/bin"

    # Create ~/.local/bin if it doesn't exist
    if [ ! -d "$LOCAL_BIN" ]; then
        echo "Creating $LOCAL_BIN..."
        mkdir -p "$LOCAL_BIN"
    fi

    echo "Moving $APP_NAME to $LOCAL_BIN..."
    mv "$APP_NAME" "$LOCAL_BIN/$APP_NAME"

    # Verify installation
    if [ $? -eq 0 ]; then
        echo "$APP_NAME installed successfully!"
    else
        echo "Failed to move $APP_NAME to $LOCAL_BIN. Check permissions."
        exit 1
    fi

    echo
    echo "Add $LOCAL_BIN to your PATH so you can run $APP_NAME from anywhere."
    echo "Example: export PATH=\"\$HOME/.local/bin:\$PATH\""
    echo "Then you can run $APP_NAME"
}

case "$OSTYPE" in
	linux-gnu)
		binary_url=$BINARY_URL_LINUX
		download_and_create_executable
		linux_install
		;;
	darwin*)
		binary_url=$BINARY_URL_MACOS_ARM
		if [[ $CPU_TYPE == "x86_64" ]]; then
			binary_url=$BINARY_URL_MACOS
		fi
		download_and_create_executable
		macos_install
		;;
esac
