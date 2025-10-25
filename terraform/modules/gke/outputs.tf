output "endpoint" {
  value = google_container_cluster.primary.endpoint # O el nombre de tu recurso cluster
}

output "cluster_ca_certificate" {
  value = google_container_cluster.primary.master_auth[0].cluster_ca_certificate
}  