#! /usr/bin/bash

# Define variables
export ARCH=arm64
export NERDCTL_VERSION=v2.0.1

echo "Installing nerdctl version ${NERDCTL_VERSION} for ${ARCH}..."

# Define download URL
NERDCTL_URL="https://github.com/containerd/nerdctl/releases/download/${NERDCTL_VERSION}/nerdctl-${NERDCTL_VERSION}-linux-${ARCH}.tar.gz"

# Download and verify
if curl -fSL "$NERDCTL_URL" -o /tmp/nerdctl.tar.gz; then
    echo "Download successful. Extracting nerdctl..."
else
    echo "Failed to download nerdctl from $NERDCTL_URL"
    exit 1
fi

# Extract and install
sudo mkdir -p /usr/local/bin
if sudo tar -xzvf /tmp/nerdctl.tar.gz -C /usr/local/bin; then
    echo "nerdctl successfully installed."
else
    echo "Failed to extract nerdctl archive."
    exit 1
fi

# Clean up
rm -f /tmp/nerdctl.tar.gz

# Verify installation
if command -v nerdctl &> /dev/null; then
    nerdctl --version
else
    echo "nerdctl installation failed."
    exit 1
fi

# Ensure containerd is running
if ! systemctl is-active --quiet containerd; then
    echo "Starting containerd service..."
    sudo systemctl start containerd
    sudo systemctl enable containerd
fi

echo "nerdctl installation and setup complete!"