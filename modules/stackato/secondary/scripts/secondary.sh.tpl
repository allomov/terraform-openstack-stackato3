#!/usr/bin/env bash

echo "stackato" | sudo -S bash -c "echo 'stackato ALL=(root) NOPASSWD: ALL' >> /etc/sudoers"

# WARNING: Be sure you added stackato user ability to run sudo commands without password

kato process ready --block 180 cloud_controller_ng
kato node attach -e ${first_role} ${core_ip}

if [ ! -f ~/.ssh/host_id_rsa ]; then
  sudo mv host_id_rsa id_rsa
  sudo chmod 400 ~/.ssh/id_rsa
fi

if [ ! -f ~/.ssh/host_id_rsa.pub ]; then
  sudo mv host_id_rsa id_rsa.pub
fi

${add_role_commands}

kato restart
sudo reboot
