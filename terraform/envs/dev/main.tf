# Define el proyecto y región
locals {
  project_id = var.project_id
  region     = var.region
}

# proveedor de Google Cloud
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

# Backend para almacenar el estado de Terraform 
terraform {
  backend "gcs" {
    bucket = "backend-terraform15"
    prefix = "gke-cluster"
  }
}

#Recurso: Clúster GKE
resource "google_container_cluster" "gke_cluster" {
  name                     = "${var.cluster_name}-cluster"
  location                 = local.region
  initial_node_count       = 1
  deletion_protection      = false

  # Configuración del clúster principal
  enable_autopilot         = false
  logging_service          = "logging.googleapis.com/container"
  monitoring_service       = "monitoring.googleapis.com/kubernetes"

  # Configuración de red
  network    = "default"
  subnetwork = "default"

  # Para un clúster privado 
#  master_authorized_networks_config {
#    cidr_blocks {
#      cidr_block   = "0.0.0.0/0"
#      display_name = "All"
#    }
#  }

  # Deshabilitar el node pool por defecto para gestionarlo por separado
  remove_default_node_pool = true
}

# Recurso: Node Pool 
resource "google_container_node_pool" "primary_nodes" {
  name       = "${var.cluster_name}-nodes"
  location   = local.region
  cluster    = google_container_cluster.gke_cluster.name

  node_count = 2

  node_config {
    machine_type = "e2-medium"
    disk_size_gb = 50
  }
}