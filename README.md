### How to install

```
pip install python-openstackclient
pip install --upgrade python-openstackclient
cp .envrc{.example,}
cp terrafor.tfvars{.example,}
vi .envrc
openstack network list
vi terrafor.tfvars

terraform apply -target=openstack_compute_instance_v2.jumpbox

```