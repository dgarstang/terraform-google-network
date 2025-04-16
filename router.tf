resource "google_compute_router" "nat_router" {
  name    = "nat-router"
  network = "custom" # Replace with var.network_name if using variables
  region  = "us-west1"
  depends_on = [google_compute_network.custom_vpc]
}

resource "google_compute_router_nat" "nat_config" {
  name                               = "nat-config"
  router                             = google_compute_router.nat_router.name
  region                             = google_compute_router.nat_router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ALL" # Options: "ERRORS_ONLY", "TRANSLATIONS_ONLY", "ALL"
  }
}

