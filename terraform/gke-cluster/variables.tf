variable "project_id" {
  description = "ID del proyecto GCP"
  type        = string
}

variable "region" {
  description = "Región de GCP para el clúster"
  type        = string
  default     = "us-central1"
}

variable "cluster_name" {
  description = "Nombre base para el clúster GKE"
  type        = string
  default     = "prd-gke-app"
}