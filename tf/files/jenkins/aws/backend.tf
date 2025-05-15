terraform {
  backend "s3" {
    bucket         = "my-eks-devsecops-terraform-bucket"
    region         = "us-east-1"
    key            = "jenkins-tfstate/terraform.tfstate"
    dynamodb_table = "Terraform-Lock-Table"
    encrypt        = true
  }
  required_version = ">=0.13.0"
  required_providers {
    aws = {
      version = ">= 2.7.0"
      source  = "hashicorp/aws"
    }
  }
}
