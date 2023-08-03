# Docker Images

Base PythonBiellaGroup docker images

The aim of this project is to create default Docker image that everyone can use for building applications

## Images available:

- Python base image: this image it's used to build python with poetry
- PDM: Python base image with PDM support
- Node: base nodejs image
- Ubuntu CI Image: this image it's used by the infrastructure projects to build, push and launch code inside a deployment production server by ci/cd.

## Deploy a new image

If you want to create new images and launch the CI/CD pipeline you have to define a new tag.

```bash
# visualize the list of tags
git tag -l

# create a new tag
git tag 0.0.x

# push the tag and launch the pipeline
git push --tag 
```

The tags are defined by the following structure: `major.minor.patch`

## Debug and test an image

You can use the `makefile` inside this project to launch and debug the images with your local machine.

There is also a `pyproject.toml` that contains all our libraries that we are using in the projects so you can test also the python installation of the libraries.

```bash
# build the images
make docker_build

# visualize images builded
docker image ls

# startup container from image 
docker run --entrypoint "/bin/bash" --rm image:latest -c "sleep 24h"

# container hash id
docker ps

# log into the running container
docker exec -ti containerid bash

# output logs of the container
docker logs -f containerid
```

## Pull and use an image

If you want to pull and use an image inside the registry you can do:
```bash
# docker login
docker login gitlab.com -u $TOKEN_NAME -p $TOKEN_PASSWORD

# build a specific image (with a version)
docker build -t gitlab.com .

```

The variables: `TOKEN_NAME` and `TOKEN_PASSWORD` are defined inside gitlab.

## Push manually an image to the registry

This is something you don't have to do, because this process it's done automatically by the CI/CD pipeline.
```bash
docker login gitlab.com -u $TOKEN_NAME -p $TOKEN_PASSWORD

docker push gitlab.com
```

## Other informations

Informations regarding pipeline in Github and how to publish the docker, please check the [official github documentation](https://docs.github.com/en/actions/publishing-packages/publishing-docker-images)