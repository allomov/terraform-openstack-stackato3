# Install ansible

sudo apt-get install -y software-properties-common
sudo apt-add-repository -y ppa:ansible/ansible
sudo apt-get update
sudo apt-get install -y ansible

sudo ansible-galaxy install allomov.bosh-jumpbox

cat <<EOF > playbook.yml
---
- hosts: bastion
  roles:
  - role: allomov.bosh-jumpbox
EOF

cat <<EOF > ansible_hosts
[bastion]
localhost ansible_connection=local
EOF

sudo ansible-playbook -i ansible_hosts playbook.yml

sudo apt-get install git -y
ssh-keyscan github.com >> ~/.ssh/known_hosts

if [ ! -f ~/.ssh/host_id_rsa ]; then
  sudo mv host_id_rsa id_rsa
  sudo chmod 400 ~/.ssh/id_rsa
fi

# pushd /tmp
#   wget https://releases.hashicorp.com/terraform/0.9.11/terraform_0.9.11_linux_amd64.zip
#   sudo unzip terraform_0.9.11_linux_amd64.zip -d /usr/local/bin
#   wget http://downloads.stackato.com/client/v3.2.6/stackato-3.2.6-linux-glibc2.3-x86_64.zip
#   unzip stackato-3.2.6-linux-glibc2.3-x86_64.zip
#   sudo cp stackato-3.2.6-linux-glibc2.3-x86_64/stackato /usr/local/bin
# popd
