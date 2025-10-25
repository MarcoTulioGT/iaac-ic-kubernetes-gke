output "endpoint" {
  value = gke_cluster.primary.endpoint 
}

output "cluster_ca_certificate" {
  value = gke_cluster.primary.master_auth[0].cluster_ca_certificate
}  