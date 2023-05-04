# Prerequisites:
* [install Minikube](https://minikube.sigs.k8s.io/docs/start/)
* [install Docker](https://docs.docker.com/get-docker/)
* [install Golang](https://go.dev/doc/install)
* [install Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
* [install Kubectl](https://kubernetes.io/docs/tasks/tools/)

## How to build and run service as if in production:
* minikube start
* make image
* minikube addons enable registry
* minikube image load go-sample:latest
* make terraform-apply
* make connect
* curl localhost:8080 or open localhost:8080 in browse

## Running tests:
* make test

## Reloading your code into minikube:
* make image
* minikube image load go-sample:latest
* kubectl -n go-sample rollout restart deploy go-sample