#! /usr/bin/bash

# Define variables
export ARCH=arm64
export NERDCTL_VERSION=v2.0.1

echo "Installing nerdctl version ${NERDCTL_VERSION} for ${ARCH}..."

# Download nerdctl
sudo mkdir -p /usr/local/bin
curl -sSL https://github.com/containerd/nerdctl/releases/download/${NERDCTL_VERSION}/nerdctl-${NERDCTL_VERSION}-linux-${ARCH}.tar.gz | sudo tar -xz -C /usr/local/bin

# Verify installation
if command -v nerdctl &> /dev/null; then
    echo "nerdctl successfully installed."
    nerdctl --version
else
    echo "Failed to install nerdctl."
    exit 1
fi

# Additional setup if needed
# For example, ensure containerd is running:
if ! systemctl is-active --quiet containerd; then
    echo "Starting containerd service..."
    sudo systemctl start containerd
    sudo systemctl enable containerd
fi

echo "nerdctl installation and setup complete!"