resource "openstack_images_image_v2" "stackato_image" {
  name              = "${var.prefix}-stackato-3.6.2"
  local_file_path   = "../images/stackato-v362-openstack.qcow2"
  container_format  = "bare"
  disk_format       = "qcow2"
  lifecycle {
    prevent_destroy = true
    ignore_changes = ["*"]
  }
}

# data "openstack_images_image_v2" "bastion_image" {

# }

resource "openstack_images_image_v2" "bastion_image" {
  name              = "${var.prefix}-bastion"
  container_format  = "bare"
  disk_format       = "qcow2"
  lifecycle {
    prevent_destroy = true
    ignore_changes = ["*"]
  }
}
