locals {
  cluster-name = var.cluster-name
}

resource "google_compute_network" "vpc" {
  name                    = "${local.cluster-name}-vpc"
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
}


resource "google_compute_subnetwork" "public-subnet" {
  count        =  length(var.pub-cidr-block)
  name         = "${local.cluster-name}-public-${count.index}"
  ip_cidr_range = var.pub-cidr-block[count.index]
  region        = var.region
  network       = google_compute_network.vpc.name

  private_ip_google_access = false  # Allows instances without public IPs to reach Google APIs

 
}


resource "google_compute_subnetwork" "private-subnet" {
  count         = var.pri-subnet-count
  name          = "${local.cluster-name}-private-${count.index}"
  ip_cidr_range = var.pri-cidr-block[count.index]
  region        = var.region
  network       = google_compute_network.vpc.name
  
  # Private Google Access for GKE nodes
  private_ip_google_access = true

  secondary_ip_range {
    range_name    = "pods"
    //ip_cidr_range = var.pods_secondary_ranges[count.index]
    ip_cidr_range = var.pods_secondary_ranges[count.index]
  }
  secondary_ip_range {
    range_name    = "services"
    //ip_cidr_range = "var.services_secondary_ranges[count.index]"
     ip_cidr_range = var.services_secondary_ranges[count.index]
  }





}

resource "google_compute_router" "router" {
  name    = "${local.cluster-name}-router"
  region  = var.region
  network = google_compute_network.vpc.name
}



# Cloud NAT (Replaces AWS NAT Gateway + EIP)
resource "google_compute_router_nat" "nat" {
  name                               = "${local.cluster-name}-nat"
  router                             = google_compute_router.router.name
  region                             = var.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  
  subnetwork {
    name                    = google_compute_subnetwork.private-subnet[0].name
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}




resource "google_compute_firewall" "allow_https" {
  name    = "${local.cluster-name}-allow-https"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  source_ranges = ["0.0.0.0/0"] # Tighten this in production
  target_tags   = ["gke-node"]
}


resource "google_compute_firewall" "allow_all_egress" {
  name      = "${local.cluster-name}-allow-all-egress"
  network   = google_compute_network.vpc.name
  direction = "EGRESS"

  allow {
    protocol = "all"
  }

  destination_ranges = ["0.0.0.0/0"]
  
  target_tags        = ["gke-node"]
}

