.PHONY: docker
docker_build:
	docker-compose -p test build

docker_python:
	docker-compose -p test up --build -d ai-python-base

docker_pdm:
	docker-compose -p test up --build -d ai-pdm-python-base

docker_check:
	docker ps -a | grep "test"

docker_stop:
	docker-compose -p test down

docker_stop_volume:
	docker-compose -p test down -v

docker_volume_prune:
	docker volume prune

docker_volume_list:
	docker volume list
