resource "google_container_cluster" "gke" {
  name     = var.cluster-name
  location = var.region

  network    = google_compute_network.vpc.name
 subnetwork = google_compute_subnetwork.private-subnet[0].name


  remove_default_node_pool = true
  initial_node_count       = 1

  ip_allocation_policy {
    cluster_secondary_range_name  = "pods"
    services_secondary_range_name = "services"
  }

  workload_identity_config {
    workload_pool = "axial-psyche-453016-h3.svc.id.goog"//yeah likhna hai
  }



  release_channel {
    channel = "REGULAR"
  }

  resource_labels = {
    name = var.cluster-name
    env  = var.env


    
  }




# private_cluster_config {
#   enable_private_nodes    = true
#   enable_private_endpoint = false  # or true if you only want internal access
#   master_ipv4_cidr_block  = "172.16.0.0/28"
# }

# master_authorized_networks_config {
#   cidr_blocks = [
#     {
#       cidr_block   = "203.0.113.10/32"  # Your office/Bastion/VPN IP
#       display_name = "Admin Access"
#     }
#   ]
# }

  addons_config {
    http_load_balancing {
      disabled = false
    }

    horizontal_pod_autoscaling {
      disabled = false
    }

    gce_persistent_disk_csi_driver_config {
      enabled = true
    }

    dns_cache_config {
      enabled = true
    }

    gke_backup_agent_config {
      enabled = false
    }
  }

}



# NodeGroups
resource "google_container_node_pool" "on_demand_pool" {
  name       = "on-demand-nodes"
  cluster    = google_container_cluster.gke.name
  location   = var.region

  node_config {
    machine_type = var.ondemand_machine_type
    labels = {
      type = "ondemand"
    }
    tags = ["on-demand-nodes"]
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
    service_account = "sunnysingh-msr@axial-psyche-453016-h3.iam.gserviceaccount.com"
    disk_size_gb    = 100
  }

  initial_node_count = var.desired_capacity_on_demand

  autoscaling {
    min_node_count = var.min_capacity_on_demand
    max_node_count = var.max_capacity_on_demand
  }

  upgrade_settings {
    max_surge       = 1
    max_unavailable = 1
  }
}


# resource "google_container_node_pool" "spot_pool" {
#   name       = "spot-nodes"
#   cluster    = google_container_cluster.gke.name
#   location   = var.region

#   node_config {
#     machine_type   = var.spot_machine_type
#     preemptible    = true
#     spot           = true
#     labels = {
#       type      = "spot"
#       lifecycle = "spot"
#     }
#     tags = ["spot-nodes"]
#     oauth_scopes = [
#       "https://www.googleapis.com/auth/cloud-platform"
#     ]
#     service_account = google_service_account.gke_node_sa.email
#     disk_size_gb    = 100
#   }

#   initial_node_count = var.desired_capacity_spot

#   autoscaling {
#     min_node_count = var.min_capacity_spot
#     max_node_count = var.max_capacity_spot
#   }

#   upgrade_settings {
#     max_surge       = 1
#     max_unavailable = 1
#   }
# }
