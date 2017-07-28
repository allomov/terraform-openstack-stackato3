#!/usr/bin/env bash
set -e

echo "stackato" | sudo -S bash -c "echo 'stackato ALL=(root) NOPASSWD: ALL' >> /etc/sudoers"

# WARNING: Be sure you added stackato user ability to run sudo commands without password

kato process ready --block 180 cloud_controller_ng
kato node rename ${domain}
kato node setup core api.${domain}

