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
          image = "${var.image_registry}/${var.app_name}:${var.image_version}"
          image_pull_policy = "Never"
          liveness_probe {
            http_get {
              path = "/health"
              port = var.app_name
            }
            initial_delay_seconds = 5
            period_seconds        = 10
          }
          name  = var.app_name
        }
      }
    }
  }
  wait_for_rollout = var.wait_for_rollout
}

resource "kubernetes_service" "go_sample" {
  metadata {
    name = var.app_name
    namespace = var.app_name
  }
  spec {
    selector = {
      app = var.app_name
    }
    port {
      port        = var.image_port
    }
    type = "LoadBalancer"
  }
  wait_for_load_balancer = false
}