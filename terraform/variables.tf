variable "app_name" {
  type    = string
  default = "go-sample"
}

variable image_version {
    type = string
    default = "latest"
}

variable image_registry {
    type = string
    default = "docker.io/library"
}

variable image_port {
    type = number
    default = 8080
}

variable "replica_count" {
    type = number
    default = 2
}

variable "wait_for_rollout" {
  type    = bool
  default = true
}
