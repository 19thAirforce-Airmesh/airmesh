export DOCKER_API_VERSION=1.52
docker buildx build --platform linux/arm64,linux/amd64 --tag sosumi000/airmesh-control-server:latest --push .