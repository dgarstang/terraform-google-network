#
# Create a custom VPC and do not auto create networks.
#
resource "google_compute_network" "custom_vpc" {
  name                    = "custom"
  auto_create_subnetworks = false
  description             = "Custom network"
  routing_mode            = "REGIONAL"
}

#
# Create each requested subnet in the VPC.
#
resource "google_compute_subnetwork" "custom_subnet" {
  for_each      = var.subnets
  name          = each.key
  ip_cidr_range = each.value.ip_cidr_range
  region        = each.value.region
  network       = google_compute_network.custom_vpc.id
}
