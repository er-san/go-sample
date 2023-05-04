resource "kubernetes_namespace" "go_sample" {
  metadata {
    name = var.app_name
  }
}

resource "kubernetes_deployment" "go_sample" {
  metadata {
    name = var.app_name
    labels = {
      app = var.app_name
    }
    namespace = var.app_name
  }
  spec {
    replicas = var.replica_count
    selector {
      match_labels = {
        app = var.app_name
      }
    }

    template {
      metadata {
        labels = {
          app = var.app_name
        }
      }

      spec {
        container {
          image             = "${var.image_registry}/${var.app_name}:${var.image_version}"
          image_pull_policy = "Never"
          liveness_probe {
            http_get {
              path = "/health"
              port = var.app_name
            }
            initial_delay_seconds = 5
            period_seconds        = 10
          }
          name = var.app_name
        }
      }
    }
  }
  wait_for_rollout = var.wait_for_rollout
}

resource "kubernetes_service" "go_sample" {
  metadata {
    name      = var.app_name
    namespace = var.app_name
  }
  spec {
    selector = {
      app = var.app_name
    }
    port {
      port = var.image_port
    }
    type = "LoadBalancer"
  }
  wait_for_load_balancer = false
}

output "deploy_name" {
  value = kubernetes_deployment.go_sample.metadata[0].name
}

output "deploy_image" {
  value = kubernetes_deployment.go_sample.spec[0].template[0].spec[0].container[0].image
}

output "service_port" {
  value = kubernetes_service.go_sample.spec[0].port[0].port
}

output "service_name" {
  value = kubernetes_service.go_sample.metadata[0].name
}
