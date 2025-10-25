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

# DATA SOURCE: Obtiene el token de autenticación de GCP (para el Provider de K8s)
data "google_client_config" "default" {}

# CONFIGURACIÓN DEL PROVIDER DE KUBERNETES (LA CLAVE)
provider "kubernetes" {

  host = "https://${module.gke_single_cluster.endpoint}" 
  token = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke_single_cluster.cluster_ca_certificate)
}

module "gke_resources" {
  source  = "../../modules/gke_resources"
  project_id   = var.project_id
  providers = {
    kubernetes = kubernetes
  }
}
