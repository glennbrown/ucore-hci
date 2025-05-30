#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# This installs a package from fedora repos
# Homebrew Dependencies
dnf group install -y development-tools
# Homebrew via ublue-os copr repo
dnf copr enable -y ublue-os/packages
dnf install -y ublue-brew
dnf copr disable -y ublue-os/packages
#### Many of these packages do exist in brew but I think they make sense to install from Fedora
# lm_sensors, smartmontools
dnf install -y lm_sensors smartmontools
# Git Extras
dnf install -y git-crypt
# Legacy tools, probaly don't need thme but nice to have
dnf install -y ftp telnet rsh whois tftp
# Compression tools
dnf install -y p7zip zip unzip
# Disk tools (snapper is for being able to do snapraid-btrfs)
dnf install -y bcachefs-tools sg3_utils hddtemp snapper nvme-cli
# Intel GPU Tools and Drivers 
dnf install -y igt-gpu-tools intel-mediasdk libva-intel-media-driver libvdpau-va-gl intel-compute-runtime intel-gmmlib libva libva-utils glx-utils
# Extra tools 
dnf install -y busybox ipmitool just lsb_release redhat-lsb iotop-c pipx strace
# zsh
dnf install -y zsh
# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

systemctl enable brew-setup.service
