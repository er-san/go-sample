app_name = "go-sample"
build:
	go build -o bin -v src/main.go
connect:
	kubectl --context minikube -n ${app_name} port-forward service/${app_name} 8080:8080
image:
	docker build . -t ${app_name}:latest
minikube_build:
	docker build -t "$$(minikube ip):5000/${app_name}:latest" .
minikube_load_image:
	minikube image load ${app_name}:latest
run:
	docker run --publish 8080:8080 ${app_name}:latest
terraform-apply:
	terraform -chdir=terraform apply
terraform-init:
	terraform -chdir=terraform init
terraform-plan:
	terraform -chdir=terraform plan
terraform-destroy:
	terraform -chdir=terraform destroy
terraform-refresh:
	terraform -chdir=terraform refresh
test:
	go test ./src/