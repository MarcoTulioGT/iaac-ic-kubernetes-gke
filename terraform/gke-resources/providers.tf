provider "kubernetes" {
  host                   = "https://${data.terraform_remote_state.gke_state.outputs.endpoint}"
  cluster_ca_certificate = base64decode(data.terraform_remote_state.gke_state.outputs.cluster_ca_certificate)
  token                  = data.google_client_config.default.access_token
}


resource "kubernetes_namespace" "api_namespace" {
  metadata {
    name = "apis"
  }
}

resource "kubernetes_namespace" "engines_namespace" {
  metadata {
    name = "engines"
  }
}

resource "kubernetes_namespace" "portals_namespace" {
  metadata {
    name = "portals"
  }
}


resource "kubernetes_namespace" "lakehouse_namespace" {
  metadata {
    name = "lakehouse"
  }
}