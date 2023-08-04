# Docker Images

Base PythonBiellaGroup docker images

The aim of this project is to create default Docker image that everyone can use for building applications

# Images available:

- **Python base image**: this image it's used to build python with poetry
- **PDM**: Python base image with PDM support
- **Node**: base nodejs image
- **Ubuntu CI Image**: this image it's used by the infrastructure projects to build, push and launch code inside a deployment production server by ci/cd.

# Deploy a new image

If you want to create new images and launch the CI/CD pipeline you have to define a new tag and also make a new release.

You can define the new tag and release in the `RELEASE` section in the github repo:

Or you can create manually the tag by doing

```bash
# visualize the list of tags
git tag -l

# create a new tag
git tag 0.0.x

# push the tag and launch the pipeline
git push --tag 
```

The tags are defined by the following structure: `major.minor.patch`

And then make a new release to trigger the deploy pipeline.

# Debug and test an image

You can use the `makefile` inside this project to launch and debug the images with your local machine.

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
docker exec -ti <containerid> bash

# output logs of the container
docker logs -f <containerid>
```

# Pull and use an image

If you want to pull and use an image inside the registry you can do:
```bash
# docker login
docker login gitlab.com -u $TOKEN_NAME -p $TOKEN_PASSWORD

# build a specific image (with a version)
docker build -t gitlab.com .

```

The variables: `TOKEN_NAME` and `TOKEN_PASSWORD` are defined inside gitlab.

# Push manually an image to the registry

This procedure it's useful to check if you have the permission with your user to publish the image.

Remember that this is not the normal procedure, because the deployment it's done automatically by the CI/CD pipeline.

To push container images to ghcr, you need personal access token (PAT). The PAT token it's necessary and it's created by every user and it's not created at the group level. If you are an Admin in PythonBiellaGroup organization and if you gain to the token the right permissions, you can use the same key also to write in the docker and package registry of the PythonBiellaGroup organization.

This procedure it's working for public and private organization and repositories.

1. [Get PAT - personal access token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens): Personal Settings > Developer settings > [Personal access tokens](https://github.com/settings/tokens)
2. Follow this procedure to login, build the image, tag the image and then push to the registry.

```bash
# login to registry
export PAT=<your_github_token>
echo $PAT | docker login ghcr.io -u YOURNAME --password-stdin

# build the images
make docker_build

# push to registry
docker tag test-python-base ghcr.io/pythonbiellagroup/python-base:0.0.1
docker push ghcr.io/pythonbiellagroup/python-base:0.0.1

# inspect the images
docker inspect ghcr.io/pythonbiellagroup/python-base:0.0.1
```

**General consideration**: be sure to have the right permissions on your key and the organization support the inheritance of the personal keys. Also check always the url of the registry that for the organization is: `ghcr.io/<organization_name>/<image_name>:<tag>.
Remember also that it's better to create a **classic PAT** than a Fine-grained token that is still in Beta and sometime have problems.

## Other information

- Information regarding pipeline in Github and how to publish the docker, please check the [official github documentation](https://docs.github.com/en/actions/publishing-packages/publishing-docker-images)

- [GITHUB_TOKEN permission denied write package when build and push docker in github workflows](https://stackoverflow.com/questions/70646920/github-token-permission-denied-write-package-when-build-and-push-docker-in-githu)

- [Unable to login to GitHub Container Registry with GITHUB_TOKEN](https://stackoverflow.com/questions/70688119/unable-to-login-to-github-container-registry-with-github-token)

- [GHCR quickstart snippet](https://gist.github.com/yokawasa/841b6db379aa68b2859846da84a9643c)

- [GITHUB Action secrets](https://docs.github.com/en/rest/actions/secrets?apiVersion=2022-11-28)

- [Ultimate manual for Github Container Registry](https://nira.com/github-container-registry/)

- [Automatic token authentication](https://docs.github.com/en/actions/security-guides/automatic-token-authentication)

- [Configuring package's access control and visibility](https://docs.github.com/en/packages/learn-github-packages/configuring-a-packages-access-control-and-visibility#ensuring-workflow-access-to-your-package)