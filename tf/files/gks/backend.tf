terraform {
  backend "gcs" {
    bucket = "my-gks-devsecops-terraform-bucket"
    prefix = "jenkins-tfstate/terraform.tfstate"

    # Note: Terraform doesn't directly support Firestore as a lock mechanism
    # You will need to implement custom locking if needed (e.g., using Google Cloud Functions)
  }

  required_version = ">= 0.13.0"

  required_providers {
    google = {
      version = ">= 3.5.0"
      source  = "hashicorp/google"
    }
  }
}

# GCP Provider
provider "google" {

  project     = "axial-psyche-453016-h3"
  region      = "us-central1" # You can change this to your preferred region
}
