resource "google_compute_instance" "vm_instance" {
  name         = var.instance-name
  machine_type = "e2-medium" # t2.xlarge ~ 4 vCPU, 16 GB RAM
  zone         = "us-central1-a"

boot_disk {
  initialize_params {
    image = "ubuntu-os-cloud/ubuntu-2204-lts"
    size  = 30
    type  = "pd-standard"
  }
}
  network_interface {
    subnetwork = google_compute_subnetwork.public_subnet.id
    access_config {}  # Enables external IP
  }

  metadata_startup_script = file("./tools-install.sh")

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/${var.key-name}.pub")}"
  }

  tags = ["allow-jenkins"]

  service_account {
    email  = "sunnysingh-msr@axial-psyche-453016-h3.iam.gserviceaccount.com"
    scopes = ["cloud-platform"]
  }

  labels = {
    name = var.instance-name
  }
}