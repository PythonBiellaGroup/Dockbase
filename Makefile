.PHONY: docker
docker_build: ## build the docker image
	docker-compose -p test build

docker_build_python_base: ## build the base python docker image
	docker-compose -p test build python-base

docker_python: ## launch the python base image
	docker-compose -p test up --build -d python-base

docker_pdm: ## launch the pdm base docker image
	docker-compose -p test up --build -d pdm-base

docker_check: ## check the status of the images
	docker ps -a | grep "test"

docker_stop: ## stop the test images
	docker-compose -p test down

docker_stop_volume: ## stop the images and clean the volume
	docker-compose -p test down -v

docker_volume_prune: ## remove all the unused images and resources in docker
	docker volume prune

docker_volume_list: ## check the docker volume list
	docker volume list

.PHONY: help
help: ## Ask for help in the Makefile
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help