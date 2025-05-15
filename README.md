# 🚀 Three-Tier MERN Stack Web Application Deployment  using GCP GKS, Jenkins, ArgoCD, Prometheus and Grafana

![Three-Tier Banner](assets/images/three-tier.gif)

# 🚀 Configuring Production-Ready EKS Clusters with Terraform
![EKS- GitHub Actions- Terraform](assets/images/tf-eks.gif)

Welcome to the Three-Tier MERN Stack Web Application Deployment project! 🚀

This repository hosts the implementation of a Three-Tier Web App using ReactJS, NodeJS, and MongoDB, deployed on GCP GKS. The project covers a wide range of tools and practices for a robust and scalable DevOps setup.

## Table of Contents
- [Application Code](#application-code)
- [Jenkins Pipeline Code](#jenkins-pipeline-code)
- [Jenkins Server With Terraform](#jenkins-server-with-terraform)
- [Kubernetes Manifests Files](#kubernetes-manifests-files)
- [Project Details](#project-details)

## Application Code
The `app/` directory contains the source code for the Three-Tier Web Application. Dive into this directory to explore the frontend and backend implementations.

## Jenkins Pipeline Code
In the `jenkins/pipelines/` directory, you'll find Jenkins pipeline scripts. These scripts automate the CI/CD process, ensuring smooth integration and deployment of your application.

## Jenkins Server With Terraform
Explore the `tf/files/jenkins/` directory to find Terraform scripts for setting up the Jenkins Server on AWS and `tf/files/GKS/` for eks with modules that demonstrates the practical steps to set up and automate an GKS cluster. These scripts simplify the infrastructure provisioning process.

## Kubernetes Manifests Files
The `k8s/manifests/` directory holds Kubernetes manifests for deploying your application on GCP GKS. Understand and customize these files to suit your project needs.

## Project Details
🛠️ **Tools Explored:**
- Terraform & gcloud CLI for GCP infrastructure
- Jenkins, Sonarqube, Terraform, Kubectl, and more for CI/CD setup
- Helm, Prometheus, and Grafana for Monitoring
- ArgoCD for GitOps practices

🚢 **High-Level Overview:**
- IAM User service account setup & Terraform magic on gcp
- Jenkins deployment with GCP integration
- GKS Cluster creation & Load Balancer configuration
- Private ECR repositories for secure image management
- Helm charts for efficient monitoring setup
- GitOps with ArgoCD

📈 **The journey covered everything from setting up tools to deploying a Three-Tier app, ensuring data persistence, and implementing CI/CD pipelines.**


Happy Coding! 🚀
