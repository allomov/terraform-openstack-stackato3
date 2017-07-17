# Install ansible

sudo apt-get install -y software-properties-common
sudo apt-add-repository -y ppa:ansible/ansible
sudo apt-get update
sudo apt-get install -y ansible

sudo ansible-galaxy install allomov.bosh-jumpbox

cat <<EOF > playbook.yml
---
- hosts: jumpbox
  roles:
  - role: allomov.bosh-jumpbox
EOF

cat <<EOF > ansible_hosts
[jumpbox]
localhost ansible_connection=local
EOF

sudo ansible-playbook -i ansible_hosts playbook.yml

sudo apt-get install git -y
ssh-keyscan github.com >> ~/.ssh/known_hosts
sudo chmod 400 ~/.ssh/id_rsa
git clone git@github.com:allomov/terraform-openstack-stackato3.git
cd terraform-openstack-stackato3

# wget -O images/helion-stackato.zip http://downloads.stackato.com/vm/v3.6.2/helion-stackato-v362-openstack.zip
# unzip images/helion-stackato.zip

# pushd /tmp
#   wget https://api.54.183.103.25.nip.io/static/stackato-3.2.4-linux-glibc2.3-x86_64.zip --no-check-certificate
#   unzip stackato-3.2.4-linux-glibc2.3-x86_64.zip
#   sudo mv stackato-3.2.4-linux-glibc2.3-x86_64/stackato /usr/local/bin/
# popd