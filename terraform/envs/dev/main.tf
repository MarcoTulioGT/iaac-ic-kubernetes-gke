# Define el proyecto y región
locals {
  project_id = var.project_id
  region     = var.region
}

module "gke_single_cluster" {
  source       = "../../modules/gke"
  project_id   = var.project_id
  region       = var.region
  cluster_name = var.cluster_name
}

module "gke_resources" {
  source      = "../../modules/gke_resources"
  project_id   = var.project_id
  region       = var.region
  cluster_name = var.cluster_name
}
