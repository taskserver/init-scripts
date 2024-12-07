#! /usr/bin/bash

# Define variables
export ARCH=aarch64
export ROOTLESSKIT_VERSION=2.3.1
export SLIRP4NETNS_VERSION=v1.3.1

echo "Installing RootlessKit version ${ROOTLESSKIT_VERSION} for ${ARCH}..."

# Install RootlessKit
ROOTLESSKIT_URL="https://github.com/rootless-containers/rootlesskit/releases/download/v${ROOTLESSKIT_VERSION}/rootlesskit-${ARCH}.tar.gz"
echo "Downloading RootlessKit from: $ROOTLESSKIT_URL"
if curl -fSL "$ROOTLESSKIT_URL" -o /tmp/rootlesskit.tar.gz; then
    echo "Download successful. Extracting RootlessKit..."
else
    echo "Failed to download RootlessKit from $ROOTLESSKIT_URL. Please check the version and architecture."
    exit 1
fi

sudo mkdir -p /usr/local/bin
if sudo tar -xzvf /tmp/rootlesskit.tar.gz -C /usr/local/bin; then
    echo "RootlessKit successfully installed."
else
    echo "Failed to extract RootlessKit archive."
    exit 1
fi
rm -f /tmp/rootlesskit.tar.gz

# Install slirp4netns
echo "Installing slirp4netns version ${SLIRP4NETNS_VERSION}..."
SLIRP4NETNS_URL="https://github.com/rootless-containers/slirp4netns/releases/download/${SLIRP4NETNS_VERSION}/slirp4netns-${ARCH}"
if curl -fSL "$SLIRP4NETNS_URL" -o /tmp/slirp4netns; then
    echo "Download successful. Installing slirp4netns..."
else
    echo "Failed to download slirp4netns from $SLIRP4NETNS_URL. Please check the version and architecture."
    exit 1
fi

sudo mv /tmp/slirp4netns /usr/local/bin/slirp4netns
sudo chmod +x /usr/local/bin/slirp4netns

# Verify installations
if command -v rootlesskit &> /dev/null && command -v slirp4netns &> /dev/null; then
    echo "RootlessKit and slirp4netns successfully installed."
else
    echo "Installation failed for RootlessKit or slirp4netns."
    exit 1
fi

# Verify slirp4netns functionality
slirp4netns --version

echo "Installation of RootlessKit and dependencies complete!"