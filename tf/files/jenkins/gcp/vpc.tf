

resource "google_compute_network" "vpc" {
  name                    = var.vpc-name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "public_subnet" {
  name          = var.subnet-name
  ip_cidr_range = "10.0.1.0/24"
  region        = "us-central1"
  network       = google_compute_network.vpc.id
 
}

resource "google_compute_router" "router" {
  name    = "${var.vpc-name}-router"
  region  = "us-central1"
  network = google_compute_network.vpc.id
}

resource "google_compute_route" "default_internet_route" {
  name       = "default-route-to-internet"
  network    = google_compute_network.vpc.name
  dest_range = "0.0.0.0/0"
  next_hop_gateway = "default-internet-gateway"
  priority   = 1000
}


resource "google_compute_firewall" "allow_custom_ports" {
  name    = var.sg-name
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "8080", "9000", "9090"]
  }

  direction     = "INGRESS"
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["allow-jenkins"]
  description   = "Allow SSH, Jenkins, SonarQube, etc."
}

resource "google_compute_firewall" "allow_all_egress" {
  name    = "${var.sg-name}-egress"
  network = google_compute_network.vpc.name

  direction = "EGRESS"

  allow {
    protocol = "all"
  }

  destination_ranges = ["0.0.0.0/0"]
  description        = "Allow all outbound traffic"
}
