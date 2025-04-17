#
# Create a custom VPC and do not auto create networks.
#
resource "google_compute_network" "custom_vpc" {
  name                    = var.network_name
  auto_create_subnetworks = var.auto_create_subnetworks
  description             = var.network_description
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
  dynamic "secondary_ip_range" {
    for_each = lookup(each.value, "secondary_ip_ranges", {})
    content {
      range_name    = secondary_ip_range.key
      ip_cidr_range = secondary_ip_range.value
    }
  }
}

resource "google_compute_firewall" "ingress-allow-from-us-west1-all" {
  name    = "ingress-allow-from-us-west1-all"
  network = "custom"
  direction = "INGRESS"
  priority  = 1000
  allow {
    protocol = "all"
  }
  source_ranges = ["10.138.0.0/20"]
  depends_on = [google_compute_network.custom_vpc]
}
