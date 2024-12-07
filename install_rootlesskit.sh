#! /usr/bin/bash

# Define variables
export ARCH=aarch64
export ROOTLESSKIT_VERSION=2.3.1

echo "Installing RootlessKit version ${ROOTLESSKIT_VERSION} for ${ARCH}..."

# Define download URL
ROOTLESSKIT_URL="https://github.com/rootless-containers/rootlesskit/releases/download/v${ROOTLESSKIT_VERSION}/rootlesskit-${ARCH}.tar.gz"

# Download and verify
echo "Downloading RootlessKit from: $ROOTLESSKIT_URL"
if curl -fSL "$ROOTLESSKIT_URL" -o /tmp/rootlesskit.tar.gz; then
    echo "Download successful. Extracting RootlessKit..."
else
    echo "Failed to download RootlessKit from $ROOTLESSKIT_URL. Please check the version and architecture."
    exit 1
fi

# Extract and install
sudo mkdir -p /usr/local/bin
if sudo tar -xzvf /tmp/rootlesskit.tar.gz -C /usr/local/bin; then
    echo "RootlessKit successfully installed."
else
    echo "Failed to extract RootlessKit archive."
    exit 1
fi

# Clean up
rm -f /tmp/rootlesskit.tar.gz

# Verify installation
if command -v rootlesskit &> /dev/null; then
    rootlesskit --version
else
    echo "RootlessKit installation failed."
    exit 1
fi

echo "RootlessKit installation complete!"