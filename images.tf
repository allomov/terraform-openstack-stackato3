resource "openstack_images_image_v2" "stackato362" {
  name              = "Stackato-3.6.2"
  local_file_path   = "images/stackato-v362-openstack.qcow2"
  container_format  = "bare"
  disk_format       = "qcow2"
}
