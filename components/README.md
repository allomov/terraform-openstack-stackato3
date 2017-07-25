
### How to run

```
cd infrastructure
terraform get -update
terraform import -var-file=../terraform.tfvars openstack_images_image_v2.stackato_image <image-id>
terraform import -var-file=../terraform.tfvars openstack_images_image_v2.bastion_image <image-id>
terraform apply  -var-file=../terraform.tfvars
cd ..

cd bastion
terraform apply -var-file=../terraform.tfvars
terraform get -update
cd ..

cd stackato-microcloud

cd ..
```