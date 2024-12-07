#! /usr/bin/bash

export ARCH=arm64
export CNI_VERSION=v1.6.1

echo "Installing CNI plugins version ${CNI_VERSION} for ${ARCH}..."
sudo mkdir -p /opt/cni/bin
curl -sSL https://github.com/containernetworking/plugins/releases/download/${CNI_VERSION}/cni-plugins-linux-${ARCH}-${CNI_VERSION}.tgz | sudo tar -xz -C /opt/cni/bin

# Make a config folder for CNI definitions
sudo mkdir -p /etc/cni/net.d

# Make an initial loopback configuration
sudo sh -c 'cat >/etc/cni/net.d/99-loopback.conf <<-EOF
{
    "cniVersion": "1.6.1",
    "type": "loopback"
}
EOF'