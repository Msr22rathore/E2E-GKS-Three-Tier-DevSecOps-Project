terraform {
  backend "gcs" {
    bucket = "my-gks-devsecops-terraform-bucket-1"
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
